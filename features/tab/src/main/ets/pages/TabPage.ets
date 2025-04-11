import { RouterModule, RouterNameConstants } from "routermodule"
import { CustomTabBar } from "../components/CustomTabBar"
import { TabBarType } from "../model/TabBarModel"
import { MinePageStruct } from "mine"
import { HomePageStruct } from "home/src/main/ets/Pages/MainPage"
import { ShopCarPage } from 'shopcar/src/main/ets/pages/ShopCarPage'

import { PreferenceConstant, UserData } from 'datastore'
import { ProductDataSource } from 'uicomponents'
import { ProductSelection } from 'uicomponents/src/main/ets/model/ProductModel'
import { CommunityPage } from 'community'
import { bundleManager } from "@kit.AbilityKit"
import { fetchWeatherData, getIpLocation, IpLocationResult, splitRectangle, WeatherResponse } from "utils"
import { OrderData } from "uicomponents/src/main/ets/model/OrderModel"
import { PostDataSource } from "community/src/main/ets/model/PostDataResource"

@Entry({ routeName: 'TabPage' })
@Component
struct TabPage {
  @State currentIndex: TabBarType = TabBarType.MAINPAGE
  @State tabPathStack: NavPathStack = new NavPathStack()
  @State nowWeatherData: WeatherResponse | null = null // 新增天气数据状态
  @State locationError: boolean = false
  @State isLoading: boolean = false
  @State dataReady: boolean = false
  @StorageLink(PreferenceConstant.ORDER_LIST_KEY) orderList: OrderData[] = [];
  @StorageLink(PreferenceConstant.CART_ISCHOOSE_KEY) productSelectionMap: Map<string, ProductSelection> = new Map();
  @StorageLink(PreferenceConstant.CART_KEY) localDataSource: ProductDataSource  = new ProductDataSource()
  @StorageLink(PreferenceConstant.USER_DATA)@Watch('userDataRefresh') userData: UserData  = new UserData()
  @StorageLink(PreferenceConstant.POST_LIST) postListData: PostDataSource = new PostDataSource()
  userDataRefresh() {

  }


  async aboutToAppear(): Promise<void> {
    if (!this.tabPathStack) {
      this.tabPathStack = new NavPathStack();
    }

    RouterModule.createRouter(RouterNameConstants.TABPAGE, this.tabPathStack);

    await this.fetchData()
    this.dataReady = true;
  }

  // 提取数据获取逻辑到独立方法
  private async fetchData(): Promise<void> {
    try {
      this.isLoading = true
      this.locationError = false

      // 1. 获取位置信息
      if (!this.userData?.community_location) {
        const ipLocation = await getIpLocation()
        this.userData.community_location = splitRectangle(ipLocation.rectangle)
        this.userData.community = ipLocation.city
        AppStorage.set(PreferenceConstant.USER_DATA, this.userData);
      }

      // 2. 获取天气数据
      if (this.userData?.community_location) {
        this.nowWeatherData = await fetchWeatherData(this.userData.community_location)
      }
    } catch (error) {
      console.error('数据获取失败:', error)
      this.locationError = true
    } finally {
      this.isLoading = false
    }
  }

  // 处理重试操作
  private handleRetry = () => {
    this.fetchData()
  }

  build() {
    Navigation(this.tabPathStack) {
      if(!this.dataReady) {
        // 加载状态 UI
        Column() {
          Progress({ value: 200 })
          Text('正在加载初始数据...')
        }
        .width('100%')
        .height('100%')
      } else {
        Flex({ direction: FlexDirection.Column }) {
          Tabs({ index: this.currentIndex }) {
            TabContent() {
              HomePageStruct({
                nowWeatherData: this.nowWeatherData,
                locationError: this.locationError,
                onRetry: this.handleRetry
              })
            }

            TabContent() {
              CommunityPage()
            }

            TabContent() {
              ShopCarPage()
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