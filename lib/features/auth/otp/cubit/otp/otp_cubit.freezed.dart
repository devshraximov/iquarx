// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'otp_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OtpState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OtpState()';
}


}

/// @nodoc
class $OtpStateCopyWith<$Res>  {
$OtpStateCopyWith(OtpState _, $Res Function(OtpState) __);
}


/// Adds pattern-matching-related methods to [OtpState].
extension OtpStatePatterns on OtpState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _ShowLoading value)?  showLoading,TResult Function( _DismissLoading value)?  dismissLoading,TResult Function( _ResendLoading value)?  resendLoading,TResult Function( _RestartTimer value)?  restartTimer,TResult Function( _StopTimer value)?  stopTimer,TResult Function( _InvalidCode value)?  invalidCode,TResult Function( _ShowErrorMessage value)?  showErrorMessage,TResult Function( _UpdateInitialArgs value)?  updateInitialArgs,TResult Function( _Success value)?  success,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _ShowLoading() when showLoading != null:
return showLoading(_that);case _DismissLoading() when dismissLoading != null:
return dismissLoading(_that);case _ResendLoading() when resendLoading != null:
return resendLoading(_that);case _RestartTimer() when restartTimer != null:
return restartTimer(_that);case _StopTimer() when stopTimer != null:
return stopTimer(_that);case _InvalidCode() when invalidCode != null:
return invalidCode(_that);case _ShowErrorMessage() when showErrorMessage != null:
return showErrorMessage(_that);case _UpdateInitialArgs() when updateInitialArgs != null:
return updateInitialArgs(_that);case _Success() when success != null:
return success(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _ShowLoading value)  showLoading,required TResult Function( _DismissLoading value)  dismissLoading,required TResult Function( _ResendLoading value)  resendLoading,required TResult Function( _RestartTimer value)  restartTimer,required TResult Function( _StopTimer value)  stopTimer,required TResult Function( _InvalidCode value)  invalidCode,required TResult Function( _ShowErrorMessage value)  showErrorMessage,required TResult Function( _UpdateInitialArgs value)  updateInitialArgs,required TResult Function( _Success value)  success,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _ShowLoading():
return showLoading(_that);case _DismissLoading():
return dismissLoading(_that);case _ResendLoading():
return resendLoading(_that);case _RestartTimer():
return restartTimer(_that);case _StopTimer():
return stopTimer(_that);case _InvalidCode():
return invalidCode(_that);case _ShowErrorMessage():
return showErrorMessage(_that);case _UpdateInitialArgs():
return updateInitialArgs(_that);case _Success():
return success(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _ShowLoading value)?  showLoading,TResult? Function( _DismissLoading value)?  dismissLoading,TResult? Function( _ResendLoading value)?  resendLoading,TResult? Function( _RestartTimer value)?  restartTimer,TResult? Function( _StopTimer value)?  stopTimer,TResult? Function( _InvalidCode value)?  invalidCode,TResult? Function( _ShowErrorMessage value)?  showErrorMessage,TResult? Function( _UpdateInitialArgs value)?  updateInitialArgs,TResult? Function( _Success value)?  success,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _ShowLoading() when showLoading != null:
return showLoading(_that);case _DismissLoading() when dismissLoading != null:
return dismissLoading(_that);case _ResendLoading() when resendLoading != null:
return resendLoading(_that);case _RestartTimer() when restartTimer != null:
return restartTimer(_that);case _StopTimer() when stopTimer != null:
return stopTimer(_that);case _InvalidCode() when invalidCode != null:
return invalidCode(_that);case _ShowErrorMessage() when showErrorMessage != null:
return showErrorMessage(_that);case _UpdateInitialArgs() when updateInitialArgs != null:
return updateInitialArgs(_that);case _Success() when success != null:
return success(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  showLoading,TResult Function()?  dismissLoading,TResult Function()?  resendLoading,TResult Function()?  restartTimer,TResult Function()?  stopTimer,TResult Function( bool value)?  invalidCode,TResult Function( Failure failure)?  showErrorMessage,TResult Function( DataMap args)?  updateInitialArgs,TResult Function( DataMap request,  DataMap data)?  success,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _ShowLoading() when showLoading != null:
return showLoading();case _DismissLoading() when dismissLoading != null:
return dismissLoading();case _ResendLoading() when resendLoading != null:
return resendLoading();case _RestartTimer() when restartTimer != null:
return restartTimer();case _StopTimer() when stopTimer != null:
return stopTimer();case _InvalidCode() when invalidCode != null:
return invalidCode(_that.value);case _ShowErrorMessage() when showErrorMessage != null:
return showErrorMessage(_that.failure);case _UpdateInitialArgs() when updateInitialArgs != null:
return updateInitialArgs(_that.args);case _Success() when success != null:
return success(_that.request,_that.data);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  showLoading,required TResult Function()  dismissLoading,required TResult Function()  resendLoading,required TResult Function()  restartTimer,required TResult Function()  stopTimer,required TResult Function( bool value)  invalidCode,required TResult Function( Failure failure)  showErrorMessage,required TResult Function( DataMap args)  updateInitialArgs,required TResult Function( DataMap request,  DataMap data)  success,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _ShowLoading():
return showLoading();case _DismissLoading():
return dismissLoading();case _ResendLoading():
return resendLoading();case _RestartTimer():
return restartTimer();case _StopTimer():
return stopTimer();case _InvalidCode():
return invalidCode(_that.value);case _ShowErrorMessage():
return showErrorMessage(_that.failure);case _UpdateInitialArgs():
return updateInitialArgs(_that.args);case _Success():
return success(_that.request,_that.data);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  showLoading,TResult? Function()?  dismissLoading,TResult? Function()?  resendLoading,TResult? Function()?  restartTimer,TResult? Function()?  stopTimer,TResult? Function( bool value)?  invalidCode,TResult? Function( Failure failure)?  showErrorMessage,TResult? Function( DataMap args)?  updateInitialArgs,TResult? Function( DataMap request,  DataMap data)?  success,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _ShowLoading() when showLoading != null:
return showLoading();case _DismissLoading() when dismissLoading != null:
return dismissLoading();case _ResendLoading() when resendLoading != null:
return resendLoading();case _RestartTimer() when restartTimer != null:
return restartTimer();case _StopTimer() when stopTimer != null:
return stopTimer();case _InvalidCode() when invalidCode != null:
return invalidCode(_that.value);case _ShowErrorMessage() when showErrorMessage != null:
return showErrorMessage(_that.failure);case _UpdateInitialArgs() when updateInitialArgs != null:
return updateInitialArgs(_that.args);case _Success() when success != null:
return success(_that.request,_that.data);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements OtpState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OtpState.initial()';
}


}




