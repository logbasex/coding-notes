```
> ls -la | grep '^-'
-rw-rw-r--  1 logbasex logbasex   628 Thg 5  11 18:18 address.json
-rw-rw-r--  1 logbasex logbasex  1651 Thg 5  11 18:18 auth.json
-rw-rw-r--  1 logbasex logbasex 12921 Thg 5  11 18:21 common.json
-rw-rw-r--  1 logbasex logbasex   562 Thg 5  11 18:18 landing-page.json
-rw-rw-r--  1 logbasex logbasex   133 Thg 5  11 18:18 order.json
-rw-rw-r--  1 logbasex logbasex   401 Thg 5  11 18:18 payment.json
-rw-rw-r--  1 logbasex logbasex  7268 Thg 5  11 18:18 post.json
-rw-rw-r--  1 logbasex logbasex    91 Thg 5  11 18:18 shop.json
-rw-rw-r--  1 logbasex logbasex   130 Thg 5  11 18:18 talent.json
-rw-rw-r--  1 logbasex logbasex   108 Thg 5  11 18:18 welcome.json
-rw-rw-r--  1 logbasex logbasex   246 Thg 5  11 18:18 wishlist.json
```

address.json
```
{
  "default_address": "Default addresses",
  "add_address": "Add address",
  "additional_address_entries": "Additional address entries",
  "text_no_address": "You haven't added any address",
  "shipping_address": "Shipping address",
  "billing_address": "Billing address",
  "delete_address_confirm": "Are you sure you want to delete this address?",
  "no_billing_address": "You don't have any billing address saved",
  "same_billing_shipping":"My billing and my shipping address are the same",
  "no_shipping_address":"You don't have any payment methods saved",
  "please_select_shipping":"Please select a shipping address"
}
```

```
jq -s add *.json > data.json
```

![image](https://user-images.githubusercontent.com/22516811/167912035-d24d9f29-df4b-4bb0-bb4e-760760978490.png)

![image](https://user-images.githubusercontent.com/22516811/167912100-aa54795b-b5a8-4fe1-8189-fbc7514c86cc.png)

## Reference
https://stackoverflow.com/questions/60099083/use-jq-to-concatenate-json-arrays-in-multiple-files
https://stedolan.github.io/jq/manual/
https://www.howtogeek.com/447561/how-to-use-the-and-and-or-functions-in-google-sheets/
https://www.spreadsheetclass.com/combine-columns-in-google-sheets/
https://earthly.dev/blog/convert-to-from-json/
