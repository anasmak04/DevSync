document.addEventListener('DOMContentLoaded', async function() {
    var searchInput = document.getElementById('searchInput');

    var eventsList = document.getElementById('events-list');
    var eventsList1 = document.getElementById('events-listt');

    searchInput.addEventListener('input', async function() {
        var query = this.value;

        try {
            const response = await fetch(`/user/search?query=${query}`);

            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            const data = await response.json();
            console.log(data);

            eventsList1.style.display = 'none';
            eventsList.innerHTML = '';

            data.forEach(event => {
                const eventCard = `
            <div class="col-xl-3 col-lg-4 col-md-6">
                <div class="gallery-item h-100">
                    <img src="${event.media_url}" class="img-fluid" alt="" style="width: 500px;height:350px;object-fit:cover;">
                    <div class="gallery-links d-flex align-items-center justify-content-center">
                        <a href="../user/home/${event.id}" class="details-link"><i class="bi bi-eye"></i></a>

                    </div>
                </div>
            </div>`;
                eventsList.insertAdjacentHTML('beforeend', eventCard);
            });
        } catch (error) {
            console.error('Error:', error);
        }
    });
});












//filter
function filterByCategory(categoryId) {
    var events = document.querySelectorAll('.gallery-item');

    events.forEach(function(event) {
        var eventCategory = event.getAttribute('data-category');

        if (!categoryId || eventCategory == categoryId) {
            event.style.display = 'block';
        } else {
            event.style.display = 'none';
        }
    });
}
