import { PayManageData, PayManageInfo } from "../model/PayManageModel"

@Component
export struct PayManangeView {

  build() {
    Row() {
      ForEach(PayManageInfo, (item: PayManageData) => {
        PayManageItem({
          title: item.title,
          img: item.img
        })
          .margin({ top: 20, bottom: 20 })
      })
    }
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.SpaceEvenly)
    .width('90%')
    .borderRadius(15)
  }
}

@Component
struct PayManageItem {
  @Prop title: string
  @Prop img: Resource
  build() {
    Column() {
      Image(this.img)
        .size({
          width: 30,
          height: 30
        })
        .margin({ bottom: 10 })
      Text(this.title)
        .fontSize(15)
    }
    .alignItems(HorizontalAlign.Center)
  }
}