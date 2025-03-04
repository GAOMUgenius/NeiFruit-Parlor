export class UserAccount {
  uid: string = ''
  userType: UserTypeEnum = UserTypeEnum.OWNER
  userName: string = '新用户'
  userEmail: string = '2047772125@qq.com'
  introduce: string = '鸭头博是书杯贱婢建构春竹铸币主笔建构简笔坚壁间壁';
  background: string = '';
  community: string = ''
  password: string = 'Lion123'
  imgResource: string = 'app.media.userImg'
  balance: string = '0.00'
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