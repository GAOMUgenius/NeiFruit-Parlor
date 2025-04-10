import { PreferenceManager } from 'datastore';
import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from 'routermodule';
import { replaceRouterModel } from 'routermodule/src/main/ets/model/RouterModel';
import { Logger, PromptActionClass } from 'utils';
import { AppConstants } from '../constants/AppConstants'
import { common } from '@kit.AbilityKit';
import { ComponentContent, router } from '@kit.ArkUI';
import { bundleManager } from '@kit.MDMKit';


@Entry
@Component
struct Index {
  // 控制闪屏页可见性的状态变量
  @State showSplash: boolean = true
  // 主路由堆栈
  @State indexPathStack: NavPathStack = new NavPathStack()
  // 获取 UIAbility 上下文用于退出应用
  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;

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
  };

  @Builder
  routerMap(builderName: string, param: object) {
    // 根据模块名称获取 WrappedBuilder 对象，通过 builder 界面创建页面，并导入 param 参数。
    RouterModule.getBuilder(builderName).builder(param);
  };



  build() {
    Column() {
      if (this.showSplash) {
        Row() {
          Button('点击跳转')
            .onClick(() => {
              this.showSplash = false; // 销毁闪屏页
              replaceRouterModel(RouterNameConstants.PHONE_INDEX, BuilderNameConstants.LOGIN_LOGINPAGE);
              // const bundleName = (getContext(this) as common.UIAbilityContext).applicationInfo.name;
              // router.pushUrl({
              //   url: `@bundle:${bundleName}/login/ets/pages/LoginPage`,
              //   params: {
              //     data1: 'message'
              //   }
              // }, router.RouterMode.Standard, (err) => {
              //   if (err) {
              //     console.error(`replaceNamedRoute failed, code is ${err.code}, message is ${err.message}`);
              //     return;
              //   }
              //   console.info('replaceNamedRoute success');
              // })
            })
        }

      } else {
        Navigation(this.indexPathStack) {
          // 主路由容器（空内容，由路由控制）
          Column() {
            // 此处可以为空，实际内容由路由控制
            Row() {
              Button('退出应用')
                .type(ButtonType.Capsule)
                .backgroundColor('#ff4500')
                .onClick(() => {
                  this.context.terminateSelf(); // 执行退出
                })

              Button('取消')
                .type(ButtonType.Capsule)
                .backgroundColor('#228b22')
                .margin({ left: 20 })
                .onClick(() => {
                  replaceRouterModel(RouterNameConstants.PHONE_INDEX, BuilderNameConstants.LOGIN_LOGINPAGE)
                })
            }
            .justifyContent(FlexAlign.Center)
            .width('100%')
            .height('10%')
            .padding(20)
          }
        }
        .navDestination(this.routerMap)
      }
    }
  }
}
