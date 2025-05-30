import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from 'routermodule'
import { AppraiseData, AppraiseListComponent,
  appraiseProductDataList,
  getAppraise,
  ProductDataSource,
  ProductView, RecommendComponent } from 'uicomponents'
import { productInfoParameter, ProductInfoParameter,
  productInfoParameterList,
  SellingPointInfoList } from '../model/ProductInfoModel'

import { PreferenceConstant, PreferenceManager } from 'datastore'
import { ProductData, ProductSelection } from 'uicomponents/src/main/ets/model/ProductModel'
import { addToCart } from 'uicomponents/src/main/ets/model/ProuductServer'

@Component
struct ProductInfoPageSturct {
  @Prop product_id: number
  @State productInfo: ProductInfoParameter = productInfoParameter
  @StorageLink(PreferenceConstant.CART_KEY) localDataSource: ProductDataSource | undefined = AppStorage.get(PreferenceConstant.CART_KEY)
  @StorageLink(PreferenceConstant.CART_ISCHOOSE_KEY) productSelectionMap: Map<string, ProductSelection> | undefined = AppStorage.get(PreferenceConstant.CART_ISCHOOSE_KEY)
  @State sellingPointList: SellingPointInfoList[] = [
    new SellingPointInfoList(
      this.productInfo.productinfo_storage,
      '储存条件'
    ),
    new SellingPointInfoList(
      this.productInfo.productinfo_reason,
      '推荐理由'
    ),
    new SellingPointInfoList(
      this.productInfo.productinfo_advantage,
      '商品优势'
    ),
    new SellingPointInfoList(
      this.productInfo.productinfo_brand,
      '商品品牌'
    ),
  ]
  @State isSellingPointShow: boolean = false
  @State productAppraise: AppraiseData[] = [new AppraiseData()]
  @State product: ProductData = new ProductData(this.productInfo.id, this.productInfo.product_picture, this.productInfo.product_name, this.productInfo.product_price, this.productInfo.product_unit, this.productInfo.product_capacity, this.productInfo.product_capacity_unit)



  async aboutToAppear(): Promise<void> {
    const foundProduct = productInfoParameterList.find(item => item.id === this.product_id);
    this.productInfo = foundProduct ? foundProduct : productInfoParameter;
    // 更新 sellingPointList
    this.sellingPointList = [
      new SellingPointInfoList(this.productInfo.productinfo_storage, '储存条件'),
      new SellingPointInfoList(this.productInfo.productinfo_reason, '推荐理由'),
      new SellingPointInfoList(this.productInfo.productinfo_advantage, '商品优势'),
      new SellingPointInfoList(this.productInfo.productinfo_brand, '商品品牌'),
    ];
    // 更新 product 对象
    this.product = new ProductData(
      this.productInfo.id,
      this.productInfo.product_picture,
      this.productInfo.product_name,
      this.productInfo.product_price,
      this.productInfo.product_unit,
      this.productInfo.product_capacity,
      this.productInfo.product_capacity_unit
    );
    // 获取评价数据
    if (isNaN(this.product_id)) {
      console.error("Invalid product_id:", this.product_id);
      return;
    }
    let preferenceManager = PreferenceManager.getInstance()
    const token = await preferenceManager.getValue<string>(PreferenceConstant.USER_TOKEN_KEY)
    // if (token) {
    //   const getId: number = Number(this.product_id)
    //   const getAppraiseInfo: AppraiseData[] = await getAppraise(getId as number, 2, 1, token)
    //   this.productAppraise = getAppraiseInfo
    // }

    const filteredData = appraiseProductDataList.filter(item => item.post_id === this.product.id)
    this.productAppraise = filteredData
  }

