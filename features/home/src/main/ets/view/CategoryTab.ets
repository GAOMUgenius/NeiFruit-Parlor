import { ShopItemContent } from "../components/ShopItemConent";
import { CateforyInterface, CategoryType, category_list } from "../model/CategoriesModel";

// 在父组件中管理状态
@Component
export struct CategoryTabs {
  @State currentIndex: CategoryType = CategoryType.HOST
  private tabsController: TabsController = new TabsController()

  onChange(index: CategoryType): void {
    this.currentIndex = index;
  }

  build() {
      // 内容区域
      Tabs({
        index: this.currentIndex,
        controller: this.tabsController
      }) {
        ForEach(category_list, (item: CateforyInterface) => {
          TabContent() {
            this.BuildContent(item.id)
          }
          .tabBar({ text: item.title })
        }, (item: CateforyInterface) => item.id.toString())
      }
      .height('auto')//设置高度为自定义，避免高度计算错误
      .onChange((index: number) => {
        this.currentIndex = index;
      })
      .barHeight(50)
      .width('90%')
  }

  @Builder
  BuildContent(categoryType: CategoryType) {
    ShopItemContent({ categoryType: categoryType})
  }
}