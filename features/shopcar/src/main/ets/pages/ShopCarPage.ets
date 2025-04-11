import { PreferenceConstant, PreferenceManager } from "datastore";
import { ProductData, ProductDataSource, ProductView, RecommendComponent } from "uicomponents";
import { ShopChangeInterface } from "../model/ShopCarModel";
import { ShopCarListComponent } from "../components/ShopCarListComponent";
import { ProductSelection } from "uicomponents/src/main/ets/model/ProductModel";
import { BuilderNameConstants, buildRouterModel, RouterNameConstants } from "routermodule";


class ShopChangeImpl implements ShopChangeInterface {
  private context: ShopCarPage; // 替换为组件类型

  constructor(context: ShopCarPage) {
    this.context = context;
  }

  async onItemContentChange(): Promise<void> {
    this.context.settlementNumber = this.context.calculateTotal()
  }
  onSelectionChange(id: string, selection: boolean): void {
    if (this.context.productSelectionMap) { // 获取当前商品的现有选择状态
      const existingSelection = this.context.productSelectionMap.get(id);

      // 如果条目存在，保留原有数量
      if (existingSelection) {
        // 创建新对象，仅修改 ischoose 属性
        this.context.productSelectionMap.set(id, {
          ischoose: selection, // 更新选中状态
          number: existingSelection.number  // 保留原有数量
        });

        // 更新结算总价
        this.context.settlementNumber = this.context.calculateTotal();
      } else {
        // 可选：处理未找到条目的情况（根据业务需求添加逻辑）
        console.warn(`未找到商品 ${id} 的选择记录`);
      }
    }
  }
}

@Component
export struct ShopCarPage {
  @State userLocation: string = '西柚学院'
  @State settlementNumber: string = '0.00'
  @State callback: ShopChangeInterface = new ShopChangeImpl(this)
  @State isAllSelected: boolean = false;
  @StorageLink(PreferenceConstant.CART_KEY) localDataSource: ProductDataSource | undefined = AppStorage.get(PreferenceConstant.CART_KEY)
  @StorageLink(PreferenceConstant.CART_ISCHOOSE_KEY)@Watch('MapChange') productSelectionMap: Map<string, ProductSelection> | undefined = AppStorage.get(PreferenceConstant.CART_ISCHOOSE_KEY)
  MapChange() {
      this.callback.onItemContentChange()
  }


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
    .alignContent(Alignment.Bottom)
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
    if (this.productSelectionMap) {
      let total = 0;

      // 计算全选状态（确保Map中存在条目）
      const allEntries = Array.from(this.productSelectionMap.values());
      const selectedItems = allEntries.filter(entry => entry.ischoose);

      this.isAllSelected = allEntries.length > 0 &&
        selectedItems.length === allEntries.length;

      // 计算总价（直接遍历Map）
      this.productSelectionMap.forEach((value, key) => {
        if (value.ischoose) {
          if (this.localDataSource) { // 从数据源中查找对应商品价格
            const product = this.localDataSource.dataList.find(
              item => item.id.toString() === key
            );
            if (product) {
              total += parseFloat(product.product_price) * value.number;
            }
          }
        }
      });

      return total.toFixed(2);
    }
    return '0.00'
  }

  private toggleAllSelection(checked: boolean): void {
    // 创建新 Map 实例（确保引用变化）
    const newMap = new Map<string, ProductSelection>();

    if (this.productSelectionMap) { // 遍历原Map保留数量，仅修改选中状态
      this.productSelectionMap.forEach((value, key) => {
        newMap.set(key, {
          number: value.number, // 保留原有属性
          ischoose: checked // 覆盖选中状态
        });
      });
    }

    this.productSelectionMap = newMap; // 触发 @Link 更新
    this.isAllSelected = checked;      // 同步全选状态
    this.calculateTotal();
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
              buildRouterModel(RouterNameConstants.TABPAGE, BuilderNameConstants.SHOPCAR_SETTLEMENTPAGE, new Object(this.localDataSource?.dataList))
          })
      }
      .height(35)
      .alignItems(VerticalAlign.Center)
    }
    .justifyContent(FlexAlign.SpaceBetween)
    // .position({ x: 0, y: 645 })
    .zIndex(999)
    .width('100%')
    .height(50)
    .padding(12)
    .backgroundColor(Color.White)
    .shadow({ radius: 8, color: '#10000000', offsetX: 0, offsetY: -4 })
  }

}