  build() {
    NavDestination() {
      Stack() {
        Scroll() {
          Column() {
            Swiper() {
              // 图片轮播部分
              ForEach(this.productInfo.productinfo_picture, (item: ResourceStr, index: number) => {
                Image(item)
                  .width('100%')
                  .height(400)
                  .objectFit(ImageFit.Cover)
                  .borderRadius(8)
              }, (item: ResourceStr) => JSON.stringify(item))
            }
            .autoPlay(false) // 是否自动播放
            .indicator(true) // 显示指示点
            .loop(true) // 循环播放
            .duration(1000) // 切换动画时长
            .width('100%')
            .aspectRatio(1) // 推荐16:9比例（1.77）
            .margin({ top: 12, bottom: 12 })
            .height(150)
            .margin({ bottom: 10 })

            Column() {
              Row() {
                Text('￥')
                  .fontSize(20)
                  .fontColor('#fffd2626')
                Text(this.productInfo.product_price)
                  .fontSize(25)
                  .fontColor('#fffd2626')
                Text('/' + this.productInfo.product_unit)
                  .fontSize(18)
                  .fontColor(Color.Gray)
              }
              .margin({ bottom: 10, top: 10, left: 15 })

              Text(this.productInfo.product_name + this.productInfo.product_capacity + this.productInfo.product_capacity_unit)
                .fontSize(23)
                .fontWeight(FontWeight.Bold)
                .maxLines(2)
                .width('95%')
                .margin({ bottom: 10, left: 15 })

              Row() {
                Scroll() {
                  sellingPointView({sellingPointList: this.sellingPointList, isSellingPointShow: $isSellingPointShow, productInfo: this.productInfo })
                }
                .scrollBarColor(Color.Transparent)
                .layoutWeight(1)
                .scrollable(ScrollDirection.Horizontal)

                Image($r('app.media.right'))
                  .size({
                    width: 5,
                    height: 12
                  })
                  .margin({ right: 3 })
              }
              .borderRadius(5)
              .margin({ left: 15, bottom: 10 })
              .justifyContent(FlexAlign.SpaceBetween)
              .backgroundColor("#ebeeeeee")
              .width('90%')

              Text(this.productInfo.productinfo_introduce)
                .fontSize(13)
                .width('90%')
                .fontColor(Color.Gray)
                .flexShrink(0)
                .margin({ left: 15, bottom: 15 })

            }
            .borderRadius(10)
            .justifyContent(FlexAlign.Start)
            .alignItems(HorizontalAlign.Start)
            .backgroundColor(Color.White)
            .width('100%')
            .margin({ bottom: 10 })

            Column() {
              Row() {
                Text('评价')
                  .fontSize(15)
                  .fontWeight(FontWeight.Medium)
                  .margin({ left: 30 })

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
                .margin({ right: 30 })

              }
              .margin({ top: 10 })
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)

              AppraiseListComponent({ productAppraise: this.productAppraise })

            }
            .borderRadius(15)
            .width('100%')
            .backgroundColor(Color.White)
            .onClick(() => {
              buildRouterModel(RouterNameConstants.TABPAGE, BuilderNameConstants.SHOPCAR_PRODUCTAPPRAISEPAGE, new Object(this.product))
            })

            RecommendComponent()

            ProductView()
          }
          .width('100%')
        }
        .backgroundColor("#ebf5f5f5")
        .width('100%')
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
      .height('100%')
    }
  }
}

@Builder
function productDetail(productInfo: ProductInfoParameter) {
  Row() {
    Column() {
      Text('主要原料')
        .fontColor(Color.Gray)
        .fontSize(15)
        .margin({ top: 5, bottom: 5})
      Text('产地')
        .fontColor(Color.Gray)
        .fontSize(15)
        .margin({ top: 5, bottom: 5})
      Text('净含量')
        .fontColor(Color.Gray)
        .fontSize(15)
        .margin({ top: 5, bottom: 5})
      Text('储存条件')
        .fontColor(Color.Gray)
        .fontSize(15)
        .margin({ top: 5, bottom: 5})
      Text('品牌')
        .fontColor(Color.Gray)
        .fontSize(15)
        .margin({ top: 5, bottom: 5})
    }
    .alignItems(HorizontalAlign.Start)

    Column() {
      Text(productInfo.product_raw_material)
        .fontSize(15)
        .margin({ top: 5, bottom: 5})
      Text(productInfo.productinfo_origin)
        .fontSize(15)
        .margin({ top: 5, bottom: 5})
      Text(productInfo.product_capacity + productInfo.product_capacity_unit)
        .fontSize(15)
        .margin({ top: 5, bottom: 5})
      Text(productInfo.productinfo_storage)
        .fontSize(15)
        .margin({ top: 5, bottom: 5})
      Text(productInfo.productinfo_brand)
        .fontSize(15)
        .margin({ top: 5, bottom: 5})
    }
    .margin({ left: 20 })
    .alignItems(HorizontalAlign.Start)
  }
  .backgroundColor('#ebf5f5f5')
  .borderRadius(10)
  .width('100%')
}

