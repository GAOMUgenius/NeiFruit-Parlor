import { BuilderNameConstants } from "routermodule";

export function harInit(builderName: string): void {
  switch (builderName) {
    case BuilderNameConstants.HOME_SHOPINFOPAGE:
      import ("./src/main/ets/Pages/ShopInfoPage");
      break;
    case BuilderNameConstants.HOME_SHOPAPPRAISEPAGE:
      import ("./src/main/ets/Pages/ShopAppraisePage");
      break;
    default:
      break;
  }
}
