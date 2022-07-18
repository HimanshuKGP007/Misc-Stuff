#include <bits/stdc++.h>
using namespace std;
#define ll long long int
bool check(int freq[],int maxi){
    int ct=0;
    for(int i=0;i<26;i++){
        if(freq[i])ct++;
    }
    return ct==maxi;
}
int main() {
    string s; cin>>s;
    set <char> st;
    int n = s.size();
    for(int i=0;i<n;i++){
        st.insert(s[i]);
    }
    int l=1; int r=n; int maxi = st.size();
    int ans = n;        
    while(l<=r){
        int mid = (l+r)/2;
        int freq[27]={0}; int flag=0;
        for(int i=0;i<mid;i++)freq[s[i]-'a']++;
        if(check(freq,maxi))flag=1;
        int j=1;
        while(j+mid-1<=n-1){
            freq[s[j-1]-'a']--;
            freq[s[j+mid-1]-'a']++;
            if(check(freq,maxi)){
                flag=1; break;
            }
                j++;
        }
            if(flag){
                ans=mid;
                r = mid-1;
            }   else{
                l = mid+1;
            }
    }
    cout<<ans;
    return 0;
}







