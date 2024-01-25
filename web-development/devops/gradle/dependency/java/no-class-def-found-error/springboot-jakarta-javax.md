## References
- [How to migrate to Spring boot 3 when relying on a third-party library that still uses javax instead of jakarta api?](https://stackoverflow.com/questions/75726362/how-to-migrate-to-spring-boot-3-when-relying-on-a-third-party-library-that-still)
- [How to avoid compatibility issues between Java EE and Jakarta EE?](https://stackoverflow.com/questions/77539033/how-to-avoid-compatibility-issues-between-java-ee-and-jakarta-ee)

----
----

## spring boot 3, what If I include dependency using javax

In Spring Boot 3, using dependencies with `javax` namespace can lead to compatibility issues, as Spring Framework 6 and Spring Boot 3 have moved to the Jakarta EE 9+ APIs, which use the `jakarta.*` namespace instead of the `javax.*` namespace. This shift is a significant change in the Java EE/Jakarta EE ecosystem.

Here's what you need to know:

1. **Namespace Changes**: With the transition from Java EE to Jakarta EE, one of the most significant changes is the shift from the `javax.*` namespace to the `jakarta.*` namespace. This means that classes and packages that were previously under `javax.*` are now under `jakarta.*`.

2. **Compatibility**: If you try to include dependencies that are still using the `javax.*` namespace in a Spring Boot 3 project, you are likely to run into compatibility issues like `ClassNotFoundException` or `NoClassDefFoundError`. This is because Spring Boot 3 expects dependencies to be in the `jakarta.*` namespace.

3. **Migrating Dependencies**:
    - If you are migrating an existing application to Spring Boot 3, you need to replace dependencies that use the `javax.*` namespace with their equivalent `jakarta.*` namespace versions.
    - For JAXB, you would use the `jakarta.xml.bind-api` dependency instead of the older `javax.xml.bind-api`.
    - Update your code to use the `jakarta.*` package names instead of `javax.*`. This includes updating import statements and fully qualified class names.

4. **Gradle Dependency**:
    - For JAXB in a Spring Boot 3 project, your Gradle file should include something like:
      ```gradle
      implementation 'jakarta.xml.bind:jakarta.xml.bind-api:2.3.3'
      runtimeOnly 'org.glassfish.jaxb:jaxb-runtime:2.3.3'
      ```
    - Make sure to choose the version compatible with Spring Boot 3 and Jakarta EE 9+.

5. **Testing and Validation**: After making these changes, thoroughly test your application to ensure that there are no runtime issues due to the namespace change.

6. **Consult Documentation**: Always refer to the latest Spring Boot documentation for guidance on the recommended approach to dependencies and configuration with the latest version of Spring Boot.

Remember, the transition to `jakarta.*` namespaces is a significant change, and thorough testing is crucial to ensure that your application works as expected after migration.

---
---

## Why Jakarta?

The transition from "Java EE" (Java Platform, Enterprise Edition) to "Jakarta EE" is a **result of Oracle's decision** to transfer the rights and responsibilities of **Java EE to the Eclipse Foundation, a well-known organization in the open-source community**. 

This move was primarily aimed at ensuring the continued evolution and sustainability of enterprise Java technologies under more open and community-driven stewardship. The name change to "Jakarta EE" was a significant part of this transition for several reasons:

1. **Trademark Issues**: Oracle owns the Java trademark and did not grant the Eclipse Foundation the right to continue using the "Java EE" and "javax.*" package names. As a result, the community needed a new brand name to continue developing the enterprise Java stack. "Jakarta EE" was chosen as the new name.

2. **New Namespace**: Along with the new brand name, a new namespace was required, leading to the shift from `javax.*` to `jakarta.*`. This change was necessary due to the same legal and trademark issues surrounding the use of "Java" in package names.

3. **Community-Driven Development**: By moving to the Eclipse Foundation, the development of enterprise Java becomes more open and community-driven, which was a long-standing goal for many in the Java community. The Eclipse Foundation is known for its transparent and open governance model, which is expected to invigorate the development and evolution of enterprise Java technologies.

4. **Future Innovation and Evolution**: The shift to Jakarta EE opens the door for innovation and modernization. Under the stewardship of the Eclipse Foundation, Jakarta EE is positioned to evolve more rapidly, incorporating newer technologies and methodologies, and better meeting the needs of modern enterprise Java development.

5. **Preserving the Ecosystem**: Despite the name and namespace changes, Jakarta EE maintains continuity with Java EE. It preserves the rich heritage and vast ecosystem of enterprise Java technologies, libraries, and applications, while setting a path for future growth and adaptation.

6. **Global Collaboration**: The transition to Jakarta EE represents a global collaboration among individuals, organizations, and companies in the Java community. It's a collective effort to keep enterprise Java vibrant, relevant, and adaptable to new challenges and opportunities.

In summary, the move to "Jakarta EE" is both a rebranding and a strategic shift towards a more open, collaborative, and innovative future for enterprise Java, driven by the community and free from the constraints of a single corporate stewardship.