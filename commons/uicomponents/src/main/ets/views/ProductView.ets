import { ProductData, productDataSource, ProductData_List } from '../model/ProductModel'

@Component
export struct ProductView {

  build() {
    WaterFlow({ footer: (): void => this.itemFoot() }){
      LazyForEach(productDataSource, (item: ProductData) => {
        FlowItem() {
          ProductItem({
            product_picture: item.product_picture,
            product_name: item.product_name,
            product_price: item.product_price,
            product_unit: item.product_unit,
            product_capacity: item.product_capacity,
            product_capacity_unit: item.product_capacity_unit
          })
        }
      })
    }
    .layoutWeight(1)
    .layoutDirection(FlexDirection.Column)
    .columnsTemplate('1fr 1fr')
    .columnsGap(8)
    .rowsGap(8)
    .width('90%')
  }

  @Builder
  itemFoot() {
    Column() {
      Text('已经到底了')
        .fontColor(Color.Gray)
        .fontSize(10)
        .width('100%')
        .height(20)
        .textAlign(TextAlign.Center)
    }
  }

}


@Component
struct ProductItem {
  @Prop product_picture: ResourceStr
  @Prop product_name: string
  @Prop product_price: string
  @Prop product_unit: string
  @Prop product_capacity: string
  @Prop  product_capacity_unit: string
  build() {
    Column() {
      Image(this.product_picture)
        .size({
          height: 150,
          width: '45%'
        })
        .margin({
          top: 10,
          right: 10,
          left: 10,
          bottom: 15
        })
        .borderRadius(15)

      //商品信息区域
      Row() {
        Text(`${this.product_name} `) // 添加空格分隔
          .fontWeight(FontWeight.Bold)
          .fontSize(13)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .flexShrink(1)

        Text(this.product_capacity + this.product_capacity_unit)
          .fontWeight(FontWeight.Bold)
          .fontSize(13)
          .flexShrink(0) // 禁止容量部分被截断
      }
      .width('45%')
      .margin({ bottom: 8 })
      .alignItems(VerticalAlign.Top) // 顶部对齐
      .justifyContent(FlexAlign.Start) // 确保内容从行首开始排列

      Row() {
        //价格区域
        Row() {
          Text('￥' + this.product_price)
            .fontWeight(FontWeight.Bold)
            .fontColor('#ff180258')
            .fontSize(20)
          Text('/' + this.product_unit)
            .fontWeight(FontWeight.Medium)
            .fontSize(10)
            .fontColor(Color.Gray)
        }
        .width('45%')
        .alignItems(VerticalAlign.Bottom)
        .justifyContent(FlexAlign.Start)

        Row() {
          Image($r('app.media.shopping_car'))
            .size({
              height: 15,
              width: 15
            })
        }
        .size({
          height: 20,
          width: 20
        })
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#ff22c1ff')
        .borderRadius(10)
      }
      .margin({ bottom: 8 })
      .width('45%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .borderRadius(15)
    .backgroundColor(Color.White)
  }
}