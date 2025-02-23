export interface PayManageData {
  img: Resource
  title: string
}

export const PayManageInfo: PayManageData[] = [
  {
    img: $r('app.media.pay_manage_orders'),
    title: '订单管理'
  },
  {
    img: $r("app.media.pay_manage_renewal"),
    title: '续费管理'
  },
  {
    img: $r('app.media.pay_manage_bill'),
    title: '费用账单'
  },
  {
    img: $r('app.media.pay_manage_invoice'),
    title: '发票管理'
  }
]

