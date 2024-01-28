import 'package:coffee_challenge/app_exports.dart';
import 'package:coffee_challenge/components/index.dart';
import 'package:coffee_challenge/core/helper/index.dart';
import 'package:coffee_challenge/l10n/l10n.dart';
import 'package:coffee_challenge/presentation/favorites/widget/favorite_coffee_tile.dart';
import 'package:coffee_challenge/presentation/home/model/coffee_item_model.dart';
import 'package:coffee_challenge/presentation/search/cubit/search_cubit.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(CoffeeShop.coffeeItems),
      child: const SearchView(),
    );
  }
}

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: TextField(
          // controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: context.l10n.serachFieldHintText,
            border: InputBorder.none,
          ),
          onChanged: (value) =>
              context.read<SearchCubit>().onSearchChange(value),
        ),
      ),
      body: BlocBuilder<SearchCubit, List<CoffeeItem>>(
        builder: (context, state) {
          return state.isEmpty
              ? const Center(child: CustomText('No result found.'))
              : ListView.builder(
                  itemCount: state.length,
                  padding: EdgeInsets.symmetric(
                    horizontal: kHorizontalPadding,
                    vertical: 20,
                  ),
                  itemBuilder: (context, index) => FadeInUp(
                    child: FavoriteCoffeeTile(
                      item: state[index],
                      index: index,
                      showDelete: false,
                    ),
                  ),
                );
        },
      ),
    );
  }
}
