import { PayManageData, PayManageInfo } from "../model/PayManageModel"

@Component
export struct PayManangeView {

  build() {
    Row() {
      Row() {
        ForEach(PayManageInfo, (item: PayManageData) => {
          PayManageItem({
            title: item.title,
            img: item.img
          })
            .margin({ top: 20, bottom: 20 })
        })
      }
      .height('100%')
      .width('90%')
      .borderRadius(15)
      .backgroundColor(Color.White)
      .justifyContent(FlexAlign.SpaceEvenly)

      Text('全\n部\n订\n单')
        .textAlign(TextAlign.Center)
        .fontColor(Color.Gray)
        .fontSize(10)
        .height('100%')
        .width('10%')
    }
    .backgroundColor('#ffe9e9e9')
    .justifyContent(FlexAlign.SpaceEvenly)
    .width('90%')
    .height('13%')
    .borderRadius(15)
  }
}

@Component
struct PayManageItem {
  @Prop title: string
  @Prop img: Resource
  build() {
    Column() {
      Stack() {
        Row() {}
        .size({
          height: 10,
          width: 10
        })
        .margin({
          bottom: 7
        })
        .borderRadius(5)
        .backgroundColor('#e2a6f6f6')

        Image(this.img)
          .size({
            width: 25,
            height: 25
          })
          .margin({ bottom: 5 })
      }
      .alignContent(Alignment.BottomEnd)

      Text(this.title)
        .fontSize(13)
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}