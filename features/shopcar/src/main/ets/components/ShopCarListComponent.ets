
import { ProductData, ProductDataSource } from "uicomponents"
import { ShopChangeInterface } from "../model/ShopCarModel"

@Component
export struct ShopCarListComponent {
  @Link shopCarListData: ProductDataSource
  @Link callback: ShopChangeInterface

  onChange( updatedData: ProductData ):void {
    const index = this.shopCarListData.findIndex(item =>
    item.product_id === updatedData.product_id
    )
    if (index !== -1) {
      this.shopCarListData.changeData(index, updatedData)
      this.callback.onItemContentChange(index, updatedData)
    }
  }
  
  build() {
    List() {
      LazyForEach(this.shopCarListData, (item: ProductData) => {
        ShopCarListItem({
          data: item,
          // callback: callback
          onChange: ( data: ProductData) => this.onChange(data)
        })
      })
    }
    .height('auto')
    .borderRadius(20)
    .width('90%')
    .backgroundColor(Color.White)
  }
}

@Component
struct ShopCarListItem {
  @Prop data : ProductData
  onChange: ( data: ProductData ) => void = () => {
  }

  aboutToAppear(): void {

  }
  build() {
    Column() {
      Row() {
        Checkbox()
          .margin({ right: 10 })
          .onChange(() => {
            this.data.product_ischoose = !this.data.product_ischoose
            this.onChange(this.data)
          })

        Image(this.data.product_picture)
          .size({
            height: 70,
            width: 70
          })
          .margin({ right: 30 })

        this.ProductInfo(this.data.product_name, this.data.product_price, this.data.product_unit, this.data.product_capacity, this.data.product_capacity_unit, this.data.product_number, this.data.product_ischoose)

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
    .height(110)
    .width('100%')
  }

  @Builder
  ProductInfo(product_name: string, product_price: string, product_unit: string, product_capacity: string, product_capacity_unit: string, product_number: number, product_ischoose: boolean) {
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
      .width('100%')
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
        .width('35%')
        .alignItems(VerticalAlign.Bottom)
        .justifyContent(FlexAlign.Start)

        Row() {
          Text('-')
            .width(20)
            .fontSize(15)
            .height(18)
            .borderRadius(16)
            .backgroundColor('#f5f5f5')
            .fontColor('#666')
            .borderColor('#e0e0e0')
            .textAlign(TextAlign.Center)
            .margin({ right: 10 })
            .onClick(() =>{
              this.data.product_number = Math.max(0, this.data.product_number - 1)
              this.onChange(this.data)
              console.info('product_number is ' + this.data.product_number)
            })

          Text(this.data.product_number.toString())
            .width(20)
            .textAlign(TextAlign.Center)
            .margin({ right: 10 })


          Text('+')
            .width(20)
            .fontSize(15)
            .height(18)
            .borderRadius(16)
            .backgroundColor('#ff22c1ff')
            .fontColor('#ffffffff')
            .borderColor('#e0e0e0')
            .textAlign(TextAlign.Center)
            .margin({ right: 10 })
            .onClick(() =>{
              this.data.product_number += 1
              this.onChange(this.data)
              console.info('product_number is ' + this.data.product_number)
            })

        }
        .alignItems(VerticalAlign.Center)
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
    }
    .width('55%')
    .height(80)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
  }
}