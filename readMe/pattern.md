[杂谈: MVC/MVP/MVVM](https://juejin.im/post/5a30c77df265da43062ac189)

练习这三种模式设计 tests/mvx


### VIPER
· View(视图) 发送响应事件到`Presenter(展示器)`，并展示回调结果；
    
· Presenter(展示器) 从`Interactor(交互器)`获取数据，把数据封装到`Entity(实体)`回传给`View`；

· Interactor(交互器) 从数据层获取数据，执行业务逻辑，完全独立于用户界面；

· Entity(实体) 数据对象；

· Router(路由) 负责模块间交互逻辑。

