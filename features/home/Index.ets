import { BuilderNameConstants } from "routermodule";

export function harInit(builderName: string): void {
  switch (builderName) {
    case BuilderNameConstants.HOME_SHOPINFOPAGE:
      import ("./src/main/ets/Pages/ShopInfoPage");
      break;
    default:
      break;
  }
}
