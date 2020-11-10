import "package:test/test.dart";

import "package:fast_immutable_collections_benchmarks/fast_immutable_collections_benchmarks.dart";

void main() {
  group("Separate Benchmarks |", () {
    test("Map (Mutable)", () {
      final TableScoreEmitter tableScoreEmitter =
          TableScoreEmitter(prefixName: "read_map_mutable", config: Config(runs: 100, size: 1000));
      final MutableMapReadBenchmark mutableMapReadBenchmark =
          MutableMapReadBenchmark(emitter: tableScoreEmitter);

      mutableMapReadBenchmark.report();

      expect(mutableMapReadBenchmark.newVar,
          MapBenchmarkBase.getDummyGeneratedMap(size: 1000)[MapReadBenchmark.keyToRead]);
    });

    test("IMap", () {
      final TableScoreEmitter tableScoreEmitter =
          TableScoreEmitter(prefixName: "read_iMap", config: Config(runs: 100, size: 1000));
      final IMapReadBenchmark iMapReadBenchmark = IMapReadBenchmark(emitter: tableScoreEmitter);

      iMapReadBenchmark.report();

      expect(iMapReadBenchmark.newVar,
          MapBenchmarkBase.getDummyGeneratedMap(size: 1000)[MapReadBenchmark.keyToRead]);
    });

    test("KtMap", () {
      final TableScoreEmitter tableScoreEmitter =
          TableScoreEmitter(prefixName: "read_ktMap", config: Config(runs: 100, size: 1000));
      final KtMapReadBenchmark ktMapReadBenchmark = KtMapReadBenchmark(emitter: tableScoreEmitter);

      ktMapReadBenchmark.report();

      expect(ktMapReadBenchmark.newVar,
          MapBenchmarkBase.getDummyGeneratedMap(size: 1000)[MapReadBenchmark.keyToRead]);
    });

    test("BuiltMap", () {
      final TableScoreEmitter tableScoreEmitter =
          TableScoreEmitter(prefixName: "read_builtMap", config: Config(runs: 100, size: 1000));
      final BuiltMapReadBenchmark builtMapReadBenchmark =
          BuiltMapReadBenchmark(emitter: tableScoreEmitter);

      builtMapReadBenchmark.report();

      expect(builtMapReadBenchmark.newVar,
          MapBenchmarkBase.getDummyGeneratedMap(size: 1000)[MapReadBenchmark.keyToRead]);
    });
  });

  group("Multiple Benchmarks |", () {
    test("Simple run", () {
      final TableScoreEmitter tableScoreEmitter =
          TableScoreEmitter(prefixName: "read", config: Config(runs: 100, size: 1000));
      final MapReadBenchmark readBenchmark = MapReadBenchmark(emitter: tableScoreEmitter);

      readBenchmark.report();

      readBenchmark.benchmarks.forEach((MapBenchmarkBase benchmark) => expect(
          benchmark.toMutable()[MapReadBenchmark.keyToRead],
          MapBenchmarkBase.getDummyGeneratedMap(size: 1000)[MapReadBenchmark.keyToRead]));
    });
  });
}
