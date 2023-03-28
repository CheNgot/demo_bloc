import 'package:bloc_login_form/bloc/bloc_home/home_state.dart';
import 'package:bloc_login_form/cubit/cubit_home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late HomeCubit _homeCubit;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _homeCubit =  HomeCubit()..fetchList();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _homeCubit.loadMore();
      }
    });



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("List"),),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            ElevatedButton(onPressed: (){
              _homeCubit.addItem();
            }, child: Text("Thêm phần tử")),
            BlocBuilder<HomeCubit, HomeState>(
              bloc: _homeCubit,
              builder: (context, state) {
                if (state is HomeLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is HomeLoaded) {
                  return ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Row(
                          children: [
                            Text(state.items[index]),
                            const Spacer(),
                            InkWell(
                              onTap: (){
                                _homeCubit.deleteItem(index);
                              },
                              child: const Icon(Icons.delete),
                            ),
                            const SizedBox(width: 10),
                            InkWell(
                              onTap: (){
                                _showDialogEdit(index);
                              },
                              child: const Icon(Icons.edit),
                            ),

                          ],
                        ),
                      );
                    },
                  );
                } else if (state is HomeFailure) {
                  return Center(
                    child: Text(state.error),
                  );
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    _homeCubit.close();
    super.dispose();
  }

  void _showDialogEdit(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String inputText = '';

        return AlertDialog(
          title: Text('Enter some text'),
          content: TextField(
            autofocus: true,
            onChanged: (value) {
              inputText = value;
            },
            decoration: InputDecoration(hintText: 'Enter text here'),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                _homeCubit.editItem(content:inputText,index:index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

  }
}
