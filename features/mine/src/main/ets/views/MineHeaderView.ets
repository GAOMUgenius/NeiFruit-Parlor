
@Component
export struct MineHeaderView {

  build() {
    Row() {
      Text('我的')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Start)
        .margin({ left: 15 })

      Image($r('app.media.setting'))
        .size({
          width: 25,
          height: 25
        })
        .margin({ right: 15 })

    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}