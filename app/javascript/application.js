// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import "@hotwired/turbo-rails"
import "controllers"
import 'bootstrap'


document.addEventListener('turbo:load', () => {
  const statusForms = document.querySelectorAll('.update-status-form');

  statusForms.forEach(form => {
    form.addEventListener('submit', async (event) => {
      event.preventDefault();
      const formData = new FormData(form);
      const response = await fetch(form.action, {
        method: 'PATCH',
        body: formData,
        headers: { 'Accept': 'text/vnd.turbo-stream.html' }
      });

      if (response.ok) {
        Turbo.renderStreamMessage(response.body);
      } else {
        console.error('Failed to update status');
      }
    });
  });
});
