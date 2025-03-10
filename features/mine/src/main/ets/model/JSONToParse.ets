import { UserData } from "datastore"


//处理用户信息跳转的接口
interface UserAccountJSONToParseInterface{
  _photo_:string,
  UserData: UserData
}
//将router跳转的value转换为UserAccount的工具
export function UserAccountJSONToParse(value: object): UserData {
  return (JSON.parse(JSON.stringify(value)) as UserAccountJSONToParseInterface).UserData
}
