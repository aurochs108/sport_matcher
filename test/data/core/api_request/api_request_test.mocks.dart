import 'package:mockito/mockito.dart' as _i1;
import 'package:sport_matcher/data/core/mapper/abstract_api_error_to_user_message_mapper.dart'
    as _i2;

class MockApiErrorToUserMessageMapper extends _i1.Mock
    implements _i2.AbstractApiErrorToUserMessageMapper {
  @override
  String map(Object? error) => (super.noSuchMethod(
        Invocation.method(#map, [error]),
        returnValue: '',
        returnValueForMissingStub: '',
      ) as String);
}
