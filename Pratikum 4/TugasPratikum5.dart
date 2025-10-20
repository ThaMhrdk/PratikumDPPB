import 'dart:io';

class Tree {
  final int _height;
  Tree(this._height);
  int get height => _height;
  int cutAt(int x) => _height > x ? _height - x : 0;
}

class Forest {
  final List<Tree> _trees;
  Forest(this._trees);

  int totalWoodAt(int x) {
    var sum = 0;
    for (var t in _trees) {
      sum += t.cutAt(x);
    }
    return sum;
  }

  int maxHeight() {
    var mx = 0;
    for (var t in _trees) {
      if (t.height > mx) mx = t.height;
    }
    return mx;
  }

  int totalHeights() {
    var s = 0;
    for (var t in _trees) s += t.height;
    return s;
  }
}

abstract class Cutter {
  int collect(Forest f, int x);
}

class SimpleCutter implements Cutter {
  @override
  int collect(Forest f, int x) => f.totalWoodAt(x);
}

class Logger {
  void log(String msg) {}
}

class AdvancedCutter implements Cutter {
  final Logger _logger = Logger();
  @override
  int collect(Forest f, int x) {
    final result = f.totalWoodAt(x);
    _logger.log('collect at $x => $result');
    return result;
  }
}

int findMaxHeight(Forest f, int M, Cutter cutter) {
  if (f.totalWoodAt(0) < M) return -1;
  int low = 0;
  int high = f.maxHeight();
  int ans = -1;
  while (low <= high) {
    int mid = (low + high) >> 1;
    int collected = cutter.collect(f, mid);
    if (collected >= M) {
      ans = mid;
      low = mid + 1;
    } else {
      high = mid - 1;
    }
  }
  return ans;
}

void main() {
  final first = stdin.readLineSync();
  if (first == null) return;
  final header = first.trim();
  if (header.isEmpty) return;
  final headerParts = header.split(RegExp(r'\s+'));
  if (headerParts.length < 2) return;
  final N = int.parse(headerParts[0]);
  final M = int.parse(headerParts[1]);

  final heights = <int>[];
  if (headerParts.length > 2) {
    for (var i = 2; i < headerParts.length && heights.length < N; i++) {
      heights.add(int.parse(headerParts[i]));
    }
  }

  while (heights.length < N) {
    final line = stdin.readLineSync();
    if (line == null) break;
    final parts = line.trim().split(RegExp(r'\s+'));
    for (var p in parts) {
      if (p.isEmpty) continue;
      heights.add(int.parse(p));
      if (heights.length >= N) break;
    }
  }
  if (heights.length < N) return;

  final trees = heights.map((h) => Tree(h)).toList();
  final forest = Forest(trees);
  final Cutter cutter = SimpleCutter();
  final result = findMaxHeight(forest, M, cutter);
  print(result);
}
