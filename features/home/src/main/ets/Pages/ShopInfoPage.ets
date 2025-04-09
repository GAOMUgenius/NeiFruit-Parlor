import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from 'routermodule'
import { AppraiseListComponent, ProductData, ProductView, RecommendComponent, StarRating } from 'uicomponents'
import { ShopProductComponent } from '../components/ShopProductComponent'
import { ShopInterface } from '../model/CategoriesModel'
import { ShopInfoData } from '../model/ShopInfoModel'

@Component
struct ShopInfoPageStruct {
  @Prop shopData: ShopInterface
  @State shopInfo: ShopInfoData = new ShopInfoData()
  aboutToAppear(): void {
    if(this.shopData) {
      this.shopInfo.shop_name = this.shopData.name
      this.shopInfo.shop_picture = this.shopData.picture
      this.shopInfo.shop_rating = this.shopData.rating
      this.shopInfo.shop_phone = this.shopData.phone
      this.shopInfo.shop_loacation = this.shopData.location
    }
  }
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

              Text('位置:' + this.shopInfo.shop_loacation)
                .fontSize(15)
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
              Row() {
                Text('评价')
                  .fontSize(15)
                  .fontWeight(FontWeight.Medium)
                  .margin({ left: 10 })

                Row() {
                  Text('查看全部')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Color.Gray)
                    .margin({ right: 5 })
                  Image($r('app.media.right'))
                    .size({
                      width: 8,
                      height: 12
                    })
                }
                .margin({ right: 10 })

              }
              .margin({ top: 10 })
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)

              AppraiseListComponent({ productAppraise: this.shopInfo.shop_appraise })
            }
            .width('90%')
            .backgroundColor(Color.White)
            .borderRadius(15)
            .margin({ top: 10 })
            .onClick(() => {
              buildRouterModel(RouterNameConstants.TABPAGE, BuilderNameConstants.HOME_SHOPAPPRAISEPAGE)
            })


            RecommendComponent()

            ProductView()
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
  ShopInfoPageStruct({ shopData: JSON.parse(JSON.stringify(value)) })
}

const builderName = BuilderNameConstants.HOME_SHOPINFOPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(ShopInfoPage);
  RouterModule.registerBuilder(builderName, builder);
}