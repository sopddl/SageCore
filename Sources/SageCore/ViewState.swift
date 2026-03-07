// SageCore/Sources/SageCore/ViewState.swift

public enum ViewState<T> {
    case idle
    case loading
    case success(T)
    case error(AppError)
}
