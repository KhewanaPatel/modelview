import 'package:flutter/material.dart';
import 'package:modelview/utils/routes/routes_name.dart';
import 'package:modelview/utils/utils.dart';
import 'package:modelview/view_model/home_view_model.dart';
import 'package:modelview/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  HomeViewViewModel homeViewViewModel =HomeViewViewModel();

  @override
  void initState() {
    // TODO: implement initState
    homeViewViewModel.fetchMoviesListApi();
    super.initState();
  }

  Widget build(BuildContext context) {
    final userPreference=Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [InkWell(onTap: (){
          userPreference.remove().then((value)
          => Navigator.pushNamed(context, RoutesName.login)
          );},
        child: Center(child: Text("Logout"),),),
        ],
      ),
      body:ChangeNotifierProvider<HomeViewViewModel>(
        create:(BuildContext context)=>homeViewViewModel,
        child:Consumer<HomeViewViewModel>(builder: (context, value, child) {
          switch(value.moviesList.status){
            case Status.LOADING:
              return CircularProgressIndicator();
            case Status.ERROR:
              return Text(value.moviesList.message.toString());
            case Status.COMPLETED:
              return ListView.builder(itemCount: value.moviesList.data!.movies!.length,
                  itemBuilder: (context,index){
                return Card(
                  child: ListTile(
                    leading: Image.network(value.moviesList.data!.movies![index].posterurl.toString(),
                    errorBuilder: (context,error,stack){
                      return Icon(Icons.error,color: Colors.pink,);
                    },),

                    title: Text(value.moviesList.data!.movies![index].title.toString()),
                    subtitle:Text(value.moviesList.data!.movies![index].year.toString()),
                    trailing: Row(mainAxisSize:MainAxisSize.min,
                      children:[
                        Text(Utils.averageRating(value.moviesList.data!.movies![index].ratings!).toStringAsFixed(1)),
                        Icon(Icons.star,color: Colors.yellow,)

                    ],),
                  ),
                );
              });




          }
          return
            Container();
        }),
      )
    );
  }
}
