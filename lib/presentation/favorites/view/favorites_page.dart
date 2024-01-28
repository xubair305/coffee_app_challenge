import 'package:coffee_challenge/app_exports.dart';
import 'package:coffee_challenge/components/index.dart';
import 'package:coffee_challenge/core/helper/index.dart';
import 'package:coffee_challenge/presentation/favorites/cubit/favorites_cubit.dart';
import 'package:coffee_challenge/presentation/favorites/widget/favorite_coffee_tile.dart';
import 'package:coffee_challenge/presentation/home/model/coffee_item_model.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoritesCubit()..getFavoritesList,
      child: const FavoritesView(),
    );
  }
}

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: BlocConsumer<FavoritesCubit, FavoritesState>(
        listener: (_, state) {
          if (state is FavoritesRemoved) {
            context.read<FavoritesCubit>().listKey.currentState?.removeItem(
                  state.index,
                  (context, animation) => _buildSlideTile(
                    animation,
                    state.coffeeItems,
                    state.index,
                  ),
                );
          }
        },
        builder: (context, state) {
          if (state is FavoritesError) {
            return Center(child: CustomText(state.error));
          } else {
            return state is FavoritesLoading
                ? _buildLoadingIndicator()
                : state is FavoritesLoaded
                    ? state.coffeeItems.isNotEmpty
                        ? _buildFavoriteListView(context, state.coffeeItems)
                        : _buildEmptyListWidget()
                    : _buildUnknownErrorWidget();
          }
        },
      ),
    );
  }

  Center _buildLoadingIndicator() =>
      const Center(child: CircularProgressIndicator());

  Center _buildUnknownErrorWidget() =>
      const Center(child: CustomText('Unknown Error!'));

  Center _buildEmptyListWidget() {
    return const Center(
      child: CustomText('Your favorites list is empty.'),
    );
  }

  Widget _buildFavoriteListView(
    BuildContext context,
    List<CoffeeItem> coffeeItems,
  ) {
    return AnimatedList(
      key: context.read<FavoritesCubit>().listKey,
      initialItemCount: coffeeItems.length,
      padding: EdgeInsets.symmetric(
        horizontal: kHorizontalPadding,
        vertical: 20,
      ),
      itemBuilder: (_, index, animation) =>
          _buildSlideTile(animation, coffeeItems[index], index),
    );
  }

  SizeTransition _buildSlideTile(
    Animation<double> animation,
    CoffeeItem coffeeItem,
    int index,
  ) {
    return SizeTransition(
      sizeFactor: animation,
      child: FadeInLeft(
        from: index * 25,
        child: FavoriteCoffeeTile(
          item: coffeeItem,
          index: index,
        ),
      ),
    );
  }
}
