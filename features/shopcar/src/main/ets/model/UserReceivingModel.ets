export class UserRecevingData {
  adress: string;
  adressinfo: string;
  name: string;
  phone: string;
  constructor(adress: string = '西柚学院', adressinfo: string = '铁门', name: string = '嘻嘻学啥呢', phone: string = '13213135252') {
    this.adress = adress
    this.adressinfo = adressinfo
    this.name = name
    this.phone = phone
  }
}