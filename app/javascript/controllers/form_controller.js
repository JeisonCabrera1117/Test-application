import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['content']

  onPostError (event) {
    const [data] = event.detail
    this.contentTarget.innerHTML = new XMLSerializer().serializeToString(data)
  }

  onPostSuccess (event) {
    console.log('satisfactorio')
    const [data] = event.detail
    this.contentTarget.innerHTML = new XMLSerializer().serializeToString(data)
  }

}
