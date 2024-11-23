// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class ShowData<T> extends Equatable {
  List<T> data;
  int end = 20;

  ShowData(this.data, {this.end = 20});

  factory ShowData.empty() => ShowData(const []);

  bool get isEmpty => data.isEmpty;
  bool get isEnd => end > data.length;
  int get start => data.length;
  int get length => data.length;

  void getNext() {
    end = data.length + 20;
  }

  @override
  List<Object?> get props => [data.length];
}