@Builder
function sellingPointInfoView(sellingPointList: SellingPointInfoList[], productInfo: ProductInfoParameter) {
  Column() {
    Text('商品参数')
      .fontSize(18)
      .fontWeight(FontWeight.Medium)
      .width('100%')
      .textAlign(TextAlign.Center)
      .margin({ top: 10 })
    Text('商品卖点')
      .fontSize(13)
      .fontColor(Color.Gray)
      .width('100%')
      .textAlign(TextAlign.Start)
      .margin({ bottom: 10, top: 10 })

    Grid() {
      ForEach(sellingPointList, (item: SellingPointInfoList) => {
        GridItem() {
          Column() {
            Text(item.sellingPoint)
              .fontSize(15)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 10 })

            Text(item.sellingTitle)
              .fontSize(12)
              .fontColor(Color.Gray)
          }
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        }
      })
    }
    .height(150)
    .columnsTemplate('1fr 1fr')
    .rowsTemplate('1fr 1fr')

    Text('参数信息')
      .fontSize(13)
      .fontColor(Color.Gray)
      .width('100%')
      .textAlign(TextAlign.Start)
      .margin({ bottom: 10 })

    productDetail(productInfo)

  }
  .width("90%")
}

@Component
struct  sellingPointView {
  @Prop productInfo: ProductInfoParameter
  @Link isSellingPointShow: boolean
  @Prop sellingPointList: SellingPointInfoList[]
  build() {
    Row() {
      Row() {
        Text(this.productInfo.productinfo_storage)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .height(18)
          .margin({ right: 10 })
          .maxLines(1)
          .flexShrink(0)

        Line()
          .height('60%')
          .width(0.5)
          .backgroundColor(Color.Gray)
          .margin({ right: 10})

      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Start)

      Row() {
        Text(this.productInfo.productinfo_reason)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .height(18)
          .margin({ right: 10 })
          .maxLines(1)
          .flexShrink(0)

        Line()
          .height('60%')
          .width(0.5)
          .backgroundColor(Color.Gray)
          .margin({ right: 10})

      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Start)

      Row() {
        Text(this.productInfo.productinfo_advantage)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .height(18)
          .margin({ right: 10 })
          .maxLines(1)
          .flexShrink(0)

        Line()
          .height('60%')
          .width(0.5)
          .backgroundColor(Color.Gray)
          .margin({ right: 10})

      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Start)

      Row() {
        Text(this.productInfo.productinfo_brand)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .height(18)
          .margin({ right: 10 })
          .maxLines(1)
          .flexShrink(0)

        Line()
          .height('60%')
          .width(0.5)
          .backgroundColor(Color.Gray)
          .margin({ right: 10})

      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Start)
    }
    .onClick(() => {
      this.isSellingPointShow = !this.isSellingPointShow
    })
    .bindSheet(this.isSellingPointShow, sellingPointInfoView(this.sellingPointList, this.productInfo), {
      height: 300,
      detents: [SheetSize.MEDIUM, SheetSize.LARGE],
      backgroundColor: Color.White,
      blurStyle: BlurStyle.Thick,
      enableOutsideInteractive: false,
      preferType: SheetType.CENTER,
      shouldDismiss: (sheetDismiss) => {
        console.log("Sheet will be dismissed");
        this.isSellingPointShow = false
        sheetDismiss.dismiss();
      }
    })
    .height(18)
  }
}

interface GeneratedTypeLiteralInterface_1 {
  productId?: number;
}

@Builder
export function ProductInfoPage(value: object) {
  ProductInfoPageSturct({ product_id: Number((value as GeneratedTypeLiteralInterface_1).productId || '') })
}

const builderName = BuilderNameConstants.SHOPCAR_PRODUCTINFOPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(ProductInfoPage);
  RouterModule.registerBuilder(builderName, builder);
}