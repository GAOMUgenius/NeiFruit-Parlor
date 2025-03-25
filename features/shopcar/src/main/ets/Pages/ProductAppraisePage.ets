import { it } from "@ohos/hypium";
import { BuilderNameConstants, RouterModule } from "routermodule";
import { AppraiseData, AppraiseDataSource, getAppraise, StarRating } from "uicomponents";

@Component
struct ProductAppraisePageStruct {
  @Prop productAppraise: AppraiseData[]
  @State productAppraiseData: AppraiseDataSource = new AppraiseDataSource()
  @State isLoading: boolean = false
  @State hasMore: boolean = true



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
        .margin({ bottom: 50 })

        Button('加入购物车')
          .width('90%')
          .height(50)

      }
      .alignContent(Alignment.Bottom)
      .width('100%')
    }
    .title('商品评价')
  }

  // 加载更多数据方法
  private async loadMoreData() {
    if (this.isLoading || !this.hasMore) return
    try {
      this.isLoading = true
      // 获取当前商品ID（添加安全判断）
      const productId = this.productAppraise[0]?.id
      if (!productId) {
        console.error('无效的商品ID')
        this.hasMore = false
        return
      }
      const page = 5
      const loadingList = await getAppraise(productId, 2, page,'')
      // 处理空数据情况
      if (!loadingList || loadingList.length === 0) {
        this.hasMore = false
        return
      }

      this.productAppraise.push(...loadingList)
      this.productAppraiseData.pushDataList(loadingList)
    } catch (error) {
      console.error('加载失败:', error)
    } finally {
      this.isLoading = false
    }
  }
}

@Component
struct ProductAppraiseListItem {
  @Prop productAppraise: AppraiseData
  @Link isLoading: boolean
  private starItems: number[] = [0, 1, 2, 3, 4];
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


  // 根据索引判断星星颜色
  private getStarImage(index: number): Resource {
    // 限制数字范围在0-5之间
    const validNum = Math.min(5, Math.max(0, Number(this.productAppraise.user_rating)))
    return index < validNum ? $r('app.media.star_yellow') : $r('app.media.star_gray')
  }
}


@Builder
export function ProductAppraisePage(value: object) {
  ProductAppraisePageStruct({ productAppraise: JSON.parse(JSON.stringify(value)) })
}

const builderName = BuilderNameConstants.SHOPCAR_PRODUCTAPPRAISEPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(ProductAppraisePage);
  RouterModule.registerBuilder(builderName, builder);
}