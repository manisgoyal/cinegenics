import '/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'Movie Manager',
              body: 'Manage all your watched movies in one place',
              image: buildImage('assets/images/movie_reel.png'),
              decoration: getPageDecoration(context),
            ),
            PageViewModel(
              title: 'Get iMDb Ratings',
              body: 'Store them with the latest iMDb ratings.',
              image: buildImage('assets/images/imdb_logo.png'),
              decoration: getPageDecoration(context),
              footer: ButtonWidget(
                text: 'Start Storing',
                onClicked: () => goToHome(context),
              ),
            ),
          ],
          done: const Text('Continue',
              style: TextStyle(color: Colors.green, fontSize: 16)),
          onDone: () => goToHome(context),
          showSkipButton: true,
          skip: const Text('Skip',
              style: TextStyle(color: Colors.green, fontSize: 16)),
          onSkip: () => goToHome(context),
          next:
              Icon(color: Color.fromRGBO(76, 175, 80, 1), Icons.arrow_forward),
          dotsDecorator: getDotDecoration(context),
          onChange: (index) {},
          globalBackgroundColor: Theme.of(context).backgroundColor,
          nextFlex: 0,
        ),
      );

  void goToHome(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );

  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350));

  DotsDecorator getDotDecoration(context) => DotsDecorator(
        color: Colors.green,
        activeColor: Colors.greenAccent,
        size: const Size(10, 10),
        activeSize: const Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration(context) => PageDecoration(
        titleTextStyle:
            const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: const TextStyle(fontSize: 20),
        bodyPadding: const EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: const EdgeInsets.all(24),
        pageColor: Theme.of(context).primaryColor,
      );
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onClicked,
        style: ElevatedButton.styleFrom(
          primary: Colors.green, // background
          onPrimary: Colors.white, // foreground
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Text(
            text,
          ),
        ),
      );
}
