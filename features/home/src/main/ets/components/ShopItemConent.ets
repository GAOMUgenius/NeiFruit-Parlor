import { StarRating } from "uicomponents";
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
    .columnsTemplate('1fr')
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
    Row() {
      Image($r('app.media.shopPicture'))
        .size({
          height: 100,
          width: 100
        })
        .margin({ left: 10 })

      Column() {
        Row() {
          Text(this.shop.name)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)

          StarRating({ rating: this.shop.rating })
        }
        .width(200)
        .justifyContent(FlexAlign.SpaceBetween)

        Text(`位置：${this.shop.location}`)

        Text(`电话：${this.shop.phone}`)
          .fontColor('#666666')
          .margin({ top: 6 })
      }
      .margin({ left: 10 })
      .height(120)
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
    .margin({ top: 12 })
    .borderRadius(8)
    .shadow({ radius: 4, color: '#1A000000', offsetX: 1, offsetY: 1 })
  }
}