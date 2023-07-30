// import { Controller } from "@hotwired/stimulus"

// // Connects to data-controller="requests"
// export default class extends Controller {
//   static targets = ["response"];

//   connect() {
//     console.log("Request Controller connected");
//   }

//   createRequest() {
//     const projectId = this.data.get("projectId");
//     const csrfToken = this.data.get("csrfToken");
//     const currentUserId = parseInt(this.data.get("userId"));

//     fetch(`/projects/${projectId}/requests`, {
//       method: "POST",
//       headers: {
//         "Content-Type": "application/json",
//         "X-CSRF-Token": csrfToken,
//       },
//       body: JSON.stringify({
//         request: {
//           status: "pending"
//           user_id: currentUserId,
//         },
//       }),
//     })
//       .then((response) => response.json())
//       .then((data) => {
//         this.responseTarget.textContent = data.message;
//       })
//       .catch((error) => {
//         console.error("Error creating request:", error);
//       });
//   }
// }
