import { Controller } from "stimulus";

export default class extends Controller {
  connect() {
    this.toggleSelectedClass();
  }

  toggleSelectedClass() {
    const skillButtons = this.element.querySelectorAll(".skill-button");

    skillButtons.forEach((button) => {
      button.addEventListener("click", () => {
        if (button.checked === true) {
          button.checked = false;
        }
        if (button.checked === false) {
          button.checked = true;
        }
        button.classList.toggle("selected");
      });
    });
  }
}
