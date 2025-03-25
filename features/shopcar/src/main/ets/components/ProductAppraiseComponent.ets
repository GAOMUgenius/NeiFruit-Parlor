import { ProductAppraise } from "../model/ProductAppraiseModel"


@Component
struct ProductAppraiseComponent {
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

@Component
export struct ProductAppraiseListComponent {
  @Prop productAppraise: ProductAppraise[]

  build() {
    List() {
      ForEach(this.productAppraise, (item: ProductAppraise) => {
        ListItem() {
          ProductAppraiseComponent({
            productAppraise: item
          })
        }
      },(item: ProductAppraise) => {
        // 检查 item.id 是否存在
      if (item.id!== undefined && item.id!== null) {
        return item.id.toString();
      }
      // 如果 id 不存在，返回一个唯一的标识符，例如对象的索引
      return this.productAppraise.indexOf(item).toString();
    })
    }
    .divider({ strokeWidth: 0.5, color: '#ffdedede', startMargin: 10, endMargin: 10 })
    .height('auto')
    .width('100%')
    .margin({ top: 15 })
  }
}