document.getElementById('secondFloor').style.display = 'none';

let lastClonedPin = null; // Track the most recently cloned pin
let pinPlacedManually = false; // Flag to track if a pin was placed manually

function showFloor(floor) {
    const firstFloor = document.getElementById('firstFloor');
    const secondFloor = document.getElementById('secondFloor');
    
    if (floor === 1) {
        firstFloor.style.display = 'block';
        secondFloor.style.display = 'none';
    } else if (floor === 2) {
        firstFloor.style.display = 'none';
        secondFloor.style.display = 'block';
    }
}

function addPathListeners(paths, svgId) {
    const nameLabel = document.getElementById('name');
    const slidingColumn = document.getElementById('slidingColumn');

    paths.forEach(path => {
        path.addEventListener('mouseover', () => {
            nameLabel.style.opacity = '1';
            nameLabel.querySelector('#namep').innerText = `${svgId} - ${path.id}`;
        });

        path.addEventListener('mousemove', (e) => {
            nameLabel.style.left = `${e.pageX + 10}px`;
            nameLabel.style.top = `${e.pageY - 20}px`;
        });

        path.addEventListener('mouseout', () => {
            nameLabel.style.opacity = '0';
        });

        path.addEventListener('click', () => {
            slidingColumn.classList.add('show');
            document.getElementById('pins').innerHTML = `<div class="pin">You clicked on: ${svgId} - ${path.id}</div>`;
        });
    });
}

addPathListeners(document.querySelectorAll('#firstFloor .allPaths'), 'First Floor');
addPathListeners(document.querySelectorAll('#secondFloor .allPaths'), 'Second Floor');

document.getElementById("closeButton").addEventListener("click", function () {
    document.getElementById("slidingColumn").classList.remove("show");
});

let pinPositions = [];

function savePinPositions() {
    try {
        const positionsWithImages = pinPositions.map(position => {
            const pinElement = document.getElementById(position.pinId);
            const img = pinElement.querySelector('img');
            return {
                ...position,
                imgSrc: img ? img.src : null
            };
        });
        localStorage.setItem("pinPositions", JSON.stringify(positionsWithImages));
    } catch (e) {
        console.error("Error saving pin positions to localStorage", e);
    }
}

function loadPinPositions() {
    try {
        const savedPositions = JSON.parse(localStorage.getItem("pinPositions"));
        if (savedPositions) {
            savedPositions.forEach(position => {
                const pinElement = document.createElement('div');
                pinElement.classList.add('pin');
                pinElement.style.position = 'absolute';
                pinElement.style.top = position.top;
                pinElement.style.left = position.left;
                pinElement.id = position.pinId;
                document.getElementById("mapContainer").appendChild(pinElement);

                const img = document.createElement('img');
                img.src = position.imgSrc;
                pinElement.appendChild(img);

                pinElement.addEventListener('click', () => {
                    showPinOptions(pinElement, position.pinId);
                });

                pinPositions.push(position);
            });
        }
    } catch (e) {
        console.error("Error loading pin positions from localStorage", e);
    }
}

