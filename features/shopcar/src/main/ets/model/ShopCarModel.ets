import { ProductData } from 'uicomponents'

export const shopCarInfo: ProductData[] = [
  new ProductData(
    1,
    'app.media.OIP',
    "有机小米",
    "78.5",
    "袋",
    "1.8",
    "kg",
  ),
  new ProductData(
    2,
    'app.media.OIP',
    "有机小米",
    "78.5",
    "袋",
    "1.8",
    "kg",
  ),
  new ProductData(
    3,
    'app.media.OIP',
    "有机小米",
    "78.5",
    "袋",
    "1.8",
    "kg",
  )
]

export interface ShopChangeInterface {
  onItemContentChange(): void
  onSelectionChange(id: string, selection: boolean): void
}
