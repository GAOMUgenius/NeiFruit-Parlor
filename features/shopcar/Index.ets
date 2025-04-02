import { BuilderNameConstants } from "routermodule";

export function harInit(builderName: string): void {
  switch (builderName) {
    case BuilderNameConstants.SHOPCAR_PRODUCTINFOPAGE:
      import ("./src/main/ets/pages/ProductInfoPage");
      break;
    case BuilderNameConstants.SHOPCAR_PRODUCTAPPRAISEPAGE:
      import ("./src/main/ets/pages/ProductAppraisePage");
      break;
    default:
      break;
  }
}