document.addEventListener('DOMContentLoaded', function () {
    const mapContainer = document.getElementById('mapContainer');

    function makeDraggable(pin) {
        let isDragging = false;
        let offsetX, offsetY;

        function onMouseMove(e) {
            if (isDragging) {
                pin.style.position = 'absolute';
                pin.style.left = `${e.clientX - offsetX}px`;
                pin.style.top = `${e.clientY - offsetY}px`;
            }
        }

      function onMouseUp() {
    isDragging = false;

    const confirmPosition = confirm('Do you want to confirm the pin\'s position?');
    if (confirmPosition) {
        pin.style.position = 'absolute';
        const pinId = pin.id;
        pinPositions = pinPositions.filter(p => p.pinId !== pinId);
        pinPositions.push({
            pinId: pinId,
            top: pin.style.top,
            left: pin.style.left
        });
        savePinPositions();

        pin.removeEventListener('mousedown', onMouseDown);
        pin.removeEventListener('mousemove', onMouseMove);
        pin.removeEventListener('mouseup', onMouseUp);

        pin.addEventListener('click', () => {
            if (!pinPlacedManually) {
                showPinOptions(pin, pinId);
            }
        });

        openForm();
        pinPlacedManually = true;
    } else {
        // Reset the pin operation by removing the pin
        const mapContainer = document.getElementById("mapContainer");
        if (pin.parentNode === mapContainer) {
            mapContainer.removeChild(pin);
        }

        // If it's a cloned pin, reset `lastClonedPin`
        if (lastClonedPin === pin) {
            lastClonedPin = null;
        }
    }

    document.removeEventListener('mousemove', onMouseMove);
    document.removeEventListener('mouseup', onMouseUp);
}


        function onMouseDown(e) {
            isDragging = true;
            offsetX = e.clientX - pin.getBoundingClientRect().left;
            offsetY = e.clientY - pin.getBoundingClientRect().top;

            document.addEventListener('mousemove', onMouseMove);
            document.addEventListener('mouseup', onMouseUp);
        }

        pin.addEventListener('mousedown', onMouseDown);
    }

    function clonePin(pin, x, y) {
        const clone = pin.cloneNode(true);
        const pinId = `pin-${Date.now()}`;
        clone.id = pinId;
        clone.style.position = 'absolute';
        clone.style.left = `${x}px`;
        clone.style.top = `${y}px`;
        mapContainer.appendChild(clone);

        const img = clone.querySelector('img');
        const imgSrc = img ? img.src : null;

        pinPositions.push({
            pinId: pinId,
            top: clone.style.top,
            left: clone.style.left,
            imgSrc: imgSrc
        });

        savePinPositions();

        lastClonedPin = clone;

        makeDraggable(clone);
        clone.addEventListener('click', () => {
            if (!pinPlacedManually) {
                showPinOptions(clone, pinId);
            }
        });
    }

    function enablePinPlacement(icon) {
        icon.addEventListener('click', function (e) {
            const mapRect = mapContainer.getBoundingClientRect();
            const x = e.clientX - mapRect.left;
            const y = e.clientY - mapRect.top;
            clonePin(icon, x, y);
        });
    }

    enablePinPlacement(cautionIcon);
    enablePinPlacement(cleaningIcon);
    enablePinPlacement(electricalIcon);
    enablePinPlacement(itIcon);
    enablePinPlacement(repairIcon);
    enablePinPlacement(requestIcon);
});

// Show modal with pin options
function showPinOptions(pinElement, pinId) {
    if (document.querySelector('.custom-modal')) {
        return;
    }

    const modal = document.createElement('div');
    modal.classList.add('custom-modal');
    modal.style.position = 'absolute';
    modal.style.width = '200px';
    modal.style.height = '140px'; // Default height
    modal.style.backgroundColor = '#042331';
    modal.style.border = '1px solid #ccc';
    modal.style.borderRadius = '8px';
    modal.style.padding = '10px';
    modal.style.boxShadow = '0 2px 10px rgba(0, 0, 0, 0.2)';

    const heightLimit = 30;
    const pinRect = pinElement.getBoundingClientRect();
    const modalTop = pinRect.top - 100;
    const modalLeft = pinRect.left;
    const viewportHeight = window.innerHeight;

    if (modalTop < heightLimit) {
        // Position below the pin
        const availableSpaceBelow = viewportHeight - pinRect.bottom - 10; // Space below the pin
        modal.style.top = `${pinRect.bottom + 100   }px`;
        modal.style.height = `${Math.min(140, availableSpaceBelow)}px`; // Adjust modal height to fit the space below
    } else {
        // Position above the pin
        modal.style.top = `${modalTop}px`;
    }
    modal.style.left = `${modalLeft}px`;

    const statusButton = document.createElement('button');
    statusButton.textContent = 'Status';
    const removeButton = document.createElement('button');
    removeButton.textContent = 'Remove Pin';
    const closeButton = document.createElement('button');
    closeButton.textContent = 'Close';

    modal.appendChild(statusButton);
    modal.appendChild(removeButton);
    modal.appendChild(closeButton);

    document.body.appendChild(modal);

    statusButton.addEventListener('click', () => {
        window.location.href = '/pages/status.html';
        document.body.removeChild(modal);
    });

    removeButton.addEventListener('click', () => {
        if (confirm('Are you sure you want to remove this pin?')) {
            const mapContainer = document.getElementById('mapContainer');
            mapContainer.removeChild(pinElement);

            pinPositions = pinPositions.filter(p => p.pinId !== pinId);
            savePinPositions();
        }
        document.body.removeChild(modal);
    });

    closeButton.addEventListener('click', () => {
        document.body.removeChild(modal);
    });
}


window.onload = function() {
    loadPinPositions();
};

function openForm() {
    document.getElementById("myForm").style.display = "block";
}

function closeForm() {
    document.getElementById("myForm").style.display = "none";

    if (lastClonedPin) {
        const mapContainer = document.getElementById("mapContainer");
        mapContainer.removeChild(lastClonedPin);
        lastClonedPin = null;
    }
}

document.getElementById("cancelRequestButton").addEventListener('click', closeForm);