// import 'package:flutter/material.dart';
// import 'helpers.dart';
//
// class CachedFutureBuilder<T> extends StatelessWidget {
//   const CachedFutureBuilder(
//       {Key? key,
//         required this.builder,
//         required this.futureFunction,
//         required this.name})
//       : super(key: key);
//
//   final Widget Function(BuildContext context, AsyncSnapshot<T?> snapshot)
//   builder;
//   final Future<T> Function() futureFunction;
//   final String name;
//
//   Future<T?> getData(BuildContext context) async {
//     final api = Api.of(context);
//     final cache = api.cache[name];
//     if (cache != null &&
//         cache.expire >
//             cache.timestamp - DateTime.now().millisecondsSinceEpoch) {
//       Helpers.debugPrint("Restored from cache");
//       return cache.value as T?;
//     }
//
//     final data = await futureFunction();
//     api.cache[name] = CacheControl(value: data);
//
//     return data;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<T?>(future: getData(context), builder: builder);
//   }
// }
//
// class CacheControl {
//   // Default expire duration is 12 hours
//   final int expire, timestamp = DateTime.now().millisecondsSinceEpoch;
//   final dynamic value;
//
//   CacheControl({this.expire = 43200000, required this.value});
// }
//
