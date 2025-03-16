import { ProductDataSource, ProductView, RecommendComponent } from "uicomponents";
import { shopCarInfo, ShopChangeInterface } from "../model/ShopCarModel";
import { ShopCarListComponent } from "./ShopCarListComponent";


export class ShopChangeImpl implements ShopChangeInterface {
  private context: ShopCarPage; // 替换为组件类型

  constructor(context: ShopCarPage) {
    this.context = context;
  }

  onItemContentChange(): void {
    this.context.settlementNumber = this.context.calculateTotal()
  }
}

@Component
export struct ShopCarPage {
  @State userLocation: string = '西柚学院'
  @State shopCarListData: ProductDataSource  = new ProductDataSource()
  @State settlementNumber: string = this.calculateTotal()
  @State callback: ShopChangeInterface = new ShopChangeImpl(this)

  aboutToAppear(): void {
    this.shopCarListData.pushDataList(shopCarInfo)
  }

  build() {
    Stack() {
      Scroll() {
        Column() {
          ShopCarListComponent({ shopCarListData: $shopCarListData, callback: $callback })

          RecommendComponent()
            .margin({
              top: 10,
              bottom: 10
            })

          ProductView()

          Blank() // 添加底部留白
            .height(50) // 与结算栏同高
        }
        .margin({ top: 50 })
        .justifyContent(FlexAlign.Start)
        // .alignItems(HorizontalAlign.Start)
        .width('100%')
      }
      .height('100%')
      this.settlementComponent()
      this.AdressComponent()
    }
    .height('100%')
  }

  @Builder
  AdressComponent() {
    Row() {
      Image($r("app.media.shopcar_location_icon"))
        .size({
          width: 15,
          height: 15
        })

      Text(this.userLocation)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .margin({ left: 5 })

      Image($r('app.media.shopcar_down_icon'))
        .size({
          width: 12,
          height: 12
        })
        .margin({ left: 5 })
    }
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.Start)
    .backgroundColor('#F5F5F5')
    .position({ x: 0, y: 0 }) // 固定定位在顶部
    .zIndex(999) // 确保在最顶层
    .width('100%')
    .height(50)
    .padding({ left: 5 })
  }

  // 计算总价的方法
  public calculateTotal(): string {
    let total = 0;
    for (let i = 0; i < this.shopCarListData.totalCount(); i++) {
      const item = this.shopCarListData.getData(i);
      if (item.product_ischoose) {
        total += parseFloat(item.product_price) * item.product_number;
      }
    }
    return total.toFixed(2);
  }

  @Builder
  settlementComponent() {
    Row() {
      Row() {
        Checkbox()

        Text('全选')
          .fontSize(15)
          .margin({ left: 5 })
      }
      Row() {
        Text('合计：')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333')

        Row() {
          Text('￥')
            .fontWeight(FontWeight.Bold)
            .fontSize(12)
            .fontColor('#ff4444')
            .margin({ bottom: 3 })

          Text(this.settlementNumber)
            .fontWeight(FontWeight.Bold)
            .fontSize(18)
            .fontColor('#ff4444')
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Bottom)
        .margin({ right: 10 })

        Button('结算')
          .width(80)
          .height(35)
          .backgroundColor('#ff22c1ff')
          .fontColor(Color.White)
          .fontSize(16)
          .onClick(() => {
            // 这里添加结算逻辑
            console.info('进入结算流程')
          })
      }
      .height(35)
      .alignItems(VerticalAlign.Center)
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .position({ x: 0, y: 645 }) // 60为组件自身高度
    .zIndex(999)
    .width('100%')
    .height(50)
    .padding(12)
    .backgroundColor(Color.White)
    .shadow({ radius: 8, color: '#10000000', offsetX: 0, offsetY: -4 })
  }

}
