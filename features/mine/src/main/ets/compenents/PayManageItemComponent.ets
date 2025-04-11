import { PreferenceConstant } from "datastore"
import { OrderData, OrderItem, PayStatus, ProductView, RecommendComponent } from "uicomponents"


@Component
export struct PayMangeItemComponent {
 @Prop payStatus: PayStatus
 @StorageLink(PreferenceConstant.ORDER_LIST_KEY) orderList: OrderData[] = AppStorage.get(PreferenceConstant.ORDER_LIST_KEY)!
 @State itemOrderList: OrderData[] = []

 // 监听数据变化
 aboutToAppear(): void {
  this.updateOrderList()
 }


 updateOrderList() {
  this.itemOrderList = this.orderList
   .filter(order => order.status === this.payStatus)
   .map((item: OrderData) => ({
    orderId: item.orderId,
    createTime: item.createTime,
    items: [...item.items], // 数组浅拷贝
    totalAmount: item.totalAmount,
    status: item.status
   } as OrderData));// 浅拷贝避免引用问题
 }

 @Builder
 OrderItem(order: OrderData) {
  Column() {
   // 订单头
   Column() {
    Text(`订单号：${order.orderId}`)
     .fontSize(14)
     .fontColor('#333')
     .width('100%')
    Text(order.createTime)
     .fontSize(12)
     .fontColor('#666')
     .width('100%')
   }
   .justifyContent(FlexAlign.SpaceBetween)
   .width('100%')

   // 商品列表
   List() {
    ForEach(order.items, (item: OrderItem) => {
     ListItem() {
      Row() {
       Text(item.productName)
        .flexGrow(1)
       Text(`×${item.quantity}`)
        .margin({ right: 20 })
       Text(`￥${item.totalPrice.toFixed(2)}`)
      }
      .padding(5)
     }
    })
   }
   .height('auto')
   .width('100%')

   // 订单合计
   Row() {
    Text('合计：')
    Text(`￥${order.totalAmount.toFixed(2)}`)
     .fontColor('#ff4444')
   }
   .justifyContent(FlexAlign.End)
   .width('100%')
  }
  .justifyContent(FlexAlign.Center)
  .alignItems(HorizontalAlign.Center)
  .padding(10)
  .backgroundColor(Color.White)
  .margin({ top: 5, bottom: 5 })
  .borderRadius(8)
  .width('100%')
 }

 build() {
  Scroll() {
   Column() {
    if (this.itemOrderList.length > 0) {
     List() {
      ForEach(this.itemOrderList, (order: OrderData) => {
       ListItem() {
        this.OrderItem(order)
       }
      })
     }
     .height('auto')
     .width('100%')
    } else {
     // 空状态显示
     Column() {
      Image('empty_icon')
       .width(120)
       .height(120)
      Text('暂无相关订单')
       .fontSize(16)
       .margin(10)
     }
     .width('100%')
     .height('50%')
     .justifyContent(FlexAlign.Center)
    }

    RecommendComponent()
    ProductView()
   }
   .backgroundColor("#ebf5f5f5")
   .width('100%')
  }
 }
}