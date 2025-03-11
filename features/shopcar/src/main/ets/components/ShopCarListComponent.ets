import { ProductData } from "uicomponents"
import { shopCarListDataSource } from "../model/ShopCarModel"

@Component
export struct ShopCarListComponent {
  
  build() {
    Row() {
      WaterFlow() {
        LazyForEach(shopCarListDataSource, (item: ProductData) => {
          FlowItem() {
            ShopCarListItem({
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
    }
    .width('90%')
    .backgroundColor(Color.White)
  }
}

@Component
struct ShopCarListItem {
  @Prop product_picture: ResourceStr
  @Prop product_name: string
  @Prop product_price: string
  @Prop product_unit: string
  @Prop product_capacity: string
  @Prop product_capacity_unit: string
  build() {
    Column() {
      Row() {
        Checkbox()

        Image(this.product_picture)
          .size({
            height: 80,
            width: 80
          })

        this.ProductInfo(this.product_name, this.product_price, this.product_unit, this.product_capacity, this.product_capacity_unit)

      }
      .width('100%')
      .margin({ top: 20, bottom: 20 })
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceAround)

      Line()
        .height(0.2)
        .backgroundColor('#ffd2d2d2')
        .width('100%')
    }
    .width('100%')
  }

  @Builder
  ProductInfo(product_name: string, product_price: string, product_unit: string, product_capacity: string, product_capacity_unit: string) {
    Column(){
      Row() {
        Text(product_name) // 添加空格分隔
          .fontWeight(FontWeight.Bold)
          .fontSize(13)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .flexShrink(1)

        Text(product_capacity + product_capacity_unit)
          .fontWeight(FontWeight.Bold)
          .fontSize(13)
          .flexShrink(0) // 禁止容量部分被截断
      }
      .width('40%')
      .alignItems(VerticalAlign.Bottom) // 顶部对齐
      .justifyContent(FlexAlign.Start) // 确保内容从行首开始排列

      Row() {
        //价格区域
        Row() {
          Text('￥')
            .fontWeight(FontWeight.Bold)
            .fontColor('#fffd2626')
            .fontSize(15)
          Text(product_price)
            .fontWeight(FontWeight.Bold)
            .fontColor('#fffd2626')
            .fontSize(20)
          Text('/' + product_unit)
            .fontWeight(FontWeight.Medium)
            .fontSize(10)
            .fontColor(Color.Gray)
        }
        .width('45%')
        .alignItems(VerticalAlign.Bottom)
        .justifyContent(FlexAlign.Start)
      }
    }
    .height(80)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
  }
}