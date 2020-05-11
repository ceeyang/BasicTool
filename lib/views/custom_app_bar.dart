import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Autor: Mr. Yang
/// CreateTime: 2020年05月08日17:26:39

/// 这是一个可以指定SafeArea区域背景色的AppBar
/// PreferredSizeWidget提供指定高度的方法
/// 如果没有约束其高度，则会使用PreferredSizeWidget指定的高度

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  
  /// 自定义高度, 默认 kToolbarHeight
  final double contentHeight; 
  /// 左边间距, 默认 10
  final double leadingMargin;
  /// 右间距, 默认 10
  final double trailingMargin;

  /// 左边 widget
  final Widget leadingWidget;
  /// 中间 widget
  final Widget titleWidget;
  /// 右边widget
  final Widget trailingWidget;
  
  /// 导航栏 title, 当 titleWidget != null 时候无效
  final String _title;
  
  /// 导航栏背景色, 默认 Theme.of(context).backgroundColor
  final Color backgroundColor;
  /// 导航栏下面的线条颜色, 默认色值 Colors.grey.shade300
  final Color underlineColor;
  
  /// 状态栏样式, 默认黑色
  final SystemUiOverlayStyle style;

  /// 自动显示返回按钮, 当 leadingWidget != null 时失效
  final bool _autoBackBtn;
  
  ///  手势,当点击返回键时,处理的逻辑,如果不传值,则默认会返回上个界面,且不包含任何返回值
  final void Function(BuildContext ctx) _onReturn;

  /// 搜索按钮点击事件
  final void Function(String values) _onSearch;


  CustomAppBar({
    String title,
    this.leadingWidget,
    this.contentHeight = kToolbarHeight,
    this.trailingWidget,
    this.titleWidget,
    this.backgroundColor,
    this.underlineColor,
    this.leadingMargin,
    this.trailingMargin,
    this.style,
    bool autoBackBtn,
    Function(BuildContext ctx) onReturn,
    Function(String value) onSearch
  }) : _title = title == null ? "" : title,
       _autoBackBtn = leadingWidget == null ? (autoBackBtn ?? true) : false,
       _onReturn = onReturn ??= null,
       _onSearch = onSearch ??= null,
       super();

  @override
  State<StatefulWidget> createState() {
    return _CustomAppBarState();
  }

  @override
  Size get preferredSize => Size.fromHeight(contentHeight);
}

/// 这里没有直接用SafeArea，而是用Container包装了一层
/// 因为直接用SafeArea，会把顶部的statusBar区域留出空白
/// 外层Container会填充SafeArea，指定外层Container背景色也会覆盖原来SafeArea的颜色
///     var statusheight = MediaQuery.of(context).padding.top;  获取状态栏高度
class _CustomAppBarState extends State<CustomAppBar> {

  FocusNode _searchFN = FocusNode();
  TextEditingController _searchCtr = TextEditingController();

  bool _isSearching = false;
  bool _hasSearchBtn = false;

  Widget _searchTextField(){ 
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 50, 0),
      child: TextField(
        textInputAction: TextInputAction.search,
        focusNode: _searchFN,
        decoration: InputDecoration(
          icon: Icon(Icons.search),
          hintText: '请输入您需要搜索的内容',
          border: InputBorder.none,
          suffixIcon: IconButton(icon: Icon(Icons.close, size: 15,), onPressed: (){_searchCtr.text = ""; setState(() {});})
        ),
        onSubmitted: _searchTextFiledSubmit,
        autofocus: false,
        controller: _searchCtr
      ),
    );
  }

  /// 搜索按钮点击事件
  _searchTextFiledSubmit(value) {
    _searchFN.unfocus();

    if (widget._onSearch != null) {
      widget._onSearch(_searchCtr.text);
    }
  }

  @override
  void initState() {
    super.initState();

    _hasSearchBtn = widget._onSearch != null;
  }

  @override
  Widget build(BuildContext context) {

    /// 默认状态栏样式
    //var defaultStyle = gCurrentThemeIndex == 0 ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light;

    /// 自动调整 状态栏 组件 AnnotatedRegion.value
    return AnnotatedRegion(
      value: widget.style ?? SystemUiOverlayStyle.dark,
      child: Container(
        color: widget.backgroundColor ?? Theme.of(context).backgroundColor,
        child: SafeArea(
          top: true,
          child: Container(
            height: widget.contentHeight,
            decoration: UnderlineTabIndicator(
              borderSide: BorderSide(width: 1.0, color: widget.underlineColor ?? Theme.of(context).scaffoldBackgroundColor),
              insets: EdgeInsets.zero
            ),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                ///
                /// leading
                /// 
                Positioned(
                  left: 0,
                  child: Container(
                    //padding: const EdgeInsets.only(left: 5),
                    child: _isSearching 
                      ? Container()
                      : widget._autoBackBtn 
                        ? IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
                            //  返回上一页,退栈
                            if (widget._onReturn == null) {
                              Navigator.pop(context);
                            } else {
                              widget._onReturn(context);
                            }
                          },)
                        : Container(
                            padding: EdgeInsets.only(left: widget.leadingMargin ?? 10),
                            child: widget.leadingWidget,
                          ),
                      
                  ),
                ),
                ///
                /// center
                /// 
                Center(
                  child: _isSearching 
                  ? _searchTextField()
                  : widget.titleWidget != null 
                    ? widget.titleWidget
                    : Container(
                        width: 220, 
                        child: Text(
                          widget._title, 
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600), 
                          maxLines: 1, 
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,)),
                ),
                ///
                /// trailing
                /// 
                Positioned(
                  right: 0,
                  child: _isSearching 
                      ? GestureDetector(
                          onTap: () { _searchFN.unfocus(); _isSearching = !_isSearching; setState(() {}); },
                          child: Row(children: <Widget>[Text("取消"), SizedBox(width: 10)]),
                        )
                      : Container(
                        padding: EdgeInsets.only(right: widget.trailingMargin ?? 10),
                        child: Row(
                          children: <Widget>[
                   
                            _hasSearchBtn 
                            ? IconButton(icon: Icon(Icons.search), onPressed: (){
                                _isSearching = true;
                                setState(() {});
                              })
                            : Container(),

                            widget.trailingWidget != null
                            ? widget.trailingWidget
                            : Container(),
                          ],
                        ),
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}

