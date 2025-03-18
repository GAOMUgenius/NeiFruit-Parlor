import { PreferenceConstant, PreferenceManager } from "datastore";
import { ProductData, ProductDataSource, ProductView, RecommendComponent } from "uicomponents";
// import { CartService } from "uicomponents/src/main/ets/model/ProuductServer";
import { ShopChangeInterface } from "../model/ShopCarModel";
import { ShopCarListComponent } from "./ShopCarListComponent";


class ShopChangeImpl implements ShopChangeInterface {
  private context: ShopCarPage; // 替换为组件类型

  constructor(context: ShopCarPage) {
    this.context = context;
  }

  async onItemContentChange(): Promise<void> {
    this.context.settlementNumber = this.context.calculateTotal()
  }
  onSelectionChange(id: string, selection: boolean): void {
    this.context.productSelectionMap.set(id, selection)
    this.context.settlementNumber = this.context.calculateTotal()
  }
}

@Component
export struct ShopCarPage {
  @State userLocation: string = '西柚学院'
  @State settlementNumber: string = '0.00'
  @State callback: ShopChangeInterface = new ShopChangeImpl(this)
  @State isAllSelected: boolean = false;
  @StorageLink(PreferenceConstant.CART_ISCHOOSE_KEY) productSelectionMap: Map<string, boolean> = new Map();
  @StorageLink(PreferenceConstant.CART_KEY) localDataSource: ProductDataSource  = new ProductDataSource()


  build() {
    Stack() {
      Scroll() {
        Column() {
          ShopCarListComponent({ shopCarListData: $localDataSource, callback: $callback, productSelectionMap: $productSelectionMap })

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
    const selectedItems = Array.from(this.productSelectionMap.values()).filter(Boolean);

    // 计算全选状态
    this.isAllSelected = selectedItems.length > 0 &&
      selectedItems.length === this.productSelectionMap.size;

    // 计算总价
    this.localDataSource.dataList.forEach(item => {
      if (this.productSelectionMap.get(item.product_id)) {
        total += parseFloat(item.product_price) * item.product_number;
      }
    });
    return total.toFixed(2);
  }

  private toggleAllSelection(checked: boolean): void {
    // 创建新 Map 实例（确保引用变化）
    const newMap = new Map<string, boolean>(this.productSelectionMap);
    for (const key of newMap.keys()) {
      newMap.set(key, checked);
    }
    this.productSelectionMap = newMap; // 触发 @Link 更新
    this.isAllSelected = checked; // 同步全选状态
    this.calculateTotal()
  }


  @Builder
  settlementComponent() {
    Row() {
      Row() {
        Checkbox()
          .select(this.isAllSelected)
          .onClick(() => {
            this.isAllSelected = !this.isAllSelected
            this.toggleAllSelection(this.isAllSelected);
          })


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
