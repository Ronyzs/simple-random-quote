import 'package:belajar_bloc/presentation/bloc/quote/quote_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<QuoteBloc>().add(FetchQuote()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: BlocBuilder<QuoteBloc, QuoteState>(
          builder: (context, state) {
            if (state is QuoteLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is QuoteLoaded) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      key: const Key('author'),
                      state.quote.author,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      key: const Key('category'),
                      state.quote.category,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(
                      key: const Key('quote'),
                      state.quote.quote,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              );
            } else if (state is QuoteError) {
              return Text(
                state.msg,
                key: const Key('quote-error'),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<QuoteBloc>().add(FetchQuote()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
