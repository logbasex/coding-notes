> Tóm tắt lại thì method được tag **@Async** (được gọi là callee), khi được gọi từ 1 process (được gọi là caller) **sẽ được thực hiện ở 1 thread mới**. Caller sẽ không chờ callee được thực thi xong rồi mới thực hiện tiếp (việc chờ rồi mới thực thi tiếp này gọi là đồng bộ - synchronize), mà cứ tiếp tục công việc của caller.
Lúc đó, callee được chạy bất đồng bộ.