/// @nodoc


class _ShowLoading implements OtpState {
  const _ShowLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShowLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OtpState.showLoading()';
}


}




/// @nodoc


class _DismissLoading implements OtpState {
  const _DismissLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DismissLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OtpState.dismissLoading()';
}


}




/// @nodoc


class _ResendLoading implements OtpState {
  const _ResendLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResendLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OtpState.resendLoading()';
}


}




/// @nodoc


class _RestartTimer implements OtpState {
  const _RestartTimer();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RestartTimer);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OtpState.restartTimer()';
}


}




/// @nodoc


class _StopTimer implements OtpState {
  const _StopTimer();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StopTimer);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OtpState.stopTimer()';
}


}




/// @nodoc


class _InvalidCode implements OtpState {
  const _InvalidCode(this.value);
  

 final  bool value;

/// Create a copy of OtpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvalidCodeCopyWith<_InvalidCode> get copyWith => __$InvalidCodeCopyWithImpl<_InvalidCode>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvalidCode&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'OtpState.invalidCode(value: $value)';
}


}

/// @nodoc
abstract mixin class _$InvalidCodeCopyWith<$Res> implements $OtpStateCopyWith<$Res> {
  factory _$InvalidCodeCopyWith(_InvalidCode value, $Res Function(_InvalidCode) _then) = __$InvalidCodeCopyWithImpl;
@useResult
$Res call({
 bool value
});




}
/// @nodoc
class __$InvalidCodeCopyWithImpl<$Res>
    implements _$InvalidCodeCopyWith<$Res> {
  __$InvalidCodeCopyWithImpl(this._self, this._then);

  final _InvalidCode _self;
  final $Res Function(_InvalidCode) _then;

/// Create a copy of OtpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_InvalidCode(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _ShowErrorMessage implements OtpState {
  const _ShowErrorMessage(this.failure);
  

 final  Failure failure;

/// Create a copy of OtpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShowErrorMessageCopyWith<_ShowErrorMessage> get copyWith => __$ShowErrorMessageCopyWithImpl<_ShowErrorMessage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShowErrorMessage&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'OtpState.showErrorMessage(failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$ShowErrorMessageCopyWith<$Res> implements $OtpStateCopyWith<$Res> {
  factory _$ShowErrorMessageCopyWith(_ShowErrorMessage value, $Res Function(_ShowErrorMessage) _then) = __$ShowErrorMessageCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class __$ShowErrorMessageCopyWithImpl<$Res>
    implements _$ShowErrorMessageCopyWith<$Res> {
  __$ShowErrorMessageCopyWithImpl(this._self, this._then);

  final _ShowErrorMessage _self;
  final $Res Function(_ShowErrorMessage) _then;

/// Create a copy of OtpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(_ShowErrorMessage(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

/// @nodoc


class _UpdateInitialArgs implements OtpState {
  const _UpdateInitialArgs(final  DataMap args): _args = args;
  

 final  DataMap _args;
 DataMap get args {
  if (_args is EqualUnmodifiableMapView) return _args;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_args);
}


/// Create a copy of OtpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateInitialArgsCopyWith<_UpdateInitialArgs> get copyWith => __$UpdateInitialArgsCopyWithImpl<_UpdateInitialArgs>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateInitialArgs&&const DeepCollectionEquality().equals(other._args, _args));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_args));

@override
String toString() {
  return 'OtpState.updateInitialArgs(args: $args)';
}


}

/// @nodoc
abstract mixin class _$UpdateInitialArgsCopyWith<$Res> implements $OtpStateCopyWith<$Res> {
  factory _$UpdateInitialArgsCopyWith(_UpdateInitialArgs value, $Res Function(_UpdateInitialArgs) _then) = __$UpdateInitialArgsCopyWithImpl;
@useResult
$Res call({
 DataMap args
});




}
/// @nodoc
class __$UpdateInitialArgsCopyWithImpl<$Res>
    implements _$UpdateInitialArgsCopyWith<$Res> {
  __$UpdateInitialArgsCopyWithImpl(this._self, this._then);

  final _UpdateInitialArgs _self;
  final $Res Function(_UpdateInitialArgs) _then;

/// Create a copy of OtpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? args = null,}) {
  return _then(_UpdateInitialArgs(
null == args ? _self._args : args // ignore: cast_nullable_to_non_nullable
as DataMap,
  ));
}


}

/// @nodoc


class _Success implements OtpState {
  const _Success(final  DataMap request, final  DataMap data): _request = request,_data = data;
  

 final  DataMap _request;
 DataMap get request {
  if (_request is EqualUnmodifiableMapView) return _request;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_request);
}

 final  DataMap _data;
 DataMap get data {
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_data);
}


/// Create a copy of OtpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&const DeepCollectionEquality().equals(other._request, _request)&&const DeepCollectionEquality().equals(other._data, _data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_request),const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'OtpState.success(request: $request, data: $data)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $OtpStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 DataMap request, DataMap data
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of OtpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? request = null,Object? data = null,}) {
  return _then(_Success(
null == request ? _self._request : request // ignore: cast_nullable_to_non_nullable
as DataMap,null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as DataMap,
  ));
}


}

// dart format on
