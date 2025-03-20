import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from "routermodule"
import { ProductData, ProductDataSource } from "uicomponents"
// import { CartService } from "uicomponents/src/main/ets/model/ProuductServer"
import { ShopChangeInterface } from "../model/ShopCarModel"
import { ShopCarListItem } from "./ShopCarListItem"

@Component
export struct ShopCarListComponent {
  @Link shopCarListData: ProductDataSource
  @Link callback: ShopChangeInterface
  @Link productSelectionMap: Map<string, boolean>
  // @Link cartItems: ProductData[]



  async onNumberChange( updatedData: ProductData ): Promise<void> {
    const index = this.shopCarListData.findIndex(item =>
    item.product_id === updatedData.product_id
    );

    // const newCart = [...this.cartItems];
    if (index !== -1) {
      if (updatedData.product_number === 0) {
        this.shopCarListData.deleteData(index);
        // newCart.splice(index, 1);
      } else {
        this.shopCarListData.updateItem(updatedData);
        // newCart[index] = updatedData;
      }

      // 更新
      // this.cartItems = newCart
      this.callback.onItemContentChange();
    }
  }
  
  build() {
    List() {
      LazyForEach(this.shopCarListData, (item: ProductData) => {
        ShopCarListItem({
          data: item,
          onNumberChange: ( data: ProductData) => this.onNumberChange(data),
          onSelectionChange: ( id: string, isSelection: boolean ) => this.callback.onSelectionChange(id, isSelection),
          productSelectionMap: this.productSelectionMap
        })
          .onClick(() => {
            buildRouterModel(RouterNameConstants.TABPAGE, BuilderNameConstants.SHOPCAR_PRODUCTINFOPAGE)
          })
      }, (item: ProductData) => item.product_id)
    }
    .animation({ duration: 300, curve: Curve.EaseOut })
    .height('auto')
    .borderRadius(20)
    .width('90%')
    .backgroundColor(Color.White)
  }
}