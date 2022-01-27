import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SlideShow extends StatelessWidget {
  final List<Widget> slides;
  final bool puntosArriba;
  final Color colorPrimario;
  final Color colorSecundario;

  const SlideShow(
      {required this.slides,
      this.puntosArriba = false,
      this.colorPrimario = Colors.pink,
      this.colorSecundario = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _SliderModel(),
      child: SafeArea(
        child: Center(
          child: Builder(builder: (context) {
            /*se coloca el provider en el mismo nivel al que lo inicializamos, primero termina
          de crear la instancia de _SliderModel, y luego el Builder se dispara a continuacion   */
            Provider.of<_SliderModel>(context).colorPrimario =
                this.colorPrimario;
            Provider.of<_SliderModel>(context).colorSecundario =
                this.colorSecundario;

            return _CrearEstructuraSlideshow(
                puntosArriba: puntosArriba, slides: slides);
          }),
        ),
      ),
    );
  }
}

class _CrearEstructuraSlideshow extends StatelessWidget {
  const _CrearEstructuraSlideshow({
    Key? key,
    required this.puntosArriba,
    required this.slides,
  }) : super(key: key);

  final bool puntosArriba;
  final List<Widget> slides;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (this.puntosArriba) _Dots(this.slides.length),
        Expanded(child: _Slides(this.slides)),
        if (!this.puntosArriba) _Dots(this.slides.length),
      ],
    );
  }
}

class _Dots extends StatelessWidget {
  final int totalSlides;

  const _Dots(this.totalSlides);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 70,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(this.totalSlides, (index) => _Dot(index))));
  }
}

class _Dot extends StatelessWidget {
  final int index;

  const _Dot(this.index);

  @override
  Widget build(BuildContext context) {
    final slideShowModel = Provider.of<_SliderModel>(context);

    return AnimatedContainer(
      duration: const Duration(microseconds: 200),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            /*esta condicion abarca todos los valores [0 al 2] en este caso por ser 3 elementos */
            color: (slideShowModel._currentPage >= index - 0.5 &&
                    slideShowModel._currentPage < index + 0.5)
                ? slideShowModel.colorPrimario
                : slideShowModel.colorSecundario,
            shape: BoxShape.circle),
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> slides;
  const _Slides(this.slides);

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final pageViewController = PageController();

  @override
  void initState() {
    super.initState();

    pageViewController.addListener(() {
      Provider.of<_SliderModel>(context, listen: false).currentPage =
          pageViewController.page!;
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        controller: pageViewController,
        children: widget.slides.map((slide) => _Slide(slide)).toList(),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget slide;

  const _Slide(this.slide);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(30),
        child: slide);
  }
}

class _SliderModel with ChangeNotifier {
  double _currentPage = 0;
  Color _colorPrimario = Colors.blue;
  Color _colorSecundario = Colors.grey;

  double get currentPage => this._currentPage;
  set currentPage(double valor) {
    this._currentPage = valor;
    notifyListeners();
  }

  Color get colorPrimario => this._colorPrimario;
  set colorPrimario(Color valor) {
    this._colorPrimario = valor;
  }

  Color get colorSecundario => this._colorSecundario;
  set colorSecundario(Color valor) {
    this._colorSecundario = valor;
  }
}
