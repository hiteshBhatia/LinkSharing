package com.intelligrape.linksharing

class User {

    transient springSecurityService

    String username
    String password
    boolean enabled
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired

    String firstName
    String lastName

    static hasMany = [topics: Topic, subscriptions: Subscription]

    static transients = ['fullName']
    static constraints = {
        lastName nullable: true
        username blank: false, unique: true, email: true
        password blank: false
        firstName blank: false
    }

    static mapping = {
        password column: '`password`'
    }

    Set<Role> getAuthorities() {
        UserRole.findAllByUser(this).collect { it.role } as Set
    }

    def beforeInsert() {
        encodePassword()
    }

    def beforeUpdate() {
        if (isDirty('password')) {
            encodePassword()
        }
    }

    protected void encodePassword() {
        password = springSecurityService.encodePassword(password)
    }

    String toString() {
        return firstName + " " + lastName
    }
}
