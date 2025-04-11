export interface PayManageData {
  img: Resource
  title: string
}


export const PayManageInfo: PayManageData[] = [
  {
    img: $r('app.media.pay_manage_pay'),
    title: '待付款'
  },
  {
    img: $r("app.media.pay_manage_delivery"),
    title: '待发货'
  },
  {
    img: $r('app.media.pay_manage_takeover'),
    title: '待收货'
  },
  {
    img: $r('app.media.pay_manage_evaluate'),
    title: '待评价'
  },
  {
    img: $r('app.media.pay_manage_service'),
    title: '退款/售后'
  }
]

