import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Material库中提供的Flutter APP框架，设置应用的名称、主题、语言、首页以及路由列表
    return new MaterialApp(
      title: "hi youwd",
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: new MyHomePage(title: "home page"),
      routes: {
        "pages_account_detail": (context) => PagesAccountDetail(text: ModalRoute.of(context).settings.arguments,),
        "/": (context) => MyHomePage(title: 'Flutter Demo Home Page'), //注册首页路由
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 1;

  /// 自增
  void _incrementCount() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    /**Scaffold：页面脚手架，包含导航栏和body */
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("你已经点击了："),
            new Text('$_counter', style: Theme.of(context).textTheme.display1),
            FlatButton(
              child: Text("打开我的页面"),
              textColor: Colors.blue,
              onPressed: () {
                // 导航到我的页面
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return PagesAccount();
                  },
                  // fullscreenDialog: true,
                ));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCount,
        child: new Icon(Icons.add),
      ),
    );
  }
}

/// 子页面：我的账户
class PagesAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // String result  = "";
    return Scaffold(
      appBar: AppBar(title: Text("我的")),
      body: Center(
          child: Column(
        children: <Widget>[
          Text("我的账户页面haha1"),
          // RaisedButton(
          //   onPressed: () async {
          //     var result = await Navigator.push(context,
          //         MaterialPageRoute(builder: (context) {
          //       return PagesAccountDetail(
          //         text: "我是父页面传递过来的值",
          //       );
          //     }));
          //     print("路由返回的值：$result");
          //   },
          //   child: Text("我的账户详情页面"),
          // ),
          RaisedButton(
            onPressed: () async {
             var  result = await Navigator.of(context)
                  .pushNamed("pages_account_detail", arguments: "我是账户页面传递的值");
              print("路由返回的值：$result");
            },
            child: Text("路由表形式打开页面"),
          ),
          // Text("$result"),
        ],
      )),
    );
  }
}

/// 路由传值  父子页面之间的传递
class PagesAccountDetail extends StatelessWidget {
  PagesAccountDetail({
    Key key,
    @required this.text, // 接收一个text参数
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("账户详情页面"),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(args),
              RaisedButton(
                onPressed: () => Navigator.pop(context, "我是子页面返回的值"),
                child: Text("返回"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
