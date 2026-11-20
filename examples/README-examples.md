# ZeroWasteKit 自定义示例

README 里不放长代码块，具体的改法都放在这个目录，按需复制到 `index.html` 对应位置即可。

---

## 1. 往三餐抽签里加一道新菜

打开 `index.html`，找到 `var COOK = {` 这一段，在对应的餐次里加一行。

以早餐主食为例：

```javascript
breakfast:{
  drinks:[ /* 略 */ ],
  staples:[
    {name:"麦片",   cook:"麦片糊", tip:"麦片用热水或热牛奶边倒边搅成糊"},
    // ↓ 新增这一行
    {name:"馒头",   cook:"蒸",     tip:"冷水上锅蒸 15 分钟，关火焖 3 分钟再开盖"},
    {name:"水饺",   cook:"煮",     tip:"水开下饺，点两次凉水，浮起即熟"}
  ],
  forbid:[ {drink:"黑咖啡", staple:"水饺"} ]
}
```

加完之后，「馒头」会同时出现在早餐抽签池和消耗计划里。

**注意**：`name` 必须和你库存表里的物品名完全一致，否则抽签时匹配不到，等于没加。

---

## 2. 把某个食物设成「必须配菜，不能单独成菜」

给它的 `methods` 加上 `combo:true`，抽签时就会自动找一个清淡蔬菜陪它。

```javascript
lunch:{
  meats:[
    {name:"福鼎肉片", soup:true,  methods:["冬阴功煮","红酸汤煮","清炒"]},
    {name:"金华火腿", soup:false, methods:["清炒","炖"], combo:true}
    //                                       ↑ combo:true = 必须合炒/合炖
  ],
  vegs:[ /* 略 */ ]
}
```

同理，蔬菜如果不能进汤（比如土豆会煮成糊），加 `soupOk:false`：

```javascript
vegs:[
  {name:"生菜",   soupOk:true,  methods:["清炒","冬阴功煮","红酸汤煮"]},
  {name:"土豆",   soupOk:false, methods:["清炒","炖"]},
  {name:"胡萝卜", soupOk:false, methods:["清炒","炖"]}
]
```

---

## 3. 加一个禁忌组合

`breakfast.forbid` 里加一条，抽签时会自动重摇，最多尝试 12 次：

```javascript
breakfast:{
  // ...
  forbid:[
    {drink:"黑咖啡", staple:"水饺"},
    {drink:"热牛奶", staple:"烤鸭饼"}   // ← 新增
  ]
}
```

禁忌检查同时比对 `drink`（显示名）和 `staple`（物品名），写错字段就不会生效。

---

## 4. 改每周专款额度

在 `index.html` 顶部配置区附近，只改这一处就够了：

```javascript
var WEEKLY_CAP = 70;              // 每周专款上限（元）
var MONTHLY_CAP = WEEKLY_CAP * 4; // 月度上限（按 4 周折算）
```

改成 50 试试，界面上的标题、提示语、进度条会自动跟着变。
历史账本数据不受影响，只是统计上限变了。

---

## 5. 改分类

分类列表在 `var CATEGORIES = [...]`：

```javascript
var CATEGORIES = ["蔬菜","水果","肉类","主食","零食","调料",
                  "日用品","清洁用品","药品","文具","工具","宠物用品","其他"];
```

加一个新分类（比如「冷冻」），加进去就行。
如果你的数据表字段选项是固定的，记得同步在数据表里加上同样的选项。

---

## 6. 把数据表接上（多设备同步）

默认是纯浏览器本地模式，只在这台电脑/这个浏览器里存数据。
想让手机和电脑共用一份数据，在 WorkBuddy 里建三张数据表，然后把 ID 填到 `index.html` 顶部：

```javascript
var DATABASE_ID = '';   // 库存表 Food_Inventory
var GROW_DB_ID = '';    // 自种补给 Self_Grow
var FUND_DB_ID = '';    // 每周专款 Weekly_Fund
```

三张表的字段：

**Food_Inventory**

| 字段 | 类型 | 说明 |
|---|---|---|
| Name | 文本 | 物品名 |
| Category | 单选 | 取值同上面的 CATEGORIES |
| Quantity | 文本 | 数字 + 单位，如 `750g`、`4个`、`1瓶` |
| ExpireDate | 日期 | 格式 `YYYY-MM-DD` |
| Status | 单选 | `待消耗` / `已吃完` |

**Self_Grow**

| 字段 | 类型 | 说明 |
|---|---|---|
| Name | 文本 | 作物名 |
| Stage | 单选 | `生长中` / `可采收` / `已用完` |
| Quantity | 文本 | 如 `半盘`、`一把` |
| Note | 文本 | 备注 |

**Weekly_Fund**

| 字段 | 类型 | 说明 |
|---|---|---|
| Item | 文本 | 买了什么 |
| Cost | 数字 | 金额（元） |
| Category | 单选 | `鲜菜` / `蛋奶` / `补剂` / `其他` |
| BuyDate | 日期 | 购买日期 |
| Note | 文本 | 备注 |

填好 ID 后，把页面部署到 WorkBuddy，顶部状态条会从「本地模式」变成「已接入数据表」。

> 三个 ID 都要填。少填一个，对应的模块（自种 / 专款）就会退回本地模式。

---

## 7. 改菜谱的做法提示

每道菜的 `tip` 就是卡片里那句「💡」提示，改成你自己习惯的做法：

```javascript
{name:"水饺", cook:"煮", tip:"水开下饺，点两次凉水，浮起即熟"}
//                       ↑ 这一句
```

提示语会自动带上「消耗：xxx」一起显示，不用自己拼。
