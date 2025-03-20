import { ProductAppraise } from "../model/ProductInfoModel"

@Component
export struct ProductAppraiseComponent {
  @Prop productAppraise: ProductAppraise

  build() {
    Row() {
      Column() {
        Row() {
          Image(this.productAppraise.user_picture)
            .size({
              width: 20,
              height: 20
            })
            .borderRadius(10)
            .margin({ left: 15 })
          Text(this.productAppraise.user_name)
            .fontSize(12)
            .fontWeight(FontWeight.Normal)
            .margin({ left: 5 })
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Start)
        .width('100%')

        Row() {
          Blank()
            .width(30)

          Text(this.productAppraise.user_content)
            .fontWeight(FontWeight.Regular)
            .maxLines(2)
            .fontSize(12)
            .margin({ top: 10 })
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .flexShrink(1)
            .textAlign(TextAlign.Start)
            .margin({ top: 20 })
            .width('100%')
        }
      }
      .justifyContent(FlexAlign.Start)
      .height('100%')
      .layoutWeight(1)
      .margin({ top: 10 })

      Image(this.productAppraise.user_content_picture[0])
        .size( {
          height: 70,
          width: 70
        })
        .objectFit(ImageFit.Cover)

    }
    .height(100)
  }
}