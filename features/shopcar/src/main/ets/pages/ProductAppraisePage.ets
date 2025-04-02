import { it } from "@ohos/hypium";
import { PreferenceConstant } from "datastore";
import { BuilderNameConstants, RouterModule } from "routermodule";
import { AppraiseData, AppraiseDataSource, getAppraise, ProductDataSource, StarRating } from "uicomponents";
import { ProductData, ProductSelection } from "uicomponents/src/main/ets/model/ProductModel";
import { addToCart } from "uicomponents/src/main/ets/model/ProuductServer";

@Component
struct ProductAppraisePageStruct {
  @Prop product: ProductData
  @State productAppraise: AppraiseData[] = [new AppraiseData()]
  @State productAppraiseData: AppraiseDataSource = new AppraiseDataSource()
  @State isLoading: boolean = false
  @State hasMore: boolean = true
  @StorageLink(PreferenceConstant.CART_KEY) localDataSource: ProductDataSource | undefined = AppStorage.get(PreferenceConstant.CART_KEY)
  @StorageLink(PreferenceConstant.CART_ISCHOOSE_KEY) productSelectionMap: Map<string, ProductSelection> | undefined = AppStorage.get(PreferenceConstant.CART_ISCHOOSE_KEY)



  aboutToAppear(): void {
    this.productAppraiseData.pushDataList(this.productAppraise)
  }

  build() {
    NavDestination() {
      Stack() {
        Scroll() {
          List() {
            LazyForEach(this.productAppraiseData, (item: AppraiseData) => {
              ListItem() {
                ProductAppraiseListItem({
                  productAppraise: item,
                  isLoading: this.isLoading
                })
              }
            })
          }
          .width('100%')
          .height('100%')
        }
        .width('100%')
        .height('auto')
        .margin({ bottom: 40 })

        Button('加入购物车')
          .type(ButtonType.Capsule)
          .borderRadius(8)
          .backgroundColor('#ff22c1ff')
          .width('80%')
          .height(40)
          .zIndex(999)
          .onClick(() => addToCart(this.product, this.localDataSource, this.productSelectionMap))
      }
      .alignContent(Alignment.Bottom)
      .width('100%')
    }
    .title('商品评价')
  }
}

@Component
struct ProductAppraiseListItem {
  @Prop productAppraise: AppraiseData
  @Link isLoading: boolean
  build() {
    Column() {
      Row() {
        Row() {
          Image(this.productAppraise.user_picture)
            .size({
              width: 30,
              height: 30
            })
            .borderRadius(15)
            .margin({ left: 15 })
          Text(this.productAppraise.user_name)
            .fontSize(15)
            .fontWeight(FontWeight.Normal)
            .margin({ left: 5 })
        }

        StarRating({ rating: this.productAppraise.user_rating })
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')

      Text(this.productAppraise.user_content)
        .fontSize(15)
        .fontWeight(FontWeight.Regular)
        .width('80%')
        .flexShrink(0)
        .margin({ top: 20, bottom: 20 })

      if(this.productAppraise.user_content_picture?.length !== 0) {
        Row() {
          ForEach(this.productAppraise.user_content_picture, (item: ResourceStr) => {
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
    if(this.productAppraise.user_content_picture?.length != 3) {
      return '50%'
    } else {
      return '33.3%'
    }
  }

}


@Builder
export function ProductAppraisePage(value: object) {
  ProductAppraisePageStruct({ product: JSON.parse(JSON.stringify(value)) })
}

const builderName = BuilderNameConstants.SHOPCAR_PRODUCTAPPRAISEPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(ProductAppraisePage);
  RouterModule.registerBuilder(builderName, builder);
}