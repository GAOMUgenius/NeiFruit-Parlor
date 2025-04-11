import { PreferenceConstant } from 'datastore';
import { BuilderNameConstants, RouterModule, RouterNameConstants } from 'routermodule'
import { PayStatus, ProductData, ProductDataSource } from 'uicomponents'
import { ProductSelection } from "uicomponents/src/main/ets/model/ProductModel";
import { SettlementItemComponent } from '../components/SettlementItemComponent';
import { OrderData, OrderItem, SelectedProduct } from 'uicomponents/src/main/ets/model/OrderModel';
import { UserRecevingData } from '../model/UserReceivingModel';
import { ShopCarPage } from './ShopCarPage';
import { BusinessError } from '@kit.BasicServicesKit';

@Component
struct SettlementPageStruct {
  @Prop settlementList: ProductData[]
  @State userReceiving: UserRecevingData = new UserRecevingData()
  @StorageLink(PreferenceConstant.CART_ISCHOOSE_KEY) productSelectionMap: Map<string, ProductSelection> | undefined = AppStorage.get(PreferenceConstant.CART_ISCHOOSE_KEY)
  @StorageLink(PreferenceConstant.CART_KEY) localDataSource: ProductDataSource | undefined = AppStorage.get(PreferenceConstant.CART_KEY)
  @StorageLink(PreferenceConstant.ORDER_LIST_KEY) orderList: OrderData[] | undefined = AppStorage.get(PreferenceConstant.ORDER_LIST_KEY)
  private getFilteredData(): ProductData[] {
    let filteredData:ProductData[] = [];
    if (this.settlementList && this.productSelectionMap) {
      filteredData = this.settlementList.filter(item => {
        const selection = this.productSelectionMap!.get(item.id.toString());
        return selection?.ischoose;
      });
    }
    return filteredData;
  }


  // 计算总价的方法
  public calculateTotal(): string {
    if (this.productSelectionMap) {
      let total = 0;
      // 计算总价（直接遍历Map）
      this.productSelectionMap.forEach((value, key) => {
        if (value.ischoose) {
          if (this.settlementList) { // 从数据源中查找对应商品价格
            const product = this.settlementList.find(
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

  build() {
    NavDestination() {
      Stack() {
        Scroll() {
          Column() {
            Row() {
              Image($r('app.media.shopcar_location_icon'))
                .size({
                  width: 25,
                  height: 25
                })
                .margin({ left: 20 })
              Column() {
                Text(this.userReceiving.adress + this.userReceiving.adressinfo)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .width('100%')
                  .textAlign(TextAlign.Start)
                  .margin({ top: 10, left: 10 })

                Text(this.userReceiving.name + ' ' + this.userReceiving.phone)
                  .fontSize(13)
                  .fontWeight(FontWeight.Regular)
                  .fontColor(Color.Gray)
                  .width('100%')
                  .textAlign(TextAlign.Start)
                  .margin({ top: 5, left: 10, bottom: 10 })
              }
              .width('80%')

              Image($r('app.media.right'))
                .size({
                  width: 20,
                  height: 20
                })
                .margin({ right: 20 })
            }
            .justifyContent(FlexAlign.SpaceEvenly)
            .width('95%')
            .margin({ top: 10 })
            .backgroundColor(Color.White)
            .borderRadius(10)

            List() {
              ForEach(this.getFilteredData(), (item: ProductData) => {
                ListItem() {
                  SettlementItemComponent({
                    shopProdut: item,
                  })
                }
              })
            }
            .width('95%')
            .height('auto')
            .margin({ top: 10 })
            .backgroundColor(Color.White)
            .borderRadius(10)
            .divider({ strokeWidth: 0.2, color: '#ffd2d2d2' })

          }
          .width('100%')
          .height('100%')
        }
        .margin({ bottom: 50 })
        .width('100%')
        .height('100%')

        this.settlementComponent()
      }
      .backgroundColor('#ebf5f5f5')
      .borderRadius(10)
      .width('100%')
      .height('100%')
      .alignContent(Alignment.Bottom)
    }
    .title('确认订单')
  }

  buildOrder(): void {
    if (this.productSelectionMap && this.localDataSource) {
      // 1. 生成订单（修复解构参数问题）
      const selectedItems = Array.from(this.productSelectionMap.entries())
        .filter((entry) => entry[1].ischoose) // 避免参数解构
        .map((entry) => {
          const id = entry[0];
          const selection = entry[1];
          const product = this.settlementList.find(p => p.id.toString() === id);
          return { product: product,
            selection: selection  } as SelectedProduct;
        });

      // 创建订单对象（修复对象字面量类型问题）
      const orderItems: OrderItem[] = [];
      let totalAmount = 0;

      selectedItems.forEach((item) => {
        const price = parseFloat(item.product.product_price);
        const itemTotal = price * item.selection.number;
        orderItems.push({
          productId: item.product.id.toString(),
          productName: item.product.product_name,
          quantity: item.selection.number,
          unitPrice: price,
          totalPrice: itemTotal
        });
        totalAmount += itemTotal;
      });

      const order: OrderData = {
        orderId: `ORDER_${Date.now()}`,
        createTime: new Date().toISOString(),
        items: orderItems,
        totalAmount: totalAmount,
        status: PayStatus.PAY
      };

      // 2. 更新订单列表
      const newOrderList = this.orderList ? [...this.orderList] : [];
      newOrderList.push(order);
      AppStorage.set(PreferenceConstant.ORDER_LIST_KEY, newOrderList);

      // 3. 删除已结算商品（添加安全判断）
      selectedItems.forEach((item) => {
        if (item.product) {
          const productId = item.product.id.toString();
          // 从数据源删除
          if (this.localDataSource) {
            this.localDataSource.deleteById(productId);
          }
          // 从选择Map删除
          if (this.productSelectionMap && this.productSelectionMap.has(productId)) {
            this.productSelectionMap.delete(productId);
          }
        }
      });

      // 4. 同步更新全局存储（添加空判断）
      if (this.localDataSource) {
        AppStorage.set(PreferenceConstant.CART_KEY, this.localDataSource);
      }
      if (this.productSelectionMap) {
        AppStorage.set(PreferenceConstant.CART_ISCHOOSE_KEY, this.productSelectionMap);
      }
    }
  }


  @Builder
  settlementComponent() {
    Row() {
      Blank()
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

          Text(this.calculateTotal())
            .fontWeight(FontWeight.Bold)
            .fontSize(18)
            .fontColor('#ff4444')
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Bottom)
        .margin({ right: 10 })

        Button('生成订单')
          .width(120)
          .height(35)
          .backgroundColor('#ff22c1ff')
          .fontColor(Color.White)
          .fontSize(16)
          .onClick(() => {
            console.info('生成订单');
            this.buildOrder()
            // 5. 返回上一页
            RouterModule.pop(RouterNameConstants.TABPAGE);
          })
      }
      .height(35)
      .alignItems(VerticalAlign.Center)
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .zIndex(999)
    .width('100%')
    .height(50)
    .padding(12)
    .backgroundColor(Color.White)
    .shadow({ radius: 8, color: '#10000000', offsetX: 0, offsetY: -4 })
  }
}

@Builder
export function SettlementPage(value: object) {
  SettlementPageStruct({ settlementList: JSON.parse(JSON.stringify(value)) })
}

const builderName = BuilderNameConstants.SHOPCAR_SETTLEMENTPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(SettlementPage);
  RouterModule.registerBuilder(builderName, builder);
}

