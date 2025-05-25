let showGlow = true;
let texts = {};

window.addEventListener('message', function(event) {
    if (event.data.action === 'show') {
        showGlow = event.data.showGlow !== false;
        texts = event.data.texts || {};
        document.querySelector('.daily').textContent = texts.daily || "DAILY";
        document.querySelector('.rewards').textContent = texts.rewards || "REWARDS";
        document.querySelector('.next-reward').textContent = texts.next_reward || "NEXT REWARD";
        const timerDiv = document.querySelector('.timer');
        if (timerDiv) timerDiv.style.display = event.data.showTimer ? 'flex' : 'none';
        renderRewards(event.data.rewards);
        document.body.style.display = 'flex';
        document.querySelector('.daily-rewards-modal').style.display = 'block';

        const now = new Date();
        const month = now.getMonth() + 1;
        const year = now.getFullYear();
        fetch('https://kdv_dailyRewards/checkall', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ month, year, rewards: event.data.rewards })
        }).then(res => res.json()).then(data => {
            for (let i = 0; i < window.lastRewards.length; i++) {
                window.lastRewards[i].status = data.statuses[i];
            }
            renderRewards(window.lastRewards);
        });
    }
    if (event.data.action === 'hide') {
        document.body.style.display = 'none';
        document.querySelector('.daily-rewards-modal').style.display = 'none';
    }
});

document.addEventListener('keydown', function(e) {
    if (e.key === "Escape") {
        document.body.style.display = 'none';
        document.querySelector('.daily-rewards-modal').style.display = 'none';
        fetch('https://kdv_dailyRewards/close', { method: 'POST' });
    }
});

function showNotify(message, type = "success") {
    let old = document.querySelector('.notify');
    if (old) old.remove();
    const notif = document.createElement('div');
    notif.className = `notify ${type}`;
    notif.textContent = message;
    document.body.appendChild(notif);
    setTimeout(() => notif.remove(), 2000);
}

document.addEventListener('click', function(e) {
    if (e.target.classList.contains('collect-btn')) {
        const box = e.target.closest('.reward-box');
        const dayLabel = box.querySelector('.day-label-bg').textContent;
        const day = parseInt(dayLabel.replace(/\D/g, ''), 10);
        const rewards = window.lastRewards || [];
        const reward = rewards[day - 1];
        const text = e.target.textContent.trim().toUpperCase();
        if (text === (texts.collect || "COLLECT")) {
            if (reward) {
                const now = new Date();
                const month = now.getMonth() + 1;
                const year = now.getFullYear();
                const rewardDate = `${year}-${String(month).padStart(2, '0')}-${String(day).padStart(2, '0')}`;
                fetch('https://kdv_dailyRewards/give', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        item: reward.item,
                        amount: reward.amount,
                        type: reward.type,
                        reward_date: rewardDate,
                        day: day
                    })
                });
                showNotify(
                    (texts.received || "You have received %s x%s")
                        .replace('%s', reward.label)
                        .replace('%s', reward.amount),
                    "success"
                );
                reward.status = "claimed";
                renderRewards(window.lastRewards);
            }
        } else if (text === (texts.locked || "LOCKED")) {
            showNotify(texts.not_time || "It's not time to claim this reward yet!", "error");
        }
    }
    if (e.target.classList.contains('collected-btn')) {
        showNotify(texts.already_claimed || "You have already claimed this reward!", "error");
    }
});

function renderRewards(rewards) {
    window.lastRewards = rewards;
    const grid = document.getElementById('rewards-grid');
    grid.innerHTML = "";
    const now = new Date();
    const daysInMonth = getDaysInMonth(now.getMonth() + 1, now.getFullYear());
    let row;
    for (let i = 0; i < daysInMonth; i++) {
        if (i % 7 === 0) {
            row = document.createElement('div');
            row.className = 'rewards-row';
            grid.appendChild(row);
        }
        const reward = rewards[i] || {};
        const glowClass = showGlow ? `glow-${reward.glow || 'white'}` : '';
        const box = document.createElement('div');
        box.className = `reward-box ${glowClass}${reward.status ? ' ' + reward.status : ''}`;
        box.innerHTML = `
            <div class="item-header">
                <span class="day-label"><span class="day-label-bg">${(texts.day || "DAY")} ${i + 1}</span></span>
            </div>
            <div class="item-icon-frame">
                <div class="icon">
                    <img src="imgs/${reward.item || 'default'}.png" alt="${reward.item || ''}" onerror="this.onerror=null;this.src='imgs/default.png';">                </div>
            </div>
            <div class="item-footer">
                <span class="reward-label">${reward.label || ''}</span>
                <span class="reward-amount">${reward.amount ? 'x' + reward.amount : ''}</span>
            </div>
            ${
                reward.status === 'collect'
                    ? `<button class="collect-btn">${texts.collect || "COLLECT"}</button>`
                    : reward.status === 'claimed'
                        ? `<button class="collected-btn">${texts.collected || "COLLECTED"}</button>`
                        : `<button class="collect-btn">${texts.locked || "LOCKED"}</button>`
            }
        `;
        row.appendChild(box);
    }
    updateTimerAndDay();
}

function updateTimerAndDay() {
    let currentDay = 1;
    if (window.lastRewards) {
        currentDay = window.lastRewards.filter(r => r.status === "claimed").length;
        if (currentDay > window.lastRewards.length) currentDay = window.lastRewards.length;
    }
    const dayElem = document.querySelector('.timer-day');
    if (dayElem) {
        dayElem.textContent = `${texts.day || "DAY"} ${currentDay}`;
    }
    const now = new Date();
    const tomorrow = new Date(now.getFullYear(), now.getMonth(), now.getDate() + 1, 0, 0, 0);
    const diff = tomorrow - now;
    let hours = String(Math.floor(diff / (1000 * 60 * 60))).padStart(2, '0');
    let minutes = String(Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60))).padStart(2, '0');
    let seconds = String(Math.floor((diff % (1000 * 60)) / 1000)).padStart(2, '0');
    const timerTextElem = document.querySelector('.timer-text');
    if (timerTextElem) {
        timerTextElem.textContent = (texts.timer || "%sH : %sM : %sS")
            .replace('%s', hours).replace('%s', minutes).replace('%s', seconds);
    }
}

setInterval(updateTimerAndDay, 1000);

function getDaysInMonth(month, year) {
    return new Date(year, month, 0).getDate();
}