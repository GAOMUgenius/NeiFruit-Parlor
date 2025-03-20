import { BuilderNameConstants } from "routermodule";

export function harInit(builderName: string): void {
  switch (builderName) {
    case BuilderNameConstants.SHOPCAR_PRODUCTINFOPAGE:
      import ("./src/main/ets/Pages/ProductInfoPage");
      break;
    default:
      break;
  }
}
