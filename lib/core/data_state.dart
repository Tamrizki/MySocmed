class DataState<T> {
  T? data;
  Status? status;
  String? message;
  DataState.init() : status = Status.init;
  DataState.loading() : status = Status.loading;
  DataState.success(this.data) : status = Status.success;
  DataState.error({this.message}) : status = Status.error;
}

enum Status { loading, success, error, init }
