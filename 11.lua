local Student =  {
    name = "Chinh",
    age = 18,
    score = 8.9
}

print(Student.name)

local function Pet(name)
    name = name or "None"
    return {
        name = name,
        status = "hungry",
        feed = function(self)
            self.status = "Full"
        end
    }
end

local function Dog(name, breed)
    local dog = Pet(name)
    dog.breed = breed
    dog.hello = 0
    dog.isHello = function (self)
        return self.hello >= 10
    end
    dog.bark = function (self)
        print("wolf wolf")
    end
    return dog
end

local chinh = Dog("Chinh", "Poodle")
chinh:bark()
print(chinh.breed)