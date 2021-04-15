import pygame
import random
from laser import laser
from enemy import enemy
from pygame import mixer

# Variables
player_speed = 2
enemy_speed = 1
laser_speed = 7
playing = True
running = True
player_explosion_timer = 100

# Intialize the pygame package. Must do to use pygame stuff
pygame.init()

# creating the screen
screen = pygame.display.set_mode((800, 600))

# Title and Icon
pygame.display.set_caption("My Space Invaders")
icon = pygame.image.load('assets/icon.png')
pygame.display.set_icon(icon)

# Background
background = pygame.image.load('assets/background.png')

# Background sound
mixer.music.load('assets/background.wav')           # Background music
mixer.music.play(-1)                         # Changing volume
mixer.music.set_volume(0.08)                 # Playing music on loop

# Player icon
playerImg = pygame.image.load('assets/player.png')
# Giving starting coordinates
playerX = 384
playerY = 480
playerX_change = 0

# Enemy icon
enemyImg = pygame.image.load('assets/enemy.png')
enemies = []
num_of_enemies = 10                            # Number of enemies
for i in range(num_of_enemies):
    enemies.append(enemy(random.randint(0, 768), random.randint(50, 150), enemy_speed, 40))  # The 40 is how far they drop down

# Laser
laserImg = pygame.image.load('assets/laser.png')
laserX = 0
laserY = 480
laserY_change = laser_speed
active_lasers = []                 # list of active lasers

# Explosion
explosionImg = pygame.image.load('assets/explosion.png')
explosionX = 0
explosionY = 0
timer = 0                          # Timer to keep the explosion on screen for a sec

# Score
score_value = 0
font = pygame.font.SysFont("fixedsysregular", 35)
textX = 10
textY = 10

# Game over text
over_font = pygame.font.SysFont("fixedsysregular", 80)


# Method to draw score
def show_score(x, y):
    score = font.render("Score: " + str(score_value), True, (255, 255, 255))
    screen.blit(score, (x, y))


# Method for game over
def game_over():
    over_text = over_font.render("GAME OVER", True, (255, 255, 255))
    screen.blit(over_text, (225, 250))


# Method to draw player on screen
def player(x, y):
    screen.blit(playerImg, (round(x), round(y)))    # round because blit needs ints not floats


# Method to draw enemy on screen
def draw_enemy(x, y):
    screen.blit(enemyImg, (round(x), round(y)))  # round because blit needs ints not floats


# Method to draw laser on screen
def fire_laser(laser_fire):
    screen.blit(laserImg, (laser_fire.getX() + 16, laser_fire.getY() + 10))


# Keeps game running until close button is pressed (Game Loop)

while running:  # Game loop

    # Background image
    screen.blit(background, (0, 0))

    for event in pygame.event.get():

        # Quit
        if event.type == pygame.QUIT:
            running = False

        # Controls
        # if keystroke is pressed check whether its right or left
        if event.type == pygame.KEYDOWN:  # If pressed or held down the player should move
            if event.key == pygame.K_LEFT:
                playerX_change = -player_speed
                direction = 1  # Direction tells which way the player is traveling
            if event.key == pygame.K_RIGHT:
                playerX_change = player_speed
                direction = 0
            if event.key == pygame.K_SPACE:
                laser_sound = mixer.Sound('assets/laser.wav')  # Laser sound
                laser_sound.set_volume(0.08)            # Changing volume
                laser_sound.play()                      # Playing sound
                laserX = playerX
                l = laser(laserX, laserY)      # creating laser object
                active_lasers.append(l)        # adding laser object to list
                fire_laser(l)                  # initial shot
        if event.type == pygame.KEYUP:  # Once released the player should stop moving
            if event.key == pygame.K_LEFT and direction == 1: # If direction is same as keyup arrow, stop. Else ignore
                playerX_change = 0
            if event.key == pygame.K_RIGHT and direction == 0: # If direction is same as keyup arrow, stop. Else ignore
                playerX_change = 0

    # Laser movement
    for shot in active_lasers:
        if shot.getY() <= 0:                   # If shot is higher than top of screen it is no longer active
            active_lasers.remove(shot)
        else:                                  # If shot is still on screen
            shot.setY(shot.getY() - laserY_change)
            fire_laser(shot)
        # Laser collision
        for enemy in enemies:    # Basically checks if ANY laser has hit ANY enemy
            if ((enemy.getX() - 16) < shot.getX() < (enemy.getX() + 16)) and \
                    ((enemy.getY() - 16) < shot.getY() < (enemy.getY() + 8)):
                score_value += 1
                explosionX = enemy.getX()
                explosionY = enemy.getY()
                enemy.setX(random.randint(0, 768))    # Random spawn
                enemy.setY(random.randint(50, 150))   # Random spawn
                timer = 10                            # how long the explosion is on the screen for
                explosion_sound = mixer.Sound('assets/explosion.wav')       # Explosion sound
                explosion_sound.set_volume(0.08)                     # Changing volume
                explosion_sound.play()                               # Playing sound
                active_lasers.remove(shot)

    # Explosion
    if timer > 0:                              # Showing the explosion after a hit
        screen.blit(explosionImg, (explosionX, explosionY))
        timer -= 1

    # Player movement
    if playing:
        playerX += playerX_change  # Moves or stops moving player along the x-axis based on playerX_change variable
        # Boundaries of the window for the player
        if playerX < 0:
            playerX = 0
        elif playerX > 768:  # 768 to take into account the size of the player image (800 - 32)
            playerX = 768
        player(playerX, playerY)  # player method is after fill method so the player icon is drawn on top of the background

    # Enemy movement
    for foe in enemies:
        if foe.getY() > 460:      # Checks to see if any enemy has gotten too low and ends game
            playing = False

        if playing:                               # If the game is still being played and player hasn't lost yet
            foe.setX(foe.getX() + foe.get_x_change())  # Moves the enemy in the direction and speed dictated by enemyX_change
            # Boundaries of window for the enemy
            if foe.getX() < 0:
                foe.set_x_change(enemy_speed)
                foe.setY(foe.getY() + foe.get_y_change())
            if foe.getX() > 768:                      # 768 to take into account the size of the player image (800 - 32)
                foe.set_x_change(-enemy_speed)
                foe.setY(foe.getY() + foe.get_y_change())
            draw_enemy(foe.getX(), foe.getY())
        else:
            if foe.getY() < 568:
                foe.setY(foe.getY() + 1)
            draw_enemy(foe.getX(), foe.getY())
            game_over()
            explosionY = playerY
            explosionX = playerX

    # Player explosion
    if not playing:
        if player_explosion_timer > 0:                              # Showing the explosion after a loss
            screen.blit(explosionImg, (explosionX, explosionY))
            player_explosion_timer -= 1
            player_explosion_sound = mixer.Sound('assets/explosion.wav')       # Explosion sound
            player_explosion_sound.set_volume(0.08)                     # Changing volume
            player_explosion_sound.play()                               # Playing sound

    # Show score
    show_score(textX, textY)

    # Constantly updating window while loop is true (while the game is running)
    pygame.display.update()
