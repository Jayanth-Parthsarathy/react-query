type queryClientValue
type fetchMeta

type invalidateQueryFilter = {
  refetchActive: option<bool>,
  refetchInactive: option<bool>,
}

type clientRefetchOptions = {throwOnError: option<bool>}

type invalidateQueryOptions<'queryKey> = {
  queryKey: option<'queryKey>,
  filters: option<invalidateQueryFilter>,
  refetchOptions: option<clientRefetchOptions>,
}

type refetchQueriesOptions<'queryKey> = {
  queryKey: option<'queryKey>,
  filters: option<ReactQuery_Types.queryFilter<'queryKey>>,
  refetchOptions: option<clientRefetchOptions>,
}

type cancelQueriesOptions<'queryKey> = {
  queryKey: option<'queryKey>,
  filters: option<ReactQuery_Types.queryFilter<'queryKey>>,
}

type queryState<'queryData, 'queryError> = {
  data: option<'queryData>,
  dataUpdateCount: int,
  dataUpdatedAt: int,
  error: Js.Nullable.t<'queryError>,
  errorUpdateCount: int,
  errorUpdatedAt: int,
  fetchFailureCount: int,
  fetchMeta: fetchMeta,
  isFetching: bool,
  isInvalidated: bool,
  isPaused: bool,
  status: ReactQuery_Types.queryStatus,
}

@deriving(abstract)
type fetchQueryOptions<'queryKey, 'queryData, 'queryError> = {
  @optional queryKey: 'queryKey,
  @optional queryFn: ReactQuery_Types.queryFunctionContext => Js.Promise.t<'queryData>,
  @optional retry: ReactQuery_Types.retryValue<'queryError>,
  @optional retryOnMount: bool,
  @optional retryDelay: ReactQuery_Types.retryDelayValue<'queryError>,
  @optional staleTime: ReactQuery_Types.timeValue,
  @optional queryKeyHashFn: 'queryKey => string,
  @optional refetchOnMount: ReactQuery_Types.boolOrAlwaysValue,
  @optional structuralSharing: bool,
  @optional initialData: 'queryData => 'queryData,
  @optional initialDataUpdatedAt: unit => int,
}

type queryClient<'queryKey, 'queryData, 'queryError, 'pageParams> = {
  fetchQuery: fetchQueryOptions<'queryKey, 'queryData, 'queryError> => Js.Promise.t<'queryData>,
  fetchInfiniteQuery: fetchQueryOptions<'queryKey, 'queryData, 'queryError> => Js.Promise.t<
    ReactQuery_Types.infiniteData<'queryData, 'pageParams>,
  >,
  prefetchQuery: fetchQueryOptions<'queryKey, 'queryData, 'queryError> => Js.Promise.t<unit>,
  prefetchInfiniteQuery: fetchQueryOptions<'queryKey, 'queryData, 'queryError> => Js.Promise.t<
    unit,
  >,
  getQueryData: 'queryKey => option<'queryData>,
  setQueryData: ('queryKey, option<'queryData>) => 'queryData,
  getQueryState: (
    'queryKey,
    ReactQuery_Types.queryFilter<'queryKey>,
  ) => queryState<'queryData, 'queryError>,
  setQueriesData: (
    ReactQuery_Types.queryDataKeyOrFilterValue<'queryKey>,
    option<'queryData> => 'queryData,
  ) => unit,
  invalidateQueries: (
    option<ReactQuery_Types.queryFilter<'queryKey>>,
    option<clientRefetchOptions>,
  ) => Js.Promise.t<unit>,
  refetchQueries: (
    option<ReactQuery_Types.queryFilter<'queryKey>>,
    option<clientRefetchOptions>,
  ) => Js.Promise.t<unit>,
  cancelQueries: option<ReactQuery_Types.queryFilter<'queryKey>> => Js.Promise.t<unit>,
  removeQueries: option<ReactQuery_Types.queryFilter<'queryKey>> => Js.Promise.t<unit>,
  resetQueries: (
    option<ReactQuery_Types.queryFilter<'queryKey>>,
    option<clientRefetchOptions>,
  ) => Js.Promise.t<unit>,
  isFetching: option<ReactQuery_Types.queryFilter<'queryKey>> => bool,
  isMutating: option<ReactQuery_Types.queryFilter<'queryKey>> => bool,
  // setDefaultOptions
  // getDefaultOptions
  // setQueryDefaults
  // getQueryDefaults
  // getQueryCache
  // setQueryCache
  // getMutationCache
  // setMutationCache
  clear: unit => unit,
}

@module("react-query")
external useQueryClient: unit => queryClient<'queryKey, 'queryData, 'queryError, 'pageParams> =
  "useQueryClient"

module Provider = {
  @new @module("react-query")
  external createClient: unit => queryClientValue = "QueryClient"

  @module("react-query") @react.component
  external make: (
    ~client: queryClientValue,
    ~contextSharing: bool=?,
    ~children: React.element,
  ) => React.element = "QueryClientProvider"
}
