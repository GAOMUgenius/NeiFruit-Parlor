import { BuilderNameConstants } from "routermodule";
import { Logger } from "utils";

const TAG = '[LoginHarInit]'
export function harInit(builderName: string): void {
  Logger.info(TAG, `进入harInit函数，传入的builderName为: ${builderName}`); // 函数入口处添加日志
  switch (builderName) {
    case BuilderNameConstants.LOGIN_LOGINPAGE:
      Logger.info(TAG, `匹配到LOGIN_LOGINPAGE分支，准备导入LoginPage模块`); // case分支添加日志
      import ("./src/main/ets/pages/LoginPage");
      break;
    default:
      Logger.info(TAG, `进入default分支`);
      break;
  }
}