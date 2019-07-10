App.cable.subscriptions.create('PageChannel', {
  connected() {
    if (gon.page_id)
      this.perform('follow', { id: gon.page_id })
  },
  received(data){
    console.log(data)
    result = $.parseJSON(data)
  }
})
