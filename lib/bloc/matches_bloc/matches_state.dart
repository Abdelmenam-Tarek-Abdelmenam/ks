part of 'matches_bloc.dart';

class PlayState extends Equatable {
  final MatchesViewType type;
  final BlocStatus groundStatus;
  final BlocStatus productsStatus;
  final BlocStatus rProduct;
  final BlocStatus rGround;
  final List<Ground> grounds;
  final List<Product> products;

  const PlayState({
    required this.type,
    required this.grounds,
    required this.products,
    required this.groundStatus,
    required this.productsStatus,
    required this.rGround,
    required this.rProduct,
  });

  factory PlayState.initial() => const PlayState(
        type: MatchesViewType.grounds,
        grounds: [],
        products: [],
        productsStatus: BlocStatus.idle,
        groundStatus: BlocStatus.idle,
        rGround: BlocStatus.idle,
        rProduct: BlocStatus.idle,
      );

  PlayState copyWith({
    MatchesViewType? type,
    List<Ground>? grounds,
    List<Product>? products,
    BlocStatus? groundStatus,
    BlocStatus? productsStatus,
    BlocStatus? rGround,
    BlocStatus? rProduct,
    bool? forceNull,
  }) {
    return PlayState(
      type: type ?? this.type,
      grounds: grounds ?? this.grounds,
      products: products ?? this.products,
      productsStatus: productsStatus ?? this.productsStatus,
      groundStatus: groundStatus ?? this.groundStatus,
      rGround: rGround ?? this.rGround,
      rProduct: rProduct ?? this.rProduct,
    );
  }

  @override
  List<Object?> get props => [type, productsStatus, groundStatus , rProduct , rGround];
}

enum MatchesViewType {
  grounds,
  store;

  @override
  String toString() {
    switch (this) {
      case MatchesViewType.grounds:
        return StringManger.ground;
      case MatchesViewType.store:
        return StringManger.active;
    }
  }

  IconData toIcon() {
    switch (this) {
      case MatchesViewType.grounds:
        return FontAwesomeIcons.mapLocationDot;
      case MatchesViewType.store:
        return FontAwesomeIcons.peopleGroup;
    }
  }
}
