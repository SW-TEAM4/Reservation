const maxSelector = document.getElementById('max-selector');
const typeSelector = document.getElementById('type-selector');
const weightSelector = document.getElementById('weight-selector');

function createDropdown(options, callback) {
    const dropdown = document.createElement('div');
    dropdown.classList.add('dropdown');

    options.forEach(option => {
        const item = document.createElement('div');
        item.classList.add('dropdown-item');
        item.textContent = option;
        item.onclick = () => {
            callback(option);
            dropdown.style.display = 'none';
        };
        dropdown.appendChild(item);
    });

    return dropdown;
}

// Guest Selector
maxSelector.addEventListener('click', () => {
    const dropdown = createDropdown(['성인 2, 반려동물 1', '성인 3, 반려동물 0'], (selection) => {
        maxSelector.querySelector('span').textContent = selection;
    });
    document.body.appendChild(dropdown);
    dropdown.style.display = 'block';
});

// Accommodation Selector
typeSelector.addEventListener('click', () => {
    const dropdown = createDropdown(['펜션', '글램핑'], (selection) => {
        typeSelector.querySelector('span').textContent = selection;
    });
    document.body.appendChild(dropdown);
    dropdown.style.display = 'block';
});

// Weight Selector
weightSelector.addEventListener('click', () => {
    const dropdown = createDropdown(['5kg 미만', '5kg 이상 ~ 10kg이하', '10kg 초과'], (selection) => {
        weightSelector.querySelector('span').textContent = selection;
    });
    document.body.appendChild(dropdown);
    dropdown.style.display = 'block';
});

tabs.forEach(tab => {
    tab.addEventListener('click', (e) => {
        tabs.forEach(t => t.classList.remove('active'));
        tabs.forEach(t => t.classList.add('inactive'));
        e.target.classList.remove('inactive');
        e.target.classList.add('active');
    });
});