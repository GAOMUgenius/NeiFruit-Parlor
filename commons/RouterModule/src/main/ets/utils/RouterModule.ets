
import { RouterModel } from '../model/RouterModel';
import { Logger } from 'utils'

const TAG = '[RouterModule]'
export class RouterModule {
  static builderMap: Map<string, WrappedBuilder<[object]>> = new Map<string, WrappedBuilder<[object]>>();
  static routerMap: Map<string, NavPathStack> = new Map<string, NavPathStack>();

  // 按名称注册builder。
  public static registerBuilder(builderName: string, builder: WrappedBuilder<[object]>): void {
    Logger.info(TAG, `注册builder，名称为${builderName}`);
    RouterModule.builderMap.set(builderName, builder);
  }

  // 按名称获取builder。
  public static getBuilder(builderName: string): WrappedBuilder<[object]> {
    const builder = RouterModule.builderMap.get(builderName);
    Logger.info(TAG, `获取builder，名称为${builderName}，获取结果为${builder}`);
    if (!builder) {
      Logger.info('not found builder ' + builderName);
    }
    return builder as WrappedBuilder<[object]>;
  }

  // 按名称注册Router。
  public static createRouter(routerName: string, router: NavPathStack): void {
    RouterModule.routerMap.set(routerName, router);
  }

  // 按名称获取Router。
  public static getRouter(routerName: string): NavPathStack {
    return RouterModule.routerMap.get(routerName) as NavPathStack;
  }

  // 通过获取 Page Stack 跳转到指定的 Page。
  public static async push(router: RouterModel): Promise<void> {
    try {
      const harName = router.builderName.split('_')[0];
      // 动态导入要重定向到的页面。
      try {
        Logger.info(TAG, `即将调用harInit函数，当前router.builderName的值为: ${router.builderName}`);
        await import(harName).then((ns: ESObject): Promise<void> => ns.harInit(router.builderName));
      } catch (importError) {
        // 捕获动态导入页面时出现的错误，比如模块不存在、路径错误等
        Logger.error(`动态导入页面失败，harName: ${harName}，错误信息:`, importError + TAG);
        Logger.error(`调用栈信息:`, importError.stack + TAG);
      }
      try {
        RouterModule.getRouter(router.routerName).pushPath({ name: router.builderName, param: router.param });
      } catch (pushPathError) {
        // 捕获操作页面栈的pushPath方法时出现的错误，比如页面栈不可用、参数格式错误等
        Logger.error(`页面栈pushPath操作失败，routerName: ${router.routerName}，builderName: ${router.builderName}，错误信息:`, pushPathError + TAG);
      }
    } catch (overallError) {
      // 捕获整个push方法执行过程中未被内层catch处理的其他异常，提供更通用的错误提示
      Logger.error(`执行push方法出现整体错误，错误信息:`, overallError + TAG);
    }
  }

  // 通过replacePath跳转到指定的Page
  public static async replace(router: RouterModel, animated: boolean = true): Promise<void> {
    try {
      const harName = router.builderName.split('_')[0];
      // 动态导入要重定向到的页面。
      try {
        Logger.info(TAG, `即将调用harInit函数，当前router.builderName的值为: ${router.builderName}`);
        await import(harName).then((ns: ESObject): Promise<void> => ns.harInit(router.builderName));
      } catch (importError) {
        // 捕获动态导入页面时出现的错误，比如模块不存在、路径错误等
        Logger.error(`动态导入页面失败，harName: ${harName}，错误信息:`, importError + TAG);
        Logger.error(`调用栈信息:`, importError.stack + TAG);
      }
      try {
        const routerStack = RouterModule.getRouter(router.routerName);
        const navPathInfo: NavPathInfo = { name: router.builderName, param: router.param };
        routerStack.replacePath(navPathInfo, animated);
      } catch (replacePathError) {
        // 捕获操作页面栈的replacePath方法时出现的错误，比如页面栈不可用、参数格式错误等
        Logger.error(`页面栈replacePath操作失败，routerName: ${router.routerName}，builderName: ${router.builderName}，错误信息:`,
          replacePathError + TAG);
      }
    } catch (overallError) {
      // 捕获整个replace方法执行过程中未被内层catch处理的其他异常，提供更通用的错误提示
      Logger.error(`执行replace方法出现整体错误，错误信息:`, overallError + TAG);
    }
  }

  // 获取页面堆栈并弹出它。
  public static pop(routerName: string): void {
    // 查找 pop 的相应路由堆栈。
    RouterModule.getRouter(routerName).pop();
  }

  // 获取页面堆栈并将其清除。
  public static clear(routerName: string): void {
    // 查找 pop 的相应路由堆栈。
    RouterModule.getRouter(routerName).clear();
  }

  // 直接跳转到指定的路由。
  public static popToName(routerName: string, builderName: string): void {
    RouterModule.getRouter(routerName).popToName(builderName);
  }
}
