import 'package:belajar_bloc/data/models/quote/quote_model.dart';
import 'package:belajar_bloc/presentation/bloc/quote/quote_bloc.dart';
import 'package:belajar_bloc/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helper/bloc_test_helper.dart';

void main() {
  late FakeQuoteBloc fakeQuoteBloc;

  setUp(() {
    registerFallbackValue(FakeQuoteEvent());
    registerFallbackValue(FakeQuoteState());
    fakeQuoteBloc = FakeQuoteBloc();
  });

  final tQuoteModel = QuoteModel(quote: "quote", author: "author", category: "category");

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<QuoteBloc>(
          create: (_) => fakeQuoteBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display ciruclar indicator when loading', (widgetTester) async {
    when(() => fakeQuoteBloc.state).thenReturn(QuoteLoading());

    final loadingIndicator = find.byType(CircularProgressIndicator);

    await widgetTester.pumpWidget(makeTestableWidget(const MyHomePage(title: 'Title')));

    expect(loadingIndicator, findsOneWidget);
  });

  testWidgets('Page should display quote when loaded', (widgetTester) async {
    when(() => fakeQuoteBloc.state).thenReturn(QuoteLoaded(tQuoteModel.toEntity()));

    Key authorKey = const Key('author');
    Key categoryKey = const Key('category');
    Key quoteKey = const Key('ss');

    await widgetTester.pumpWidget(makeTestableWidget(const MyHomePage(title: 'Title')));

    expect(find.byKey(authorKey), findsOneWidget);
    expect(find.byKey(categoryKey), findsOneWidget);
    expect(find.byKey(quoteKey), findsOneWidget);
  });

  testWidgets('Page should display error when Error', (widgetTester) async {
    when(() => fakeQuoteBloc.state).thenReturn(const QuoteError(''));

    Key errorText = const Key('quote-error');

    await widgetTester.pumpWidget(makeTestableWidget(const MyHomePage(title: 'Title')));

    expect(find.byKey(errorText), findsOneWidget);
  });
}
