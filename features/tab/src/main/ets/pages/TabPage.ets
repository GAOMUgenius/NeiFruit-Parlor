import { BuilderNameConstants, RouterModule, RouterNameConstants } from "routermodule"
import { CustomTabBar } from "../components/CustomTabBar"
import { TabBarType } from "../model/TabBarModel"
import { MinePageStruct } from "mine"
import { HomePageStruct } from "home/src/main/ets/components/MainPage"
@Entry({ routeName: 'TabPage' })
@Component
struct TabPage {
  @State currentIndex: TabBarType = TabBarType.MAINPAGE
  @State tabPathStack: NavPathStack = new NavPathStack()

  aboutToAppear(): void {
    if (!this.tabPathStack) {
      this.tabPathStack = new NavPathStack();
    }
    RouterModule.createRouter(RouterNameConstants.TABPAGE, this.tabPathStack);
  }

  build() {
    Navigation(this.tabPathStack) {
      Flex({ direction: FlexDirection.Column }) {
        Tabs({ index: this.currentIndex }) {
          TabContent() {
            HomePageStruct()
          }

          TabContent() {

          }

          TabContent() {
            MinePageStruct()
          }
        }
        .layoutWeight(1)
        .barHeight(0)
        .scrollable(false)
        .onChange((index) => {
          this.currentIndex = index;
        })

        CustomTabBar({ currentIndex: $currentIndex })
      }
      .backgroundColor($r('app.color.mainpage_background'))
      .width('100%')
    }
    .navDestination(this.routerMap)
    .hideTitleBar(true)
  }

  @Builder
  routerMap(builderName: string, param: object) {
    // 根据模块名称获取 WrappedBuilder 对象，通过 builder 界面创建页面，并导入 param 参数。
    RouterModule.getBuilder(builderName).builder(param);
  };
}