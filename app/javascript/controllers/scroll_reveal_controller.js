import { Controller } from "@hotwired/stimulus"
import ScrollReveal from 'scrollreveal';

// Connects to data-controller="scroll-reveal"
export default class extends Controller {
  connect() {
    ScrollReveal().reveal(this.element, {
      delay: 5,
      scale: 1.5
    })
  }
}
