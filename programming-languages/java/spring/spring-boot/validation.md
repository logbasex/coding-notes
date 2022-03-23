[Xử lý lỗi xác thực bằng BindingResult](https://techmaster.vn/posts/36877/xac-thuc-request-bang-spring-boot-validation)

------ 

[Difference between @Valid and @Validated in Spring](https://stackoverflow.com/questions/36173332/difference-between-valid-and-validated-in-spring)

As you quoted from the documentation, @Validated was added to support "validation groups", i.e. group of fields in the validated bean. This can be used in multi step forms where you may validate name, email, etc.. in first step and then other fields in following step(s).

The reason why this wasn't added into @Valid annotation is because that it is standardized using the java community process (JSR-303), which takes time and Spring developers wanted to allow people to use this functionality sooner.

---

[Đừng validation bằng tay trong Spring Boot](https://viblo.asia/p/dung-validation-bang-tay-trong-spring-boot-phan-1-3P0lPGyoZox)

----
[Validation with Spring Boot - the Complete Guide](https://reflectoring.io/bean-validation-with-spring-boot/)