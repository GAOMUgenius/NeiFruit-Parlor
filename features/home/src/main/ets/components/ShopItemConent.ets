import { PreferenceConstant, UserData } from "datastore";
import { BuilderNameConstants, buildRouterModel, RouterNameConstants } from "routermodule";
import { StarRating } from "uicomponents";
import { AMapService, POIItem } from "../model/CategoriesListServer";
import { CategoryType,
  ShopInterface } from "../model/CategoriesModel"
import { ShopDataSource } from "../model/ShopDataModel";

@Component
export struct ShopItemContent{
  @Prop categoryType: CategoryType
  @State dataSource: ShopDataSource = new ShopDataSource();
  @State@Watch('dataListRefresh') datalist: ShopInterface[] = []
  dataListRefresh() {
    this.dataSource.pushDataList(this.datalist)
  }

  async aboutToAppear(): Promise<void> {
    const userData: UserData = AppStorage.get(PreferenceConstant.USER_DATA)!;
    const apiData: POIItem[] = await AMapService.getPOIs(this.categoryType,userData.community_location)
    this.datalist = apiData.map(this.convertToShopInterface);
  }

  public convertToShopInterface(poi: POIItem): ShopInterface {
    const picture = poi.photos?.length
      ? poi.photos.map(photo => photo.url)
      : [$r('app.media.community_icon_add_picture')];
    return {
      id: poi.id,
      name: poi.name,
      location: poi.address,
      phone: poi.tel,
      rating: parseFloat(poi.rating || '5.0'),
      picture: picture
    } as ShopInterface;
  }



  build() {
    WaterFlow({
      footer: (): void => this.itemFoot()
    }) {
      LazyForEach(this.dataSource, (shop: ShopInterface) => {
        FlowItem() {
          ShopItem({ shop: shop })
            .onClick(() => {
              buildRouterModel(RouterNameConstants.TABPAGE, BuilderNameConstants.HOME_SHOPINFOPAGE, new Object(shop))
            })
        }
      }, (shop: ShopInterface) => shop.id.toString()) // 需要指定唯一键生成器
    }
    .cachedCount(7)
    .height('auto')
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
        .height(20)
    }
  }
}

@Reusable
@Component
struct ShopItem {
  @Prop shop: ShopInterface

  build() {
    Row() {
      Image(this.shop.picture[0])
        .size({
          height: 100,
          width: 100
        })
        .margin({ left: 10 })

      Column() {
        Text(this.shop.name)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .width(200)

        StarRating({ rating: this.shop.rating })

        Text(`位置：${this.shop.location}`)
          .width(200)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(`电话：${this.shop.phone}`)
          .width(200)
          .fontColor('#666666')
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .margin({ top: 6 })
      }
      .margin({ left: 10 })
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