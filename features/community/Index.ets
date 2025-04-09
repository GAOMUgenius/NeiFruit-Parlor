

import { BuilderNameConstants } from "routermodule";

export function harInit(builderName: string): void {
  switch (builderName) {
    case BuilderNameConstants.COMMUNITY_POSTPAGE:
      import ("./src/main/ets/pages/PostPage");
      break;
    case BuilderNameConstants.COMMUNITY_POSTPUBLISHPAGE:
      import ("./src/main/ets/pages/PostPublishPage");
      break;
    default:
      break;
  }
}
export { CommunityPage } from './src/main/ets/pages/CommunityPage'
