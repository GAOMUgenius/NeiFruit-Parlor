
import { ProductData, ProductDataSource } from "uicomponents"
import { ShopChangeInterface } from "../model/ShopCarModel"
import { ShopCarListItem } from "./ShopCarListItem"

@Component
export struct ShopCarListComponent {
  @Link shopCarListData: ProductDataSource
  @Link callback: ShopChangeInterface


  aboutToAppear() {
  }

  onChange( updatedData: ProductData ):void {
    const index = this.shopCarListData.findIndex(item =>
    item.product_id === updatedData.product_id
    )
    if (index !== -1) {
      if (updatedData.product_number === 0) {
        // 执行删除操作
        this.shopCarListData.deleteData(index);
        this.callback.onItemContentChange();
      } else {
        // 正常更新数据
        this.shopCarListData.changeData(index, updatedData);
        this.callback.onItemContentChange();
      }
    }
  }
  
  build() {
    List() {
      LazyForEach(this.shopCarListData, (item: ProductData) => {
        ShopCarListItem({
          data: item,
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