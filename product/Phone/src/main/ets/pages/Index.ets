import { PreferenceManager } from 'datastore';
import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from 'routermodule';
import { replaceRouterModel } from 'routermodule/src/main/ets/model/RouterModel';
import { Logger, PromptActionClass } from 'utils';
import { AppConstants } from '../constants/AppConstants'
import common from '@ohos.app.ability.common';
import { ComponentContent, router } from '@kit.ArkUI';
import { bundleManager } from '@kit.MDMKit';
import { AMapLocationManagerImpl } from '@amap/amap_lbs_location';
import { AMapPrivacyAgreeStatus, AMapPrivacyInfoStatus, AMapPrivacyShowStatus } from '@amap/amap_lbs_common';
import { Permissions } from '@ohos.abilityAccessCtrl';
import abilityAccessCtrl, { PermissionRequestResult } from '@ohos.abilityAccessCtrl';
import { BusinessError } from '@ohos.base';


@Entry
@Component
struct Index {
  // 控制闪屏页可见性的状态变量
  @State showSplash: boolean = true
  // 主路由堆栈
  @State indexPathStack: NavPathStack = new NavPathStack()
  // 获取 UIAbility 上下文用于退出应用
  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;

  // 引导页数据
  private indexPicture: ResourceStr[] = [$r("app.media.index_Picture_1"), $r("app.media.index_Picture_2"), $r("app.media.index_Picture_3")]
  private DISPLAY_COUNT: number = 1
  private MIN_SCALE: number = 0.75
  @State opacityList: number[] = []
  @State scaleList: number[] = []
  @State translateList: number[] = []
  @State zIndexList: number[] = []


  async aboutToAppear() {
    const preferenceManager = PreferenceManager.getInstance();
    try {
      // 检查是否存在表示是否为初次打开的键
      const hasValue = await preferenceManager.hasValue(AppConstants.IS_FIRST_OPEN_KEY);

      if (!hasValue) {
        // 如果不存在该键，则设置用户为初次打开
        await preferenceManager.setValue(AppConstants.IS_FIRST_OPEN_KEY, true);
        console.log('用户是初次打开 app');
      } else {
        console.log('用户不是初次打开 app');
      }
    } catch (error) {
      console.error('初始化 app 时发生错误:', error);
    }
    if (!this.indexPathStack) {
      this.indexPathStack = new NavPathStack();
    }
    RouterModule.createRouter(RouterNameConstants.PHONE_INDEX, this.indexPathStack);
    Logger.info( `路由 ${RouterNameConstants.PHONE_INDEX} 是否创建成功: ${RouterModule.getRouter(RouterNameConstants.PHONE_INDEX)!= null}`);
    // 引导页数据
    for (let i = 0; i < this.indexPicture.length; i++) {
      this.opacityList.push(1.0)
      this.scaleList.push(1.0)
      this.translateList.push(0.0)
      this.zIndexList.push(0)
    }
  };

  @Builder
  routerMap(builderName: string, param: object) {
    // 根据模块名称获取 WrappedBuilder 对象，通过 builder 界面创建页面，并导入 param 参数。
    RouterModule.getBuilder(builderName).builder(param);
  };

  @Builder
  indexPage(item: ResourceStr, index: number) {
    if (index != 2) {
      Column() {
        Image(item)
          // 自定义动画变化透明度、缩放页面、抵消系统默认位移、渲染层级等
          .opacity(this.opacityList[index])
          .scale({ x: this.scaleList[index], y: this.scaleList[index] })
          .translate({ x: this.translateList[index] })
          .zIndex(this.zIndexList[index])
          .height('100%')
          .width('100%')
      }
      .height('100%')
      .width('100%')
    } else {
      Stack() {
        Image(item)
          // 自定义动画变化透明度、缩放页面、抵消系统默认位移、渲染层级等
          .opacity(this.opacityList[index])
          .scale({ x: this.scaleList[index], y: this.scaleList[index] })
          .translate({ x: this.translateList[index] })
          .zIndex(this.zIndexList[index])
          .height('100%')
          .width('100%')
        Button('立即加入 →')
          .backgroundColor('#1d63ff')
          .margin({ bottom: 20 })
          .width('70%')
          .onClick(() => {
            this.showSplash = false; // 销毁闪屏页
            buildRouterModel(RouterNameConstants.PHONE_INDEX, BuilderNameConstants.LOGIN_LOGINPAGE);
          })
      }
      .alignContent(Alignment.Bottom)
      .height('100%')
      .width('100%')
    }
  }



  build() {
    Navigation(this.indexPathStack) {
      Column() {
        Swiper() {
          ForEach(this.indexPicture, (item: ResourceStr, index: number) => {
            this.indexPage(item, index)
          })
        }
        .height('100%')
        .indicator(false)
        .displayCount(this.DISPLAY_COUNT, true)
        .loop(false)
        .customContentTransition({
          // 页面移除视窗时超时1000ms下渲染树
          timeout: 1000,
          // 对视窗内所有页面逐帧回调transition，在回调中修改opacity、scale、translate、zIndex等属性值，实现自定义动画
          transition: (proxy: SwiperContentTransitionProxy) => {
            if (proxy.position <= proxy.index % this.DISPLAY_COUNT || proxy.position >= this.DISPLAY_COUNT + proxy.index % this.DISPLAY_COUNT) {
              // 同组页面往左滑或往右完全滑出视窗外时，重置属性值
              this.opacityList[proxy.index] = 1.0
              this.scaleList[proxy.index] = 1.0
              this.translateList[proxy.index] = 0.0
              this.zIndexList[proxy.index] = 0
            } else {
              // 同组页面往右滑且未滑出视窗外时，对同组中左右两个页面，逐帧根据position修改属性值，实现两个页面往Swiper中间靠拢并透明缩放的自定义切换动画
              if (proxy.index % this.DISPLAY_COUNT === 0) {
                this.opacityList[proxy.index] = 1 - proxy.position / this.DISPLAY_COUNT
                this.scaleList[proxy.index] = this.MIN_SCALE + (1 - this.MIN_SCALE) * (1 - proxy.position / this.DISPLAY_COUNT)
                this.translateList[proxy.index] = - proxy.position * proxy.mainAxisLength + (1 - this.scaleList[proxy.index]) * proxy.mainAxisLength / 2.0
              } else {
                this.opacityList[proxy.index] = 1 - (proxy.position - 1) / this.DISPLAY_COUNT
                this.scaleList[proxy.index] = this.MIN_SCALE + (1 - this.MIN_SCALE) * (1 - (proxy.position - 1) / this.DISPLAY_COUNT)
                this.translateList[proxy.index] = - (proxy.position - 1) * proxy.mainAxisLength - (1 - this.scaleList[proxy.index]) * proxy.mainAxisLength / 2.0
              }
              this.zIndexList[proxy.index] = -1
            }
          }
        })
        .onContentDidScroll((selectedIndex: number, index: number, position: number, mainAxisLength: number) => {
          // 监听Swiper页面滑动事件，在该回调中可以实现自定义导航点切换动画等
          console.info("onContentDidScroll selectedIndex: " + selectedIndex + ", index: " + index + ", position: " + position + ", mainAxisLength: " + mainAxisLength)
        })
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .height('100%')
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .navDestination(this.routerMap)
    .hideTitleBar(true)
  }
}
