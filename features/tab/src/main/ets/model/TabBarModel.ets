
export interface TabBarData {
  id: TabBarType;
  title: ResourceStr;
  activeIcon: ResourceStr;
  defaultIcon: ResourceStr;
}

export enum TabBarType {
  MAINPAGE = 0,
  SHOPPINGCAR,
  MINE
}

export const TabsInfo: TabBarData[] = [
  {
    id: TabBarType.MAINPAGE,
    title: '首页',
    activeIcon: $r('app.media.ic_tab_mainpage_on'),
    defaultIcon: $r('app.media.ic_tab_mainpage_off')
  },
  {
    id: TabBarType.SHOPPINGCAR,
    title: '购物车',
    activeIcon: $r('app.media.ic_tab_shoppingcar_on'),
    defaultIcon: $r('app.media.ic_tab_shoppingcar_off')
  },
  {
    id: TabBarType.MINE,
    title: '我的',
    activeIcon: $r('app.media.ic_tab_mine_on'),
    defaultIcon: $r('app.media.ic_tab_mine_off')
  }
]