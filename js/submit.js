document.addEventListener('DOMContentLoaded', function() {
    const submitButton = document.getElementById('submitButton');
    const form = document.getElementById('reportForm');  // Ensure you select the form correctly
    const overlay = document.querySelector('.form-popup');  // Select the form-popup as the overlay

    submitButton.addEventListener('click', function(event) {
        event.preventDefault();  // Prevent the default form submission

        if (!form) {
            console.error("Form element not found!");
            return;
        }

        // Create a FormData object
        const formData = new FormData(form);

        // Send the FormData via fetch
        fetch('php/awts.php', {
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert(data.success);  // Show success message
                form.reset();  // Reset the form after submission
                form.style.display = 'none';  // Hide the form

                // Hide the overlay (form-popup background)
                if (overlay) {
                    overlay.style.display = 'none';  // Remove the overlay
                }
            } else if (data.error) {
                alert(data.error);  // Show error message
            }
        })
        .catch(error => {
            console.error('Error:', error);
        });
    });
});
