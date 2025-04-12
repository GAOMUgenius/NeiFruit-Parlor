export class AppraiseData {
  id: number
  post_id: number
  user_name: string
  user_picture: ResourceStr
  user_rating: number
  user_content: string
  user_content_picture?: ResourceStr[]

  constructor(id: number = 1000, post_id: number = 0,user_name: string = '嘻嘻学啥呢', user_picture: ResourceStr = $r('app.media.user_picture1'), user_rating: number = 4, user_content: string = '非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满', user_content_picture: ResourceStr[] = []) {
    this.id = id
    this.post_id = post_id
    this.user_name = user_name
    this.user_picture = user_picture
    this.user_rating = user_rating
    this.user_content = user_content
    this.user_content_picture = user_content_picture
  }
}

export const appraisePostDataList: AppraiseData[] = [
// 帖子0的评论
  new AppraiseData(
    0,
    0,
    "夜猫子自救协会",
    "https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/2f15091e224436b725ad059910432e9.png",
    5,
    "凌晨三点还在改方案的设计狗含泪点赞，NK细胞活性那个数据太扎心了！",
    ["https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/eb8b4e324c5f75d0bfc4edf6b8edcd4.png"]
  ),
  new AppraiseData(
    1,
    0,
    "养生小达人",
    "https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/2f15091e224436b725ad059910432e9.png",
    4,
    "试过23:00睡7:00起，皮肤真的会发光！就是中午需要补个20分钟小睡"
  ),

  // 帖子1的评论
  new AppraiseData(
    2,
    1,
    "失眠终结者",
    "https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/2f15091e224436b725ad059910432e9.png",
    5,
    "亲测恐怖游戏疗法有效！看《瘦长鬼影》实况10分钟火速关机睡觉",
    ["https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/d4a12ece213fb33c9f80c4e2b29f86c.png"]
  ),

  // 帖子2的评论
  new AppraiseData(
    3,
    2,
    "劳动仲裁达人",
    "https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/2f15091e224436b725ad059910432e9.png",
    5,
    "补充一个重要细节：微信聊天记录也是有效证据！记得让老板发文字别发语音",
    ["https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/8eadb2f0cbff5b1ceb006de22f1d0a1.png"]
  ),

  // 帖子3的评论
  new AppraiseData(
    4,
    3,
    "耳塞收藏家",
    "https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/2f15091e224436b725ad059910432e9.png",
    4,
    "建议搭配使用：3M耳塞+白噪音app+侧睡枕，三重防护效果更佳"
  ),

  // 帖子4的评论
  new AppraiseData(
    5,
    4,
    "皮蛋爱好者",
    "https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/2f15091e224436b725ad059910432e9.png",
    5,
    "科普到位！凉拌皮蛋加点姜末和醋，完美解决涩味问题",
    ["https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/c6ec9206a575152a89b77f7177cbd12.png"]
  )
];
export const appraiseProductDataList: AppraiseData[] = [
// 泰国金枕头冷冻榴莲肉 (id:1)
  new AppraiseData(
    1001,
    1,
    "榴莲控本控",
    "https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/2f15091e224436b725ad059910432e9.png",
    5,
    "冷冻技术绝了！解冻后就像现开的果肉，绵密香甜像冰淇淋，核超小~",
    ["https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/8eadb2f0cbff5b1ceb006de22f1d0a1.png"]
  ),

  // 智利西梅 (id:2)
  new AppraiseData(
    1002,
    2,
    "通便小能手",
    "https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/2f15091e224436b725ad059910432e9.png",
    4,
    "果肉饱满多汁，酸甜比例刚好！建议放软点更甜，办公室下午茶必备"
  ),

  // 埃及红西柚 (id:3)
  new AppraiseData(
    1003,
    3,
    "维C达人",
    "https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/2f15091e224436b725ad059910432e9.png",
    5,
    "爆汁程度惊人！微苦回甘的正宗西柚味，配蜂蜜做饮品绝了"
  ),

  // 云南超大蓝莓 (id:4)
  new AppraiseData(
    1004,
    4,
    "护眼狂魔",
    "https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/2f15091e224436b725ad059910432e9.png",
    4,
    "每颗都有硬币大小！脆甜无渣，给宝宝做辅食超合适",
    ["https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/d4a12ece213fb33c9f80c4e2b29f86c.png"]
  ),

  // 龙井冰皮绿豆糕 (id:5)
  new AppraiseData(
    1005,
    5,
    "茶点爱好者",
    "https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/2f15091e224436b725ad059910432e9.png",
    5,
    "茶香惊艳！冰皮Q弹不粘牙，配凤凰单丛就是完美下午茶"
  ),

  // 特仑苏纯牛奶 (id:6)
  new AppraiseData(
    1006,
    6,
    "牛奶鉴定家",
    "https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/2f15091e224436b725ad059910432e9.png",
    5,
    "日期新鲜到震惊！加热后奶皮超厚，咖啡拉花成功率+50%"
  ),

  // 罗马生菜 (id:7)
  new AppraiseData(
    1007,
    7,
    "沙拉大师",
    "https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/2f15091e224436b725ad059910432e9.png",
    4,
    "叶片脆嫩无黄边！做汉堡夹层比面包店用的还新鲜"
  ),

  // 小龙虾神仙桶 (id:8)
  new AppraiseData(
    1008,
    8,
    "宵夜党主席",
    "https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/2f15091e224436b725ad059910432e9.png",
    5,
    "虾黄多到离谱！加热5分钟秒杀大排档，建议配冰啤酒食用",
    ["https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/c6ec9206a575152a89b77f7177cbd12.png"]
  ),

  // 提拉米苏蛋糕 (id:9)
  new AppraiseData(
    1009,
    9,
    "甜品侦察兵",
    "https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/2f15091e224436b725ad059910432e9.png",
    4,
    "酒香浓郁不腻口！手指饼干吸饱咖啡液的口感太治愈了"
  ),

  // 炫彩什锦寿司 (id:10)
  new AppraiseData(
    1010,
    10,
    "日料达人",
    "https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/2f15091e224436b725ad059910432e9.png",
    5,
    "居然有真蟹柳！海苔脆度保持得很好，微波加热也不塌"
  )
];