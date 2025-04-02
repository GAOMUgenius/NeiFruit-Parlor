import { PreferenceConstant } from 'datastore'
import { BuilderNameConstants, RouterModule } from 'routermodule'
import { AppraiseData, AppraiseDataSource, ProductData, ProductDataSource } from 'uicomponents'
import { ProductSelection } from 'uicomponents/src/main/ets/model/ProductModel'
import { addToCart } from 'uicomponents/src/main/ets/model/ProuductServer'

@Component
struct ShopAppraisePageStruct {
  @State shopAppraise: AppraiseData[] = [new AppraiseData()]
  @State shopAppraiseData: AppraiseDataSource = new AppraiseDataSource()
  @State isLoading: boolean = false
  @StorageLink(PreferenceConstant.CART_KEY) localDataSource: ProductDataSource | undefined = AppStorage.get(PreferenceConstant.CART_KEY)
  @StorageLink(PreferenceConstant.CART_ISCHOOSE_KEY) productSelectionMap: Map<string, ProductSelection> | undefined = AppStorage.get(PreferenceConstant.CART_ISCHOOSE_KEY)

  aboutToAppear(): void {
    this.shopAppraiseData.pushDataList(this.shopAppraise)
  }

  build() {
    NavDestination() {
      Stack() {
        Scroll() {
          List() {
            LazyForEach(this.shopAppraiseData, (item: AppraiseData) => {
              ListItem() {
                ShopAppraiseListItem({
                  shopAppraise: item,
                  isLoading: this.isLoading
                })
              }
            })
          }
          .width('100%')
          .height('100%')
        }
        .width('100%')
        .height('100%')
        .margin({ bottom: 40 })
      }
      .alignContent(Alignment.Bottom)
      .width('100%')
    }
    .title('商品评价')
  }

}

@Component
struct ShopAppraiseListItem {
  @Prop shopAppraise: AppraiseData
  @Link isLoading: boolean
  build() {
    Column() {
      Row() {
        Row() {
          Image(this.shopAppraise.user_picture)
            .size({
              width: 30,
              height: 30
            })
            .borderRadius(15)
            .margin({ left: 15 })
          Text(this.shopAppraise.user_name)
            .fontSize(15)
            .fontWeight(FontWeight.Normal)
            .margin({ left: 5 })
        }

        // StarRating({ rating: this.productAppraise.user_rating })
        Rating({ rating: this.shopAppraise.user_rating, indicator: true })
          .stars(5)
          .stepSize(0.5)
          .size({
            width: 80,
            height: 40
          })
          .margin({ right: 30 })
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')

      Text(this.shopAppraise.user_content)
        .fontSize(15)
        .fontWeight(FontWeight.Regular)
        .width('80%')
        .flexShrink(0)
        .margin({ top: 20, bottom: 20 })

      if(this.shopAppraise.user_content_picture?.length !== 0) {
        Row() {
          ForEach(this.shopAppraise.user_content_picture, (item: ResourceStr) => {
            Image(item)
              .width(this.getImageSize())
              .aspectRatio(1)             // 保持1:1正方形比例
              .margin({ right: 4 })        // 右侧间距
              .objectFit(ImageFit.Cover)  // 图片填充模式
          })
        }
        .width('80%')
      }

      if (this.isLoading) {
        LoadingProgress()
          .color(Color.White)
          .width(80)
          .height(80)
      }
    }
  }

  //根据图片数量计算图片大小
  private getImageSize(): string {
    if(this.shopAppraise.user_content_picture?.length != 3) {
      return '50%'
    } else {
      return '33.3%'
    }
  }
}

@Builder
export function ShopAppraisePage(value: object) {
  ShopAppraisePageStruct()
}

const builderName = BuilderNameConstants.HOME_SHOPAPPRAISEPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(ShopAppraisePage);
  RouterModule.registerBuilder(builderName, builder);
}