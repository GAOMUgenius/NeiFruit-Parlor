import { PreferenceConstant } from "datastore";
import { ProductData } from "uicomponents"
import { ProductSelection } from "uicomponents/src/main/ets/model/ProductModel";

@Component
export struct SettlementItemComponent {
  @Prop shopProdut: ProductData
  @StorageLink(PreferenceConstant.CART_ISCHOOSE_KEY) productSelectionMap: Map<string, ProductSelection> | undefined = AppStorage.get(PreferenceConstant.CART_ISCHOOSE_KEY)

  build() {
   Row() {
     Image(this.shopProdut.product_picture)
       .size({
         height: 70,
         width: 70
       })
       .margin({ right: 30 })

     Column(){
       Row() {
         Text(this.shopProdut.product_name) // 添加空格分隔
           .fontWeight(FontWeight.Bold)
           .fontSize(13)
           .maxLines(2)
           .textOverflow({ overflow: TextOverflow.Ellipsis })
           .flexShrink(1)

         Text(this.shopProdut.product_capacity + this.shopProdut.product_capacity_unit)
           .fontWeight(FontWeight.Bold)
           .fontSize(13)
           .flexShrink(0) // 禁止容量部分被截断
       }
       .margin({ top: 10 })
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
           Text(this.shopProdut.product_price)
             .fontWeight(FontWeight.Bold)
             .fontColor('#fffd2626')
             .fontSize(20)
           Text('/' + this.shopProdut.product_unit)
             .fontWeight(FontWeight.Medium)
             .fontSize(10)
             .fontColor(Color.Gray)
         }
         .width('35%')
         .alignItems(VerticalAlign.Bottom)
         .justifyContent(FlexAlign.Start)

         Text(`X${this.productSelectionMap!.get(this.shopProdut.id.toString())?.number || 0}`)
           .fontSize(12)
           .fontColor(Color.Gray)
           .margin({ left: 20 })

         Text('￥' + (this.productSelectionMap!.get(this.shopProdut.id.toString())?.number! *  parseFloat(this.shopProdut.product_price)).toFixed(2).toString())
           .fontWeight(FontWeight.Bold)
           .fontColor('#fffd2626')
           .fontSize(15)
       }
       .margin({ bottom: 10 })
       .justifyContent(FlexAlign.SpaceBetween)
       .width('100%')
     }
     .width('55%')
     .height(80)
     .justifyContent(FlexAlign.SpaceBetween)
     .alignItems(HorizontalAlign.Start)
   }
   .width('100%')
  }


}