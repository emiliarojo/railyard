import { Controller } from 'stimulus';

export default class extends Controller {
  connect() {
    this.element.addEventListener('blur', this.saveChanges.bind(this));
    this.element.addEventListener('keypress', this.checkEnterKey.bind(this));
    // Add the click event listener for the edit icon
    const editIcons = this.element.querySelectorAll('i.fa-pen-to-square');
    editIcons.forEach((icon) => {
      icon.addEventListener('click', this.enableEdit.bind(this));
    });
  }

  enableEdit(event) {
    event.preventDefault();
    // Check if the event target is the icon element
    if (!event.target.classList.contains('fa-pen-to-square')) {
      return;
    }
    // Get the span element containing the text
    const spanElement = event.target.closest('span');
    if (spanElement) {
      // Make the element editable
      spanElement.contentEditable = true;
      // Save the original value in the data-original-value attribute
      spanElement.dataset.originalValue = spanElement.textContent.trim();
      // Set the data-field attribute to indicate the field being edited
      spanElement.dataset.field = spanElement.dataset.field || spanElement.getAttribute('data-field');
      // Focus on the element so that the user can start typing immediately
      spanElement.focus();
    }
  }

  saveChanges() {
    const field = this.element.dataset.field;
    const newValue = this.element.textContent.trim();

    if (newValue !== '') {
      const csrfToken = document.querySelector('[name="csrf-token"]').content;
      const userId = this.element.dataset.userId;

      fetch(`/users/${userId}`, {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrfToken,
        },
        body: JSON.stringify({ field: field, user: { [field]: newValue } }), // Updated payload
      })
        .then(response => response.json())
        .then(data => {
          this.element.textContent = data[field];
        })
        .catch(error => {
          console.error('Error updating user:', error);
        });
    } else {
      // If the field is empty, reset to the original value
      this.element.textContent = this.originalValue;
    }
  }

  checkEnterKey(event) {
    if (event.key === 'Enter') {
      event.preventDefault();
      this.element.blur();
    }
  }

  get originalValue() {
    return this.element.dataset.originalValue;
  }
}
