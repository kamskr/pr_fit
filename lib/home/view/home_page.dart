import 'package:app_ui/app_ui.dart';
import 'package:fitts/app/bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

/// {@template home_page}
///  Dashboard view of the application.
/// {@endtemplate}
class HomePage extends StatelessWidget {
  /// {@macro home_page}
  const HomePage({Key? key}) : super(key: key);

  /// Page helper for creating pages.
  static Page<void> page() {
    return const MaterialPage<void>(child: HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return const _HomeView();
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: const SafeArea(
        child: _HomeBody(),
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          _HomeHeader(),
          AppGap.lg(),
          Divider(height: 1),
          _DashboardStats(),
          Divider(height: 1),
          // AppGap.lg(),
          // _PreviousWorkout(),
          AppGap.xlg(),
          _MyWorkouts(),
        ],
      ),
    );
  }
}

class _DashboardStats extends StatelessWidget {
  const _DashboardStats({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProfile = context.read<AppBloc>().state.userProfile;

    return Row(
      children: [
        const _DashboardStatsItem(
          count: '0',
          titlePart1: 'workouts',
          titlePart2: 'completed',
        ),
        const _DashboardStatsItem(
          count: '0',
          titlePart1: 'tonnage',
          titlePart2: 'lifted',
        ),
        _DashboardStatsItem(
          count: '${userProfile.weight}',
          suffix: 'kg',
          titlePart1: 'current',
          titlePart2: 'weight',
          showBorder: false,
        ),
      ],
    );
  }
}

class _DashboardStatsItem extends StatelessWidget {
  const _DashboardStatsItem({
    Key? key,
    required this.count,
    required this.titlePart1,
    required this.titlePart2,
    this.showBorder = true,
    this.suffix,
  }) : super(key: key);

  final String count;
  final String titlePart1;
  final String titlePart2;
  final bool showBorder;
  final String? suffix;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: showBorder
                ? Border(
                    right: BorderSide(
                      color: Theme.of(context)
                          .extension<AppColorScheme>()!
                          .black100,
                    ),
                  )
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.md,
              bottom: AppSpacing.md,
              left: AppSpacing.lg,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      count,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    if (suffix != null)
                      Padding(
                        padding: const EdgeInsets.only(
                          left: AppSpacing.xxxs,
                          bottom: AppSpacing.xxs,
                        ),
                        child: Text(
                          suffix!,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                  ],
                ),
                const AppGap.xxxs(),
                Text(
                  titlePart1,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                Text(
                  titlePart2,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userProfile = context.watch<AppBloc>().state.userProfile;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Dashboard',
            style: theme.textTheme.headline3,
          ),
          _SmallAvatar(photoUrl: userProfile.photoUrl),
        ],
      ),
    );
  }
}

class _SmallAvatar extends StatelessWidget {
  const _SmallAvatar({
    Key? key,
    required this.photoUrl,
  }) : super(key: key);

  final String photoUrl;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.lg),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.xxxs),
        child: SizedBox(
          height: 40,
          width: 40,
          child: photoUrl != ''
              ? Image.network(
                  photoUrl,
                  height: 40,
                  width: 40,
                  fit: BoxFit.contain,
                )
              : Assets.icons.emptyProfileImage.svg(),
        ),
      ),
    );
  }
}

class _MyWorkouts extends StatelessWidget {
  const _MyWorkouts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
          ),
          child: Stack(
            children: [
              SvgPicture.asset(
                'assets/home/empty_dashboard.svg',
                semanticsLabel: 'Empty workouts',
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color.fromARGB(0, 255, 255, 255),
                        Theme.of(context).colorScheme.background,
                      ],
                      stops: const [.1, .8],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const AppGap.md(),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xlg,
          ),
          child: Text(
            'You have no workouts yet. Go on and create your first one!',
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
        ),
        const AppGap.md(),
        SizedBox(
          height: 48,
          width: 210,
          child: AppButton.gradient(
            onPressed: () {},
            child: const Text('CREATE WORKOUT'),
          ),
        ),
      ],
    );
  }
}
