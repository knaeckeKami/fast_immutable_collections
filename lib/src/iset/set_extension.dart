import "../ilist/ilist_of_4.dart";
import "iset.dart";

/// See also: [FicListExtension]
extension FicSetExtension<T> on Set<T> {
  /// Locks the set, returning an *immutable* set ([ISet]).
  ISet<T> get lock => ISet<T>(this);

  /// Locks the set, returning an *immutable* set ([ISet]).
  ///
  /// **This is unsafe: Use it at your own peril**.
  ///
  /// This constructor is fast, since it makes no defensive copies of the set.
  /// However, you should only use this with a new set you've created yourself,
  /// when you are sure no external copies exist. If the original set is modified,
  /// it will break the [ISet] and any other derived sets in unpredictable ways.
  ///
  /// Note you can optionally disallow unsafe constructors in the global configuration
  /// by doing: `ImmutableCollection.disallowUnsafeConstructors = true` (and then optionally
  /// preventing further configuration changes by calling `lockConfig()`).
  ///
  /// See also: [ImmutableCollection]
  ISet<T> get lockUnsafe => ISet<T>.unsafe(this, config: ISet.defaultConfig);

  /// If the item doesn't exist in the set, add it and return `true`.
  /// Otherwise, if the item already exists in the set, remove it and return `false`.
  bool toggle(T item) {
    var result = contains(item);
    if (result)
      remove(item);
    else
      add(item);
    return result;
  }

  /// Given this set and [other], returns:
  ///
  /// 1) Items of this set which are NOT in [other] (difference this - other), in this set's order.
  /// 2) Items of [other] which are NOT in this set (difference other - this), in [other]'s order.
  /// 3) Items of this set which are also in [other], in this set's order.
  /// 4) Items of this set which are also in [other], in [other]'s order.
  ///
  IListOf4<List?> diffAndIntersect<G>(
    Set<G> other, {
    bool diffThisMinusOther = true,
    bool diffOtherMinusThis = true,
    bool intersectThisWithOther = true,
    bool intersectOtherWithThis = true,
  }) {
    List<T>? _differenceThisMinusOther = diffThisMinusOther ? [] : null;
    List<G>? _differenceOtherMinusThis = diffOtherMinusThis ? [] : null;
    List<T>? _intersectionOfThisWithOther = intersectThisWithOther ? [] : null;
    List<T>? _intersectionOfOtherWithThis = intersectOtherWithThis ? [] : null;

    if (diffThisMinusOther || intersectThisWithOther)
      for (var element in this) {
        if (other.contains(element)) {
          _intersectionOfThisWithOther?.add(element);
        } else
          _differenceThisMinusOther?.add(element);
      }

    if (diffOtherMinusThis || intersectOtherWithThis)
      for (var element in other) {
        if (contains(element))
          _intersectionOfOtherWithThis?.add(element as T);
        else
          _differenceOtherMinusThis?.add(element);
      }

    return IListOf4(
      _differenceThisMinusOther,
      _differenceOtherMinusThis,
      _intersectionOfThisWithOther,
      _intersectionOfOtherWithThis,
    );
  }
}
