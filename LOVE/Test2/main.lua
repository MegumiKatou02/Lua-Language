local love = require "love"

math.randomseed(os.time())

function love.load()
    -- Tải hình ảnh của người chơi
player = {
        x = love.graphics.getWidth() / 2, -- Vị trí giữa màn hình
        y = love.graphics.getHeight() / 2,
        skin = love.graphics.newImage("players.png"),
        angle = math.rad(-90), -- Góc quay ban đầu là -π/2 radian (90 độ ngược chiều kim đồng hồ từ hướng phải)
        rotationSpeed = math.rad(200), -- Tốc độ quay, đơn vị radian/giây
        bulletSpeed = 1000, -- Tốc độ của đạn
        shootDelay = 0.2, -- Thời gian chờ giữa mỗi lần bắn (giây)
        canShoot = true, -- Biến trạng thái cho phép bắn
        shootTimer = 0, -- Thời gian đếm để xác định thời điểm tiếp theo có thể bắn
        speed = 149;
}

bullets = {} -- Danh sách các viên đạn
enemy = {
    x = math.random(3, love.graphics.getWidth()),
    y = math.random(3, love.graphics.getHeight()), -- Vị trí y
    radius = 30, -- Bán kính
    alive = true -- Trạng thái sống/chết
}
end

function love.update(dt)
    -- cap nhat enemy
    if enemy.alive == false then
        enemy.x = math.random(3, love.graphics.getWidth())
        enemy.y = math.random(3, love.graphics.getHeight())
        enemy.alive = true
    end
    -- Kiểm tra phím và cập nhật góc quay của player
    if love.keyboard.isDown("w") then
        player.x = player.x + math.cos(player.angle) * player.speed * dt
        player.y = player.y + math.sin(player.angle) * player.speed * dt
    end
    if love.keyboard.isDown("s") then
        player.x = player.x - math.cos(player.angle) * player.speed * dt
        player.y = player.y - math.sin(player.angle) * player.speed * dt
    end
    if love.keyboard.isDown("a") then
        player.angle = player.angle - player.rotationSpeed * dt
    end
    if love.keyboard.isDown("d") then
        player.angle = player.angle + player.rotationSpeed * dt
    end

    -- Cập nhật thời gian đợi trước khi có thể bắn viên đạn tiếp theo
    if not player.canShoot then
        player.shootTimer = player.shootTimer - dt
        if player.shootTimer <= 0 then
            player.canShoot = true
        end
    end

    -- Tạo đạn mới khi nhấn phím space và có thể bắn
    if love.keyboard.isDown("j") and player.canShoot then
        createBullet(player.x, player.y, player.angle)
        player.canShoot = false
        player.shootTimer = player.shootDelay
    end

    -- Cập nhật vị trí của các viên đạn
    for i = #bullets, 1, -1 do
        local bullet = bullets[i]
        bullet.x = bullet.x + bullet.speed * math.cos(bullet.angle) * dt
        bullet.y = bullet.y + bullet.speed * math.sin(bullet.angle) * dt

        -- Xóa đạn nếu nó ra khỏi màn hình
        if bullet.x < 0 or bullet.x > love.graphics.getWidth() or bullet.y < 0 or bullet.y > love.graphics.getHeight() then
            table.remove(bullets, i)
        end
        if enemy.alive and checkCollision(bullet.x, bullet.y, 0, enemy.x, enemy.y, enemy.radius) then
            -- Nếu va chạm xảy ra và con quái còn sống, đặt trạng thái của con quái là chết và xóa viên đạn
            enemy.alive = false
            table.remove(bullets, i)
            break -- Đảm bảo chỉ xử lý một viên đạn khi va chạm
        end
    end
end

function love.draw()
    -- Vẽ hình ảnh của người chơi với góc quay đã cập nhật
    love.graphics.draw(player.skin, player.x, player.y, player.angle, 1, 1, player.skin:getWidth() / 2, player.skin:getHeight() / 2)

    -- Đặt độ dày của đoạn thẳng
    love.graphics.setLineWidth(5)

    if enemy.alive then
        love.graphics.circle("fill", enemy.x, enemy.y, enemy.radius)
    end
    love.graphics.print(#enemy, 100, 100)

    -- Vẽ các viên đạn
    for _, bullet in ipairs(bullets) do
        -- Tính toán tọa độ của điểm kết thúc của đoạn thẳng
        local endX = bullet.x + math.cos(bullet.angle) * 20 -- 20 là độ dài của đoạn thẳng
        local endY = bullet.y + math.sin(bullet.angle) * 20

        -- Vẽ đoạn thẳng
        love.graphics.line(bullet.x, bullet.y, endX, endY)
    end
end

function createBullet(x, y, angle)
    local bullet = {
        x = x,
        y = y,
        angle = angle,
        speed = player.bulletSpeed
    }
    table.insert(bullets, bullet)
end

-- Hàm kiểm tra va chạm giữa hai hình tròn
function checkCollision(x1, y1, r1, x2, y2, r2)
    local dx = x2 - x1
    local dy = y2 - y1
    local distance = math.sqrt(dx * dx + dy * dy)
    return distance < r1 + r2
end