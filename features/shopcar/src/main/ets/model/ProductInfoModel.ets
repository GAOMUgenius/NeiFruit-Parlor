import { ProductData } from "uicomponents"
@Observed
export class ProductInfoParameter extends ProductData {
  @Track productinfo_storage: string //存储条件
  @Track productinfo_reason: string //推荐理由
  @Track productinfo_advantage: string //商品优势
  @Track productinfo_brand: string //商品品牌
  @Track productinfo_origin: string //产地
  @Track product_raw_material: string;
  @Track productinfo_picture: ResourceStr[];
  @Track productinfo_introduce: string;

  constructor(
    id: number,
    product_picture: ResourceStr,
    product_name: string,
    product_price: string,
    product_unit: string,
    product_capacity: string,
    product_capacity_unit: string,
    productinfo_storage: string,
    productinfo_reason: string,
    productinfo_advantage: string,
    productinfo_brand: string,
    productinfo_origin: string,
    product_raw_material: string,
    productinfo_picture: ResourceStr[],
    productinfo_introduce: string
  ) {
    super(id,
      product_picture,
      product_name,
      product_price,
      product_unit,
      product_capacity,
      product_capacity_unit)
    this.productinfo_storage = productinfo_storage;
    this.productinfo_reason = productinfo_reason;
    this.productinfo_advantage = productinfo_advantage;
    this.productinfo_brand = productinfo_brand;
    this.productinfo_origin = productinfo_origin;
    this.productinfo_picture = productinfo_picture;
    this.product_raw_material = product_raw_material;
    this.productinfo_introduce = productinfo_introduce
  }
}

export const productInfoParameter: ProductInfoParameter = new ProductInfoParameter(
  1,
  $r('app.media.productinfo_picture_1'),
  '小龙虾神仙桶',
  '99',
  '份',
  '1.5',
  'kg',
  '冷冻',
  '小龙虾，蒜蓉味',
  '鲜甜Q弹',
  '深海捕捞',
  '深海牌',
  '产地',
  [
    $r('app.media.productinfo_picture_1'),
    $r('app.media.productinfo_picture_2'),
    $r('app.media.productinfo_picture_3'),
    $r('app.media.productinfo_picture_4'),
    $r('app.media.productinfo_picture_5'),
  ],
  '洪湖鲜活好虾，清水养殖，三挑三选成就三白好虾;秘制蒜蓉酱，虾肉紧实回甘，汤汁拌饭拌面都好吃'
)
export const productInfoParameterList: ProductInfoParameter[] =[
  new ProductInfoParameter(
  1,
  'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/eb23006d89832418d5ee56f94944bea.png',
  "泰国金枕头冷冻榴莲肉 ",
  "45.9",
  "盒",
  "300",
  "g/盒",
  '冷冻',
  '家庭分享装',
  '冰淇淋口感',
  '泰国进口',
  '邻优果坊优选',
  '泰国',
  [
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/eb23006d89832418d5ee56f94944bea.png',
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/e202edf432f2f94a3aee2ecdeea8310.png',
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/a0b87ca72c7826af16995f955e76e7d.png',
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/7a23c6c8810af9c899d0ee9b84ac8bc.png',
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/93da2fcd28e5d498f5d9830baaf2d16.png',
  ],
  '树熟鲜果剥肉，急速冷冻锁鲜，果肉金黄饱满，直接吃口感像冰淇淋，烘烤吃香气十足，软糯绵密。'
),
  new ProductInfoParameter(
    2,
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/1a16effd960b7f977d0f39684cbff35.png',
    "智利西梅 ",
    "16.9",
    "盒",
    "350",
    "g/盒",
    '干燥阴凉处',
    '低Gi水果',
    '顶部轻微皱缩',
    '新鲜采摘',
    '邻优果坊优选',
    '智利',
    [
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/1a16effd960b7f977d0f39684cbff35.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/6ac054650e3b17f150f57a0b89941fb.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/696a3676086a0abc978ea2e89eaec81.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/bd727429c4d820be79b3a7d3d5224f6.png',
    ],
    '大果更满足，低Gi（低升糖指数水果），控糖友好水果，脆时微爽酸口，放软后更甜蜜。'
  ),
  new ProductInfoParameter(
    3,
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/9a32e6b1b642a7a683036390acfea5d.png',
    "埃及红西柚 两粒装 ",
    "14.9",
    "盒",
    "290",
    "g+",
    '冷藏保存',
    '口感一绝',
    '榨汁调味佐餐',
    '新鲜采摘',
    '邻优果坊优选',
    '埃及',
    [
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/9a32e6b1b642a7a683036390acfea5d.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/714e83052a7315e2fd631f283bc4a8c.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/1aa6dcf5fc4dd3a01f855dda5d374e9.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/68a5083a240808c98a97c1c7758de75.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/9ea6c3447706f973314113775961abd.png',
    ],
    '口感高酸带微苦，更适合榨汁调果味饮料，搭配沙拉佐餐，冷藏保存风味更佳。'
  ),
  new ProductInfoParameter(
    4,
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/4c00db6bddeefeedaba214d2f295dbd.png',
    "云南超大蓝莓 ",
    "16.9",
    "盒",
    "125",
    "g",
    '冷藏保存',
    '八分甜两分酸',
    '皮薄轻咬爆浆',
    '新鲜采摘',
    '邻优果坊优选',
    '云南红河',
    [
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/4c00db6bddeefeedaba214d2f295dbd.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/f7ee8c231ce3603eafc45d4d8c56fcd.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/d2173fd90de0ba2045cec5664dc5aba.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/4600a23d93f95104d978b881561b080.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/c55b05f8193fe1dd6b98876711a66fd.png',
    ],
    '22mm果经超大果，云南高山种植，果皮薄脆轻咬爆浆，吃到嘴里八分甜两分酸，含花青素，健康低卡。'
  ),
  new ProductInfoParameter(
    5,
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/40e5a8e571d1f1a655c2a60689267d2.png',
    "龙井冰皮绿豆糕 ",
    "15.9",
    "盒",
    "12",
    "粒",
    '冷藏保存',
    '皮薄馅足',
    '细腻绵软',
    '脱皮绿豆',
    '邻优果坊优选',
    '见产品外包装',
    [
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/40e5a8e571d1f1a655c2a60689267d2.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/b569ca5bfc2cd4c661ef1999e0696aa.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/eb5b39631a482839d36b51f5bf26ddb.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/81ad60c098b731f26463e88e4b875ad.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/e241e93c4a02f2d508d5de05cb09ded.png',
    ],
    '茶道级龙井研磨，纯进口绿豆制，0蔗糖，0反式脂肪酸，超薄外皮配合超多馅料，入口绵密'
  ),
  new ProductInfoParameter(
    6,
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/6dac35cde9fcd85d938fe4798cf2411.png',
    "蒙牛 特仑苏 纯牛奶 ",
    "39.9",
    "箱",
    "250",
    "ml*12",
    '冷藏保存',
    '3.6g蛋白质',
    '120mg高钙',
    '牛奶',
    '邻优果坊优选',
    '见产品外包装',
    [
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/6dac35cde9fcd85d938fe4798cf2411.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/f66d148b2f498c12b2e2c109b3492ea.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/387c4d4ad721131619d82cb3f8ca193.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/80821297b75952b8b6d3e50afa5f19c.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/89495faf9fdcb15324b8a029c433054.png',
    ],
    '不是所有的牛奶都叫特仑苏，精选奶源，专属牧场'
  ),
  new ProductInfoParameter(
    7,
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/bc84386c760f07ed22bc947fa33d478.png',
    "罗马生菜 ",
    "4.98",
    "份",
    "400",
    "g",
    '阴凉干燥',
    '烤肉时刻解腻',
    '低卡轻食爱好',
    '新鲜蔬菜',
    '邻优果坊优选',
    '云南',
    [
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/bc84386c760f07ed22bc947fa33d478.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/d561a4177ab3e6dc4ea9559b1ab2f97.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/bef278fcc3fa2aa97f0ab7003101a37.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/529f1407f7cdd824ebef85837a73102.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/49197e516df1c2a85869965bd245e58.png',
    ],
    '烤肉伴侣，每日新鲜采摘的生菜，超级鲜嫩，茎叶挺拔水润，质地柔嫩，味道清香，低卡轻食，白灼也美味'
  ),
  new ProductInfoParameter(
    8,
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/474a62ae815919ed02e04cc1b0de4c9.png',
    '小龙虾神仙桶 ',
    '99',
    '份',
    '1.5',
    'kg',
    '冷冻',
    '小龙虾，蒜蓉味',
    '鲜甜Q弹',
    '深海捕捞',
    '深海牌',
    '产地',
    [
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/474a62ae815919ed02e04cc1b0de4c9.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/030de95e9123079b91670657bf5dc17.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/85c3042a6a4d88821074c5a8850389f.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/9848eb598324af4a91a0a9a4ac55a6c.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/2f869cfbe605aa80df640a1494ef737.png',
    ],
    '洪湖鲜活好虾，清水养殖，三挑三选成就三白好虾;秘制蒜蓉酱，虾肉紧实回甘，汤汁拌饭拌面都好吃'
  ),
  new ProductInfoParameter(
    9,
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/239941b3884b676ede55eac295a04fa.png',
    '提拉米苏蛋糕 ',
    '59.9',
    '个',
    '1',
    'kg',
    '冷冻',
    '6-8人份',
    '动物奶油',
    '稀奶油',
    '邻优果坊优选',
    '见产品外包装',
    [
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/239941b3884b676ede55eac295a04fa.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/b065c6c9a4556464775dd4378e9a35a.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/feba2e49d23e520c0cd609e1ee8e52d.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/e55ebd424bbc768b6e72829166e3247.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/d341e252480b3824e0787775413b4b9.png',
    ],
    '朗姆酒香衬托着奶香，奶油细腻轻盈，甜度适中，搭配被咖啡液浸润的手指饼干，甜味和苦味融合'
  ),
  new ProductInfoParameter(
    10,
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/8f3744b5bff6852555d09bfc7a6529b.png',
    '炫彩什锦寿司组合 ',
    '17.9',
    '盒',
    '365',
    'g',
    '冷藏',
    '手工制作',
    '8种组合',
    '大米',
    '邻优果坊优选',
    '见产品外包装',
    [
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/8f3744b5bff6852555d09bfc7a6529b.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/3300cbeb459a80c181df10200558d16.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/5ee7e47b919b6508b8648a0bda18463.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/38274deed3a9a72ed3bcf123174d568.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/6664fc331b23efa5e409261513554c0.png',
    ],
    '搭配蟹肉棒、目鱼花、裙带菜、芝麻和鸡蛋黄，造型精致小巧，炫彩什锦寿司，8种口味一次享'
  ),
  new ProductInfoParameter(
    11,
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/2633341b834f1846a0ed89d8f5da816.png',
    '生菜玉米蔬菜沙拉 ',
    '9.9',
    '盒',
    '180',
    'g',
    '冷藏',
    '5种新蔬',
    '特制沙拉汁',
    '意大利生菜',
    '邻优果坊优选',
    '见产品外包装',
    [
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/2633341b834f1846a0ed89d8f5da816.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/f8716310eed52ae620f9d0a5d05d9e6.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/2c6ab770d506a37d799443dc130da30.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/b4e773d8fa7458160704ccd71aaf937.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/c066011f1963b0c816fff70a8f24972.png',
    ],
    '严选玉米粒、圣女果、黄瓜片、紫甘蓝丝、球生菜;搭配特制丘比沙拉汁，清新爽脆'
  ),
  new ProductInfoParameter(
    12,
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/03a6b462492437a87456bad28a08b81.png',
    '谷饲原切牛腩块 ',
    '45.9',
    '袋',
    '1',
    'kg',
    '冷藏',
    '进口原切牛肉',
    '肥瘦比2:8',
    '牛肉',
    '邻优果坊优选',
    '见产品外包装',
    [
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/03a6b462492437a87456bad28a08b81.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/7f1c99d863c36c00678aae370169689.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/619ec426a514056a2fcf95efe4abda3.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/4f2034621718129a2cb404642c943a1.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/773f0f81455cea6cb5d1b1e45031e9f.png',
    ],
    '自然牧场精选好牛，牛胸腹部位原切无调理，整包牛腩肥瘦比2:8.部分肉块含少许牛筋，炖煮煎炒当宜'
  ),
  new ProductInfoParameter(
    13,
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/85571c602b94f9c8fbd321765bd7420.png',
    '国产沃柑 ',
    '9.9',
    '盒',
    '900',
    'g',
    '干燥阴凉处',
    '纯甜不带酸味',
    '有少量籽',
    '新鲜果蔬',
    '邻优果坊优选',
    '云南玉溪',
    [
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/85571c602b94f9c8fbd321765bd7420.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/2b36e1afdb4e0b218c6ced554e92fe8.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/3c05626995784629ed12991ddddfdad.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/584fe5187b1bae80ec6e3ff37461471.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/f2af8d40da2a2f5600536401ef8af4c.png',
    ],
    '新鲜采摘直发，皮较薄易手剥，纯甜带微酸，多汁清爽不腻有少量籽，食用时注意哦~'
  ),
  new ProductInfoParameter(
    14,
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/390108ae1fbfe45d6d48f2635150919.png',
    '【鲜果切】酸嘢双拼(芭乐+青芒果) ',
    '19.9',
    '盒',
    '300',
    'g',
    '冷藏',
    '餐后解腻推荐',
    '附赠料包',
    '新鲜芭乐、芒果',
    '邻优果坊优选',
    '见产品外包装',
    [
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/390108ae1fbfe45d6d48f2635150919.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/b1ff46e29b079b062523f2e8be334ac.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/2d391284c57c3e23fb4be6a0a486b7c.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/f7c066e62fb344779ffdbb25227e32d.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/d83ed7b24927a68106f6f802524cabd.png',
    ],
    '青芒与芭乐，超爽口双拼搭配，硬果生食咬一口满嘴的酸爽，加入酸梅粉搭配更好吃!'
  ),
  new ProductInfoParameter(
    15,
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/2c66b6ddf42d30e73f3ca4962fdd9cd.png',
    '鲜活 精养虎背鲈鱼 ',
    '19.9',
    '条',
    '400 - 500',
    'g/条',
    '鲜活',
    '清蒸无土腥味',
    '肉鲜实紧嫩',
    '新鲜鲈鱼',
    '邻优果坊优选',
    '广东佛山',
    [
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/2c66b6ddf42d30e73f3ca4962fdd9cd.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/5e13a10b923a64759828c9cd94e65de.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/97348205923254ebf3fec1d43dd9dd7.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/b5799256c40d6163157da28a9db09b1.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/1a2342cba823644a0303ee7f0406d4b.png',
    ],
    '优养优饲，游动中外形似虎背，爱运动油脂少，鱼肉肌理呈蒜瓣状，吃起来没有土腥味。充氧打包鲜活到家。'
  ),
  new ProductInfoParameter(
    16,
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/ba10c3138e090f0da93c7cec0acd2f1.png',
    '青柠芝士 ',
    '29.9',
    '盒',
    '330',
    '4粒',
    '冷藏',
    '动物奶油',
    '清新酸甜',
    '新鲜鲈鱼',
    '稀奶油',
    '陕西西安',
    [
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/ba10c3138e090f0da93c7cec0acd2f1.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/ea0744bd855624c375deeaf5801ccfc.png',
      'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/c8322e82d3b8838c13bfd3d673a3bd9.png',
    ],
    '口感属于绵密+颗粒的结合，放入冰箱冷冻半小时口感瞬间升级，冰凉清爽 ~'
  ),
]

export class SellingPointInfoList {
  sellingPoint: string
  sellingTitle: string

  constructor(sellingPoint: string, sellingTitle: string) {
    this.sellingPoint = sellingPoint;
    this.sellingTitle = sellingTitle
  }
}

