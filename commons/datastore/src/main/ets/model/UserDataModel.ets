export class UserData {
  uid: string = ''
  userType: UserTypeEnum = UserTypeEnum.OWNER
  username: string = '新用户'
  useremail: string = '2047772125@qq.com'
  user_introduction: string = '鸭头博是书杯贱婢建构春竹铸币主笔建构简笔坚壁间壁';
  background: string = '';
  community: string = ''
  password: string = 'Lion123'
  user_picture: string = 'app.media.userImg'
  token: string | null = null
}
@Observed
export class SginUser {
  email: string = '2047772125@qq.com'
  password1: string = ''
  password2: string = ''
}

export enum UserTypeEnum {
  OWNER = 1,
  PROPERTY= 2
}