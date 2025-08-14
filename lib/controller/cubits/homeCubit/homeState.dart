import '../../../model/homeData.dart';

class HomeState {
  final bool isLoading;     // هل يتم تحميل البيانات؟
  final HomeData? data;     // البيانات الرئيسية (المكان، الفنادق، ... إلخ)
  final String? error;      // في حالة وجود خطأ

  HomeState({this.isLoading = false, this.data, this.error});

  // لتحديث الحالة بسهولة دون إنشاء كائن جديد يدويًا كل مرة
  HomeState copyWith({
    bool? isLoading,
    HomeData? data,
    String? error,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      error: error,
    );
  }
}
