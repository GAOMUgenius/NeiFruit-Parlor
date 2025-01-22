import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from 'routermodule';
import { Logger } from 'utils';

@Entry
@Component
struct Index {
  @State indexPathStack: NavPathStack = new NavPathStack()
  aboutToAppear() {
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
    Navigation(this.indexPathStack) {
      Row() {
        Text('这里是闪屏页')
        Button('点击进入登录界面')
          .onClick(() => {
            //通过routermap路由进行跳转，跳转到loginpage页面
            buildRouterModel(RouterNameConstants.PHONE_INDEX, BuilderNameConstants.LOGIN_LOGINPAGE)
          })
      }
      .height('100%')
      .width('100%')
    }
    .navDestination(this.routerMap);
  }
}