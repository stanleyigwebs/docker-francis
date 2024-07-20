This nginx template is used to route traffic for various domains in a single machine.

## etc\hosts file

After necessary Nginx configurations, be sure to add domain and 127.0.0.1 IP address to the local machine etc/hosts file.

Example:

```
127.0.0.1 api.homeflower.test
```

**Windows**

The hosts file can be found on a windows machine at `C:\Windows\System32\drivers\etc\hosts`

[Reference](https://laracasts.com/discuss/channels/laravel/storage-link-not-loading-image-after-symlink?page=1&replyId=781181)

## Symlink

Since docker `php artisan storage:link` won't create a docker worthy symlink, you should create the symlink by:

- Entering into the php container
- Cd into the public folder and run `ln -s ../storage/app/public storage`
  -If this symlink was already created by `php artisan storage:link` remove it with `php artisan storage:unlink`, before proceeding.

[Reference](https://laracasts.com/discuss/channels/laravel/storage-link-not-loading-image-after-symlink?page=1&replyId=781181)
