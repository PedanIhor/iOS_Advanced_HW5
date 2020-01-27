# RepositoriesAPI

All URIs are relative to *https://api.github.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**searchRepositories**](RepositoriesAPI.md#searchrepositories) | **GET** /search/repositories | Search Repositories


# **searchRepositories**
```swift
    open class func searchRepositories(q: String, l: String? = nil, completion: @escaping (_ data: RepositoriesList?, _ error: Error?) -> Void)
```

Search Repositories

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import GitHubAPI

let q = "q_example" // String | Search key
let l = "l_example" // String | language (optional)

// Search Repositories
RepositoriesAPI.searchRepositories(q: q, l: l) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **q** | **String** | Search key | 
 **l** | **String** | language | [optional] 

### Return type

[**RepositoriesList**](RepositoriesList.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/vnd.github.v3+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

