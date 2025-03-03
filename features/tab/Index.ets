import { BuilderNameConstants, RouterNameConstants } from "routermodule";

export function harInit(builderName: string): void {
  switch (builderName) {
    case BuilderNameConstants.TAB_TABPAGE:
      import ("./src/main/ets/pages/TabPage");
      break;
    default:
      break;
  }
}
// export { TabPageStruct } from './src/main/ets/pages/TabPage'

