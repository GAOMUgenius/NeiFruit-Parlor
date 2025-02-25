import { BuilderNameConstants } from "routermodule"

export interface UserInfoData {
  id: InfoType
  title: string
  infoRouter?: string
}

export enum InfoType {
  NAME = 0,
  PICTURE,
  EMAIL,
  INTRODUCE,
  BACKGROUND
}
export const UserInfo: UserInfoData[] = [
  {
    id: InfoType.NAME,
    title: "昵称",
    infoRouter: BuilderNameConstants.MINE_NAMECHANGE
  },
  {
    id: InfoType.PICTURE,
    title: "头像"
  },
  {
    id: InfoType.EMAIL,
    title: "邮箱"
  },
  {
    id: InfoType.INTRODUCE,
    title: "个人简介"
  },
  {
    id: InfoType.BACKGROUND,
    title: "背景"
  },
]

