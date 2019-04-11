import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:konayan/model/tag.dart';
import 'package:konayan/notifier/db_notifier.dart';
import 'package:konayan/notifier/search_notifier.dart';
import 'package:konayan/view/widget/search_view.dart';
import 'package:konayan/view/widget/tag_view.dart';
import 'package:provider/provider.dart';

class KonachanSearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _konachanSearchPageState();
  }
}

class _konachanSearchPageState extends State<KonachanSearchPage>with AutomaticKeepAliveClientMixin {
  TextEditingController _textEditingController;
  bool isFirstLoad = true;
  SearchNotifier _viewModel;
  @override
  void initState() {
    _viewModel = SearchNotifier()..fetchData();
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 35,
                    color: Theme.of(context).primaryColor,
                  ),
                  SearchView(controller: _textEditingController)
                ],
              ),
              Container(
                  child: ChangeNotifierProvider<SearchNotifier>(
                child: Consumer<SearchNotifier>(
                  builder: (context, value) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "BookMark",
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        ),
                        Consumer<DbNotifier>(
                            builder: (context, v) => Builder(builder: (_) {
                                  List<Tag> tags = [];
                                  v.tags.forEach(
                                      (f) => {tags.add(Tag()..name = f)});
                                  if (v.tags.isEmpty) {
                                    return Container();
                                  }
                                  return TagView(
                                    tags: tags,
                                  );
                                })),
                        //1
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Hot Tag",
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        ),
                        Builder(
                          builder: (context) {
                            if (value.tags == null) {
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                                height: 100,
                              );
                            }
                            return TagView(
                              tags: value.tags,
                            );
                          },
                        )

                        //2
                      ],
                    );
                  },
                ),
                notifier: _viewModel,
              )),
            ],
          ),
        ),
        onRefresh: () => _viewModel.fetchData(),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
