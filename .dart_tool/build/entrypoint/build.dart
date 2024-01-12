// ignore_for_file: directives_ordering
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:build_runner_core/build_runner_core.dart' as _i1;
import 'package:mobx_codegen/builder.dart' as _i2;
import 'package:drift_dev/integrations/build.dart' as _i3;
import 'package:source_gen/builder.dart' as _i4;
import 'package:build_resolvers/builder.dart' as _i5;
import 'dart:isolate' as _i6;
import 'package:build_runner/build_runner.dart' as _i7;
import 'dart:io' as _i8;

final _builders = <_i1.BuilderApplication>[
  _i1.apply(
    r'mobx_codegen:mobx_generator',
    [_i2.storeGenerator],
    _i1.toDependentsOf(r'mobx_codegen'),
    hideOutput: true,
    appliesBuilders: const [r'source_gen:combining_builder'],
  ),
  _i1.apply(
    r'drift_dev:preparing_builder',
    [_i3.preparingBuilder],
    _i1.toNoneByDefault(),
    hideOutput: true,
    appliesBuilders: const [r'drift_dev:cleanup'],
  ),
  _i1.apply(
    r'drift_dev:drift_dev',
    [
      _i3.discover,
      _i3.analyzer,
      _i3.driftBuilder,
    ],
    _i1.toDependentsOf(r'drift_dev'),
    hideOutput: true,
    appliesBuilders: const [
      r'source_gen:combining_builder',
      r'drift_dev:preparing_builder',
    ],
  ),
  _i1.apply(
    r'source_gen:combining_builder',
    [_i4.combiningBuilder],
    _i1.toNoneByDefault(),
    hideOutput: false,
    appliesBuilders: const [r'source_gen:part_cleanup'],
  ),
  _i1.apply(
    r'drift_dev:analyzer',
    [
      _i3.discover,
      _i3.analyzer,
    ],
    _i1.toNoneByDefault(),
    hideOutput: true,
    appliesBuilders: const [r'drift_dev:preparing_builder'],
  ),
  _i1.apply(
    r'drift_dev:not_shared',
    [_i3.driftBuilderNotShared],
    _i1.toNoneByDefault(),
    hideOutput: false,
  ),
  _i1.apply(
    r'drift_dev:modular',
    [_i3.modular],
    _i1.toNoneByDefault(),
    hideOutput: false,
    appliesBuilders: const [r'drift_dev:analyzer'],
  ),
  _i1.apply(
    r'build_resolvers:transitive_digests',
    [_i5.transitiveDigestsBuilder],
    _i1.toAllPackages(),
    isOptional: true,
    hideOutput: true,
    appliesBuilders: const [r'build_resolvers:transitive_digest_cleanup'],
  ),
  _i1.applyPostProcess(
    r'build_resolvers:transitive_digest_cleanup',
    _i5.transitiveDigestCleanup,
  ),
  _i1.applyPostProcess(
    r'source_gen:part_cleanup',
    _i4.partCleanup,
  ),
  _i1.applyPostProcess(
    r'drift_dev:cleanup',
    _i3.driftCleanup,
  ),
];
void main(
  List<String> args, [
  _i6.SendPort? sendPort,
]) async {
  var result = await _i7.run(
    args,
    _builders,
  );
  sendPort?.send(result);
  _i8.exitCode = result;
}
