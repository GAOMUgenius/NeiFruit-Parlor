import { ProductView, RecommendComponent } from "uicomponents";
import { AdressComponent } from "./AdressComponent";
import { ShopCarListComponent } from "./ShopCarListComponent";

@Component
export struct ShopCarPage {
  @State userLocation: string = '西柚学院'

  build() {
    Stack() {
      Scroll() {
        Column() {
          ShopCarListComponent()

          RecommendComponent()

          ProductView()
        }
        .margin({ top: 50 })
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .width('100%')
      }
      .height('auto')
      this.AdressComponent()
    }
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
}
