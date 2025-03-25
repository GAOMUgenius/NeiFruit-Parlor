import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from "routermodule"
import { ProductData, ProductDataSource } from "uicomponents"
import { ProductSelection } from "uicomponents/src/main/ets/model/ProductModel"
// import { CartService } from "uicomponents/src/main/ets/model/ProuductServer"
import { ShopChangeInterface } from "../model/ShopCarModel"
import { ShopCarListItem } from "./ShopCarListItem"

@Component
export struct ShopCarListComponent {
  @Link shopCarListData: ProductDataSource
  @Link callback: ShopChangeInterface
  @Link productSelectionMap: Map<string, ProductSelection>
  // @Link cartItems: ProductData[]



  async onDeleteData( id: string ): Promise<void> {
    this.shopCarListData.deleteById(id)
  }
  
  build() {
    List() {
      LazyForEach(this.shopCarListData, (item: ProductData) => {
        ShopCarListItem({
          data: item,
          onDeleteData: ( id: string) => this.onDeleteData(id),
          onSelectionChange: ( id: string, isSelection: boolean ) => this.callback.onSelectionChange(id, isSelection),
          productSelectionMap: this.productSelectionMap
        })
          .onClick(() => {
            buildRouterModel(RouterNameConstants.TABPAGE, BuilderNameConstants.SHOPCAR_PRODUCTINFOPAGE, new Object({ productId: item.id }))
          })
      }, (item: ProductData) => item.id.toString())
    }
    .divider({ strokeWidth: 0.2, color: '#ffd2d2d2' })
    .animation({ duration: 300, curve: Curve.EaseOut })
    .height('auto')
    .borderRadius(20)
    .width('90%')
    .backgroundColor(Color.White)
  }
}