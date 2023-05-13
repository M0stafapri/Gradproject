import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simpleui/layout/cubit/layout_cubit.dart';
import 'package:simpleui/models/recipe_model.dart';
import 'package:simpleui/modules/widgets/alert_dialog_widget.dart';
import 'package:simpleui/modules/widgets/snackBar_widget.dart';
import 'package:simpleui/shared/style/colors.dart';
import '../../../layout/cubit/layout_states.dart';
import '../../../models/plan_model.dart';
import '../../widgets/plan_component_widget.dart';
import '../../widgets/empty_home_component.dart';
import '../../widgets/recipe_component_widget.dart';
import 'package:simpleui/modules/screens/plan/createPlanScreen.dart';
import 'package:simpleui/modules/screens/recipes/create_recipe.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController tabController;
  int currentTabIndex = 0;

  @override
  void initState() {
    tabController =
        TabController(vsync: this, length: 2, initialIndex: currentTabIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final LayoutCubit cubit = LayoutCubit.getInstance(context);
    List<PlanModel> plansData = cubit.myPlansData;
    List<RecipeModel> recipesData = cubit.recipesData;
    Map<String, bool> likesStatus = cubit.likesStatus;
    List<String> plansID = cubit.myPlansID;
    List<String> RecipesID = cubit.RecipesID;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 111, 188, 154),
                  Color.fromARGB(255, 4, 44, 30),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: TabBar(
              onTap: (index) {
                setState(() {
                  currentTabIndex = index;
                });
              },
              controller: tabController,
              indicatorColor: Colors.white,
              indicatorWeight: 3.w,
              tabs: [
                Tab(
                  icon: const Icon(Icons.fitness_center),//Plans
                ),
                Tab(
                  icon: const Icon(Icons.local_dining),//Recipes
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                // Todo: It was BlocBuilder
                BlocConsumer<LayoutCubit, LayoutStates>(
                  listener: (context, state) {
                    // Todo: To pop up from AlertDialog
                    if (state is DeletePlanSuccessfullyState ||
                        state is LeavePlanSuccessfullyState) {
                      Navigator.pop(context);
                    }
                    if (state is LeavePlanWithErrorState ||
                        state is FailedToDeletePlanState) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(snackBarWidget(
                          message: "Something went wrong, try again later!",
                          context: context,
                          color: Colors.red));
                    }
                    if (state is LeavePlanLoadingState ||
                        state is DeletePlanLoadingState) {
                      Navigator.pop(context);
                      showAlertDialog(
                        context: context,
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CupertinoActivityIndicator(
                              color: mainColor,
                              radius: 15,
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  buildWhen: (oldState, newState) {
                    return newState is GetMyPlansSuccessState;
                  },
                  builder: (context, state) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                      child: plansData.isNotEmpty && cubit.userData != null
                          ? SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (plansData.isNotEmpty)
                                    ...List.generate(
                                        plansData.length,
                                        (index) => PlanWidget(
                                            cubit: cubit,
                                            model: plansData[index],
                                            planID: plansID[index])),
                                ],
                              ),
                            )
                          : state is GetMyPlansLoadingState
                              ? Center(
                                  child: const CupertinoActivityIndicator(
                                    color: mainColor,
                                    radius: 15,
                                  ),
                                )
                              : emptyDataItemView(
                                  context: context,
                                  title: "No plans yet, try to join one!"),
                    );
                  },
                ),
                BlocConsumer<LayoutCubit, LayoutStates>(
                  listener: (context, state) {
                    if (state is DeleteRecipeSuccessState) {
                      Navigator.pop(context);
                    }
                    if (state is DeleteRecipeErrorState) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(snackBarWidget(
                          message: "Something went wrong, try again later!",
                          context: context,
                          color: Colors.red));
                    }
                    if (state is DeleteRecipeLoadingState) {
                      Navigator.pop(context);
                      showAlertDialog(
                        context: context,
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CupertinoActivityIndicator(
                              color: mainColor,
                              radius: 15,
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  buildWhen: (oldState, newState) {
                    return newState is GetAllRecipesSuccessfullyState;
                  },
                  builder: (context, state) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                      child: recipesData.isNotEmpty &&
                              RecipesID.isNotEmpty &&
                              cubit.userData != null
                          ? SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (recipesData.isNotEmpty &&
                                      RecipesID.isNotEmpty)
                                    ...List.generate(
                                        recipesData.length,
                                        (index) => RecipeWidget(
                                            model: recipesData[index],
                                            recipeID: RecipesID[index],
                                            cubit: cubit,
                                            likesStatus: likesStatus)),
                                ],
                              ),
                            )
                          : state is GetAllRecipesLoadingState
                              ? Center(
                                  child: const CupertinoActivityIndicator(
                                    color: mainColor,
                                    radius: 25,
                                  ),
                                )
                              : emptyDataItemView(
                                  context: context,
                                  title: "No Recipes yet, try to add one!"),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      // Updated: Add a floating action button to add new plans or recipes
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (currentTabIndex == 0) {
            // Add Plan
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CreatePlanScreen(),
              ),
            );
          } else {
            // Add Recipe
            //  Navigator.push(
            //  context,
            //  MaterialPageRoute(
            //   builder: (_) => CreateRecipeScreen(),
            // ),
            //);
          }
        },
        tooltip: currentTabIndex == 0 ? "Add Plan" : "Add Recipe",
        child: const Icon(Icons.add),
      ),