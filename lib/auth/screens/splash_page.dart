import 'dart:async';

import 'package:beauty/auth/screens/onboarding_screen.dart';
import 'package:beauty/common/bloc/user_cubit.dart';
import 'package:beauty/common/services/preferences_service.dart';
import 'package:beauty/common/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/libs.dart';
import 'package:beauty/common/screens/home.dart';
import 'package:beauty/common/utils/themes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  final List<String> _keywords = [
    'près de chez vous',
    'certifiés',
    'de confiance'
  ];
  int _keywordIndex = 0;

  late final Timer _timer;
  late final AnimationController _fadeController;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;

  bool _initializing = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.2),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut));

    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_fadeController);

    _startTextAnimation();
    _initialize();
  }

  @override
  void dispose() {
    _timer.cancel();
    _fadeController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _startTextAnimation() {
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      _fadeController.reverse().then((_) {
        setState(() {
          _keywordIndex = (_keywordIndex + 1) % _keywords.length;
        });
        _fadeController.forward();
      });
    });

    _fadeController.forward();
  }

  Future<void> _initialize() async {
    final prefs = context.read<PreferencesService>();
    final isFirst = await prefs.isFirstEnter() == null;
    final userState = context.read<UserCubit>().state;
    await Future.delayed(const Duration(seconds: 5));

    if (!mounted) return;
    await prefs.enterFirstEnter();

    if (isFirst) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const OnboardingScreen()));
    } else if (userState is UserNotLoggedState) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const OnboardingScreen()));
    } else if (userState is UserLoggedState) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const OnboardingScreen()));
    }

    setState(() => _initializing = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.only(bottom: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.asset(
                    Assets.logo,
                    height: 120,
                    width: 120,
                  ),
                ),
              ),
              Text(
                'Beauty Online',
                style: theme.textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Des professionnels ', style: theme.textTheme.bodyLarge),
                  SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Text(
                        _keywords[_keywordIndex],
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: AppTheme.primaryYellow,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              if (_initializing)
                const CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation(AppTheme.primaryYellow),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
