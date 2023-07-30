import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="skills"
export default class extends Controller {
  static targets = ["skillName"];

  connect() {
    console.log("skills_controller connected!");
  }

  toggleHighlight(event) {
    const skillName = event.currentTarget;
    skillName.classList.toggle("selected-skill");
    const checkbox = skillName.querySelector("input[type='checkbox']");
    checkbox.checked = !checkbox.checked;
  }
}
