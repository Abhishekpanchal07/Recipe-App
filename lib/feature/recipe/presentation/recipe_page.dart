import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/connectivity/connectivity_cubit.dart';
import 'bloc/recipe_bloc.dart';
import 'bloc/recipe_event.dart';
import 'bloc/recipe_state.dart';

import 'widgets/offline_banner.dart';
import 'widgets/recipe_app_bar.dart';
import 'widgets/recipe_empty_view.dart';
import 'widgets/recipe_error_view.dart';
import 'widgets/recipe_list.dart';
import 'widgets/recipe_search_bar.dart';
import 'widgets/recipe_shimmer.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  late final ScrollController _scrollController;
  late final TextEditingController _searchController;

  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _searchController = TextEditingController();

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  bool _isLoadMoreTriggered = false;

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final state = context.read<RecipeBloc>().state;

    // Don't paginate while searching
    if (state.isSearching) return;

    final current = _scrollController.position.pixels;
    final max = _scrollController.position.maxScrollExtent;

    if (current >= max * 0.8 && !_isLoadMoreTriggered) {
      _isLoadMoreTriggered = true;

      context.read<RecipeBloc>().add(const LoadMoreRecipes());
    }

    // Reset trigger when user scrolls back up
    if (current < max * 0.6) {
      _isLoadMoreTriggered = false;
    }
  }

  Future<void> _onRefresh() async {
    final completer = Completer<void>();

    context.read<RecipeBloc>().add(RefreshRecipes(completer: completer));

    await completer.future;
  }

  void _onSearchChanged(String value) {
    final connectivityState = context.read<ConnectivityCubit>().state;

    if (!connectivityState.isConnected) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('No Internet Connection')));
      return;
    }
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () {
      final query = value.trim();

      if (query.isEmpty) {
        context.read<RecipeBloc>().add(const ClearSearch());
      } else {
        context.read<RecipeBloc>().add(SearchRecipes(query));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RecipeAppBar(),
      body: BlocListener<RecipeBloc, RecipeState>(
        listenWhen: (previous, current) =>
            previous.isLoadingMore && !current.isLoadingMore,
        listener: (_, _) {
          _isLoadMoreTriggered = false;
        },
        child: BlocBuilder<RecipeBloc, RecipeState>(
          builder: (context, state) {
            if (state.isLoading && !state.hasRecipes) {
              return const RecipeShimmer();
            }

            if (state.hasError && !state.hasRecipes) {
              return RecipeErrorView(
                message: state.errorMessage!,
                onRetry: () {
                  context.read<RecipeBloc>().add(const LoadRecipes());
                },
              );
            }

            if (state.isEmpty && !state.isSearching) {
              return const RecipeEmptyView();
            }

            return Column(
              children: [
                RecipeSearchBar(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                ),

                if (state.isOffline) const OfflineBanner(),
                if (state.isRefreshing) const LinearProgressIndicator(),

                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: state.recipes.isEmpty
                        ? const RecipeEmptyView()
                        : RecipeList(
                            controller: _scrollController,
                            recipes: state.recipes,
                            isLoadingMore: state.isLoadingMore,
                          ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
