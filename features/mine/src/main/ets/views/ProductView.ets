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

      Row() {
        Text(this.product_name)
          .fontSize(15)
          .maxLines(3)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .flexShrink(1)

        Text(this.product_capacity + this.product_capacity_unit)
          .fontSize(15)
          .flexShrink(0) // 禁止容量部分被截断
      }
      .width('45%')
      .alignItems(VerticalAlign.Bottom)

      Row() {
        Row() {
          Text('￥' + this.product_price)
            .fontColor('#ff180258')
            .fontSize(20)
          Text('/' + this.product_unit)
            .fontSize(10)
            .fontColor(Color.Gray)
        }
        .width('45%')
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Start)

        Image($r('app.media.shopping_car'))
          .borderRadius(8)
          .size({
            height: 15,
            width: 15
          })
          .backgroundColor('#ff22c1ff')
      }
      .width('45%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .borderRadius(15)
    .backgroundColor(Color.White)
  }
}