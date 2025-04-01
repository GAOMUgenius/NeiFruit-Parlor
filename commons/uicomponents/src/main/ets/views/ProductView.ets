import { PreferenceConstant, PreferenceManager } from 'datastore'
import { ProductDataSource } from '../model/ProductDataSource'
import { ProductData, ProductData_List, ProductSelection } from '../model/ProductModel'
import { promptAction } from '@kit.ArkUI'
import { BuilderNameConstants, buildRouterModel, RouterNameConstants } from 'routermodule'
import { addToCart, fetchRecommendedProducts } from '../model/ProuductServer'


@Component
export struct ProductView {
  @State productListData: ProductDataSource  = new ProductDataSource()
  @StorageLink(PreferenceConstant.CART_KEY) localDataSource: ProductDataSource | undefined = AppStorage.get(PreferenceConstant.CART_KEY)
  @StorageLink(PreferenceConstant.CART_ISCHOOSE_KEY) productSelectionMap: Map<string, ProductSelection> | undefined = AppStorage.get(PreferenceConstant.CART_ISCHOOSE_KEY)
  @State token: string = ''
  @State productData_List: ProductData[] = ProductData_List

  async aboutToAppear(): Promise<void> {
    let preferenceManager = PreferenceManager.getInstance()

    const token: string | null = await preferenceManager.getValue<string>(PreferenceConstant.USER_TOKEN_KEY)
    if (token) {
      this.productData_List = await fetchRecommendedProducts(token)
    }
    this.productListData.pushDataList(this.productData_List)
  }


  build() {
    WaterFlow({ footer: (): void => this.itemFoot() }){
      LazyForEach(this.productListData, (item: ProductData) => {
        FlowItem() {
          ProductItem({
            product: item,
            product_id: item.id,
            product_picture: item.product_picture,
            product_name: item.product_name,
            product_price: item.product_price,
            product_unit: item.product_unit,
            product_capacity: item.product_capacity,
            product_capacity_unit: item.product_capacity_unit,
            localDataSource: this.localDataSource,
            productSelectionMap: this.productSelectionMap
          })
            .onClick(() => {
              buildRouterModel(RouterNameConstants.TABPAGE, BuilderNameConstants.SHOPCAR_PRODUCTINFOPAGE, new Object({ productId: item.id }))
            })
        }
      }, (item: ProductData) => item.id.toString())
    }
    .layoutDirection(FlexDirection.Column)
    .columnsTemplate('1fr 1fr')
    .columnsGap(8)
    .rowsGap(8)
    .width('90%')
  }

  @Builder
  itemFoot() {
    Column() {
      Text('已经到底了')
        .fontColor(Color.Gray)
        .fontSize(10)
        .width('100%')
        .height(20)
        .textAlign(TextAlign.Center)
    }
  }
}


@Component
struct ProductItem {
  @Prop product: ProductData
  @Prop product_id: number
  @Prop product_picture: ResourceStr
  @Prop product_name: string
  @Prop product_price: string
  @Prop product_unit: string
  @Prop product_capacity: string
  @Prop product_capacity_unit: string
  @State dialogMessage: string = '成功添加购物车！';
  @Link localDataSource: ProductDataSource| undefined
  @Link productSelectionMap: Map<string, ProductSelection> | undefined

  // async addToCart() {
  //   // 构造完整商品对象
  //   const product: ProductData = new ProductData(
  //     this.product_id,
  //     this.product_picture,
  //     this.product_name,
  //     this.product_price,
  //     this.product_unit,
  //     this.product_capacity,
  //     this.product_capacity_unit,
  //   )
  //   try {
  //     if (this.localDataSource) {
  //       // 操作 productSelectionMap
  //       if (!this.productSelectionMap) {
  //         this.productSelectionMap = new Map();
  //       }
  //
  //       // 获取或初始化商品数量
  //       const existingEntry = this.productSelectionMap.get(product.id.toString());
  //       if (existingEntry) {
  //         // 数量加1
  //         existingEntry.number++;
  //         this.productSelectionMap.set(product.id.toString(), existingEntry);
  //       } else {
  //         // 初始化数量为1
  //         this.productSelectionMap.set(product.id.toString(), { number: 1, ischoose: false });
  //       }
  //
  //       // 操作 localDataSource（仅添加新商品）
  //       const existingProductIndex = this.localDataSource.findIndex(
  //         item => item.id === product.id
  //       );
  //       if (existingProductIndex === -1) {
  //         this.localDataSource.dataList.push(product);
  //         this.localDataSource.reloadData();
  //       }
  //
  //       promptAction.showToast({
  //         message: this.dialogMessage
  //       });
  //     }
  //   } catch (error) {
  //     console.error('添加失败:', error);
  //   }
  // }

  build() {
    Column() {
      Image(this.product_picture)
        .size({
          height: 150,
          width: '45%'
        })
        .margin({
          top: 10,
          right: 10,
          left: 10,
          bottom: 15
        })
        .borderRadius(15)

      //商品信息区域
      Row() {
        Text(`${this.product_name} `) // 添加空格分隔
          .fontWeight(FontWeight.Bold)
          .fontSize(13)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .flexShrink(1)

        Text(this.product_capacity.toString() + this.product_capacity_unit)
          .fontWeight(FontWeight.Bold)
          .fontSize(13)
          .flexShrink(0) // 禁止容量部分被截断
      }
      .width('45%')
      .margin({ bottom: 8 })
      .alignItems(VerticalAlign.Top) // 顶部对齐
      .justifyContent(FlexAlign.Start) // 确保内容从行首开始排列

      Row() {
        //价格区域
        Row() {
          Text('￥')
            .fontWeight(FontWeight.Bold)
            .fontColor('#fffd2626')
            .fontSize(15)
          Text(this.product_price.toString())
            .fontWeight(FontWeight.Bold)
            .fontColor('#fffd2626')
            .fontSize(20)
          Text('/' + this.product_unit)
            .fontWeight(FontWeight.Medium)
            .fontSize(10)
            .fontColor(Color.Gray)
        }
        .width('45%')
        .alignItems(VerticalAlign.Bottom)
        .justifyContent(FlexAlign.Start)

        Row() {
          Image($r('app.media.shopping_car'))
            .size({
              height: 15,
              width: 15
            })
            .margin({ top: 2 })
        }
        .size({
          height: 20,
          width: 20
        })
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#ff22c1ff')
        .borderRadius(10)
        .onClick(() => addToCart(this.product, this.localDataSource, this.productSelectionMap))
      }
      .margin({ bottom: 8 })
      .width('45%')
      .justifyContent(FlexAlign.SpaceBetween)

    }
    .borderRadius(15)
    .backgroundColor(Color.White)
  }
}