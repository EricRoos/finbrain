import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log('Hello Form');
  }

  refresh(event){
    const {
      currentTarget
    } = event;
    const responseStatus = event.detail.fetchResponse.response.status;
    if(responseStatus === 200){
      currentTarget.reload();
    }
  }
}
