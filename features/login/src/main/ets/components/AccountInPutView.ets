@Component
export struct AccountInputView {
  @Link text: string
  @Link textinput: string
  build() {
    Column() {
      Text(this.text)
        .fontSize(15)
        .fontFamily('HarmonyHeiTi')
        .fontWeight(FontWeight.Medium)
        .width('80%')
        .fontColor('#ff201d5d')
        .grayscale(0)
        .margin({ bottom: 10 })

      TextInput({ text: this.textinput })
        .type(InputType.Email)
        .width('80%')
        .onChange((value: string) => {
          this.textinput = value
        })
        .margin({ bottom: 10 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }
}