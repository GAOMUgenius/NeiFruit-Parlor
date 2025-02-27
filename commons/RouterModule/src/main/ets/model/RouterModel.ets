
import { RouterModule } from "../utils/RouterModule";


//
export class RouterModel {
  // 路由页面别名，格式为：${bundleName}_${pageName}。
  builderName: string = "";
  // 路由堆栈名称。
  routerName: string = "";
  // 需要传输到页面的参数。
  param?: object = new Object();
}

// 创建路由信息并将其放入路由堆栈表中。
export function buildRouterModel(routerName: string, builderName: string, param?: object) {
  let router: RouterModel = new RouterModel();
  router.builderName = builderName;
  router.routerName = routerName;
  router.param = param;
  RouterModule.push(router);
}

//替换栈顶页面
export function replaceRouterModel(routerName: string, builderName: string, param?: object, animated: boolean = false) {
  let router: RouterModel = new RouterModel();
  router.builderName = builderName;
  router.routerName = routerName;
  router.param = param;
  RouterModule.replace(router, animated);
}

