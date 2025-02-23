import { BuilderNameConstants, RouterModule } from "routermodule"
import { CustomTabBar } from "../components/CustomTabBar"
import { TabBarType } from "../model/TabBarModel"
import { MinePageStruct } from "mine"
import { HomePageStruct } from "home/src/main/ets/components/MainPage"
import { UserAccount } from "datastore"

@Component
export struct TabPageStruct {
  @State currentIndex: TabBarType = TabBarType.MAINPAGE
  // @StorageProp user: UserAccount = new UserAccount()
  build() {
    NavDestination() {
      Flex({ direction: FlexDirection.Column }) {
        Tabs({ index: this.currentIndex }) {
          TabContent() {
            HomePageStruct()
          }
          TabContent() {
            MinePageStruct()
          }
        }
        .layoutWeight(1)
        .barHeight(0)
        .scrollable(false)
        .onChange((index) => {this.currentIndex = index;})

        CustomTabBar({ currentIndex: $currentIndex })
      }
      .backgroundColor($r('app.color.mainpage_background'))
      .width('100%')
    }
    .hideTitleBar(true)
  }
}

@Builder
export function TabPage(value: object) {
  TabPageStruct()
}

const builderName = BuilderNameConstants.TAB_TABPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(TabPage);
  RouterModule.registerBuilder(builderName, builder);
}