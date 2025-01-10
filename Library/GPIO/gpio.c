//
// Created by user on 10/01/2025.
//
#include "at32f403a_407_wk_config.h"
#include "wk_gpio.h"
#include "wk_system.h"

void blink_led_at32(void) {
	gpio_bits_write(LED_GPIO_PORT, LED_PIN, TRUE);
	wk_delay_ms(500);
	gpio_bits_write(LED_GPIO_PORT, LED_PIN, FALSE);
	wk_delay_ms(500);
}