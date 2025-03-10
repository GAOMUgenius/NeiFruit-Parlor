import { CateforyInterface, CateforyType, category_list, ShopInterface,
  ShopList_Catering,
  ShopList_Fresh,
  ShopList_Host,
  ShopList_Scenic} from "../model/CategoriesModel";

// 在父组件中管理状态
@Component
export struct CategoryTabs {
  @State currentIndex: CateforyType = CateforyType.HOST
  private tabsController: TabsController = new TabsController()

  // 创建分类与店铺列表的映射关系
  private getShopListByType(type: CateforyType): ShopInterface[] {
    switch(type) {
      case CateforyType.HOST:
        return ShopList_Host
      case CateforyType.FRESH:
        return ShopList_Fresh
      case CateforyType.CATERING:
        return ShopList_Catering
      case CateforyType.SCENIC:
        return ShopList_Scenic
      default:
        return []
    }
  }

  onChange(index: CateforyType): void {
    this.currentIndex = index;
  }

  build() {
    Column() {
      // 顶部导航栏组件
      CategoryTabItem({
        categories: category_list.map(item => item.title),
        currentIndex: this.currentIndex,
        onChange: (index: number) => {
          this.onChange(index)
          this.tabsController.changeIndex(index)
        }
      })

      // 内容区域
      Tabs({
        index: this.currentIndex,
        controller: this.tabsController
      }) {
        ForEach(category_list, (item: CateforyInterface) => {
          TabContent() {
            this.BuildContent(item.id)
          }
        }, (item: CateforyInterface) => item.id.toString())
      }
      .onChange((index: number) => {
        this.currentIndex = index;
      })
      .barHeight(0)
      .width('90%')
      .height('100%')
    }
  }

  @Builder
  BuildContent(categoryType: CateforyType) {
    Column() {
      ForEach(this.getShopListByType(categoryType), (shop: ShopInterface) => {
        ShopItem({ shop: shop })
      })
    }
  }
}

// 子组件实现
@Component
struct CategoryTabItem {
  @Prop categories: string[]
  @Prop currentIndex: CateforyType
  onChange: (index: number) => void = () => {
  };

  build() {
    Row() {
      //标签页容器
      Row() {
        ForEach(this.categories, (item: string, index: number) => {
          Text(item)
            .fontSize(16)
            .fontColor(this.currentIndex === index ? '#007AFF' : '#000000')
            .animation({ duration: 200 })
            .margin({ right: 30 })
            .onClick(() => {
              animateTo({
                duration: 0,
                curve: Curve.EaseOut
              }, () => {
                this.onChange(index)
              })
            })
        })
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .padding(10)
      .backgroundColor('#FFFFFF')
      .border({ width: 1, color: '#F1F1F1' })
    }
  }

}


@Component
struct ShopItem {
  @Prop shop: ShopInterface
  @State scaleValue: number = 0.95
  @State opacityValue: number = 0

  aboutToAppear() {
    animateTo({
      duration: 400,
      curve: Curve.EaseOut
    }, () => {
      this.scaleValue = 1
      this.opacityValue = 1
    })
  }

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