import { ProductData } from "uicomponents"

@Component
export struct ShopProductComponent {
  @Prop shopProduct: ProductData

  build() {
    Row() {
      Image(this.shopProduct.product_picture)
        .size({
          width: 80,
          height: 80
        })
        .borderRadius(10)
        .margin({ left: 5 })

      Column() {
        //商品信息区域
        Row() {
          Text(`${this.shopProduct.product_name} `) // 添加空格分隔
            .fontWeight(FontWeight.Bold)
            .fontSize(13)
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .flexShrink(1)

          Text(this.shopProduct.product_capacity.toString() + this.shopProduct.product_capacity_unit)
            .fontWeight(FontWeight.Bold)
            .fontSize(13)
            .flexShrink(0) // 禁止容量部分被截断
        }
        .width('50%')
        .margin({ left: 5, bottom: 8 })
        .alignItems(VerticalAlign.Top) // 顶部对齐
        .justifyContent(FlexAlign.Start) // 确保内容从行首开始排列

        //价格区域
        Row() {
          Text('￥')
            .fontWeight(FontWeight.Bold)
            .fontColor('#fffd2626')
            .fontSize(15)
          Text(this.shopProduct.product_price.toString())
            .fontWeight(FontWeight.Bold)
            .fontColor('#fffd2626')
            .fontSize(20)
          Text('/' + this.shopProduct.product_unit)
            .fontWeight(FontWeight.Medium)
            .fontSize(10)
            .fontColor(Color.Gray)
        }
        .width('45%')
        .alignItems(VerticalAlign.Bottom)
        .justifyContent(FlexAlign.Start)
      }

      Button('抢购')
        .width(60)
        .fontSize(12)
        .height(30)
        .backgroundColor('#ff22c1ff')
        .fontColor(Color.White)

    }
  }
}