import { BuilderNameConstants, RouterModule } from 'routermodule'
import { ProductData, StarRating } from 'uicomponents'
import { ShopProductComponent } from '../components/ShopProductComponent'
import { ShopInfoData } from '../model/ShopInfoModel'

@Component
struct ShopInfoPageStruct {
  @State shopInfo: ShopInfoData = new ShopInfoData()

  build() {
      NavDestination() {
        Scroll() {
          Column() {
            Swiper() {
              ForEach(this.shopInfo.shop_picture,(item: ResourceStr) => {
                Image(item)
                  .width('100%')
                  .height('30%')
                  .backgroundColor(Color.White)
              })
            }
            .borderRadius(15)
            .width('90%')

            Column() {
              Text(this.shopInfo.shop_name)
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .width('100%')
                .textAlign(TextAlign.Start)
                .padding({ left: 5 })
                .margin({ top: 5 })

              Row() {
                Rating({ rating: this.shopInfo.shop_rating, indicator: true })
                  .stars(5)
                  .stepSize(0.5)
                  .size({
                    width: 80,
                    height: 40
                  })

                Text(this.shopInfo.shop_rating.toString())
                  .fontSize(15)
                  .fontColor(Color.Gray)
                  .margin({ left: 5 })
                  .layoutWeight(1)
                  .textAlign(TextAlign.Start)

                Text('电话:' + this.shopInfo.shop_phone)
                  .fontSize(15)

                Image($r('app.media.home_phone'))
                  .size({
                    width: 15,
                    height: 15
                  })
                  .margin({left: 5, right: 5 })

              }
              .width('100%')

            }
            .alignItems(HorizontalAlign.Start)
            .justifyContent(FlexAlign.Center)
            .width('90%')
            .backgroundColor(Color.White)
            .borderRadius(15)
            .margin({ top: 10 })

            Column() {
              Text('在售物品')
                .fontSize(15)
                .fontWeight(FontWeight.Bold)
                .fontColor('#ff180258')
                .width('100%')
                .textAlign(TextAlign.Start)
                .margin({ left: 10, top: 10, bottom: 5 })

              List() {
                ForEach(this.shopInfo.shop_product, (item: ProductData) => {
                  ListItem() {
                    ShopProductComponent({ shopProduct: item })
                  }
                })
              }
              .divider({ strokeWidth: 0.2, color: '#ffd2d2d2' })
              .height('auto')
              .width('100%')
            }
            .width('90%')
            .backgroundColor(Color.White)
            .borderRadius(15)
            .margin({ top: 10 })

            Column() {
              Text('用户评价')
                .fontSize(15)
                .fontWeight(FontWeight.Bold)
                .fontColor('#ff180258')
                .width('100%')
                .textAlign(TextAlign.Start)
                .margin({ left: 10, top: 10, bottom: 5 })
            }
          }
          .width('100%')
        }
        .backgroundColor("#ebf5f5f5")
        .width('100%')
      }
  }
}


@Builder
export function ShopInfoPage(value: object) {
  ShopInfoPageStruct()
}

const builderName = BuilderNameConstants.HOME_SHOPINFOPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(ShopInfoPage);
  RouterModule.registerBuilder(builderName, builder);
}