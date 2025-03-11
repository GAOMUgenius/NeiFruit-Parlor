import { CategoryType,
  ShopInterface,
  ShopList_Catering, ShopList_Fresh, ShopList_Host,
  ShopList_Scenic } from "../model/CategoriesModel"
import { ShopDataSource } from "../model/ShopDataModel";

@Component
export struct ShopItemContent{
  @Prop categoryType: CategoryType
  // 创建分类与店铺列表的映射关系
  private getShopListByType(type: CategoryType): ShopInterface[] {
    switch(type) {
      case CategoryType.HOST:
        return ShopList_Host
      case CategoryType.FRESH:
        return ShopList_Fresh
      case CategoryType.CATERING:
        return ShopList_Catering
      case CategoryType.SCENIC:
        return ShopList_Scenic
      default:
        return []
    }
  }

  private  dataSource = new ShopDataSource(this.getShopListByType(this.categoryType));
  build() {
    WaterFlow({
      footer: (): void => this.itemFoot()
    }) {
      LazyForEach(this.dataSource, (shop: ShopInterface) => {
        FlowItem() {
          ShopItem({ shop: shop })
        }
      }, (shop: ShopInterface) => shop.id.toString()) // 需要指定唯一键生成器
    }
    .layoutDirection(FlexDirection.Column)
    .columnsTemplate('1fr 1fr')
    .columnsGap(8)
    .rowsGap(8)
    .width('100%')

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
struct ShopItem {
  @Prop shop: ShopInterface

  build() {
    Column() {
      Text(this.shop.name)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row() {
        Text(`评分：${this.shop.rating}`)
          .fontColor('#FFC107')

        Text(`位置：${this.shop.location}`)
          .margin({ left: 20 })
      }
      .margin({ top: 8 })

      Text(`电话：${this.shop.phone}`)
        .fontColor('#666666')
        .margin({ top: 6 })
    }
    .padding(16)
    .backgroundColor('#FFFFFF')
    .margin({ top: 12 })
    .borderRadius(8)
    .shadow({ radius: 4, color: '#1A000000', offsetX: 1, offsetY: 1 })
  }
}