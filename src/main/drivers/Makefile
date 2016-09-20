obj-$(CONFIG_GYRO) += accgyro_adxl345.o accgyro_bma280.o accgyro_l3g4200d.o \
		      accgyro_mma845x.o accgyro_mpu3050.o accgyro_mpu6050.o \
		      accgyro_mpu6500.o accgyro_mpu.o \
		      gyro_sync.o
obj-$(CONFIG_GYRO_L3GD20) += accgyro_l3gd20.o
obj-$(CONFIG_GYRO_LSM303DLHC) += accgyro_lsm303dlhc.o
obj-$(CONFIG_GYRO_SPI_MPU6000) += accgyro_spi_mpu6000.o
obj-$(CONFIG_GYRO_SPI_MPU6500) += accgyro_spi_mpu6500.o
obj-y	+= adc.o
obj-y	+= buf_writer.o
obj-y	+= bus_i2c_soft.o bus_spi.o
obj-y	+= dma.o
obj-y	+= exti.o
obj-y	+= flash_m25p16.o
obj-y	+= inverter.o io.o
obj-y	+= pwm_mapping.o
obj-y	+= pwm_output.o
obj-y	+= pwm_rx.o
obj-y	+= rcc.o
obj-y	+= sdcard.o sdcard_standard.o
obj-y	+= serial.o serial_softserial.o serial_uart.o
obj-$(CONFIG_SERIAL_USB_VCP) += serial_usb_vcp.o
obj-y	+= system.o timer.o
obj-y	+= usb_io.o
obj-$(CONFIG_VIDEO_MAX7456) += video_max7456.o
obj-$(CONFIG_BARO)	+= barometer_bmp085.o barometer_bmp280.o barometer_ms5611.o
obj-$(CONFIG_MAG_AK8963) += compass_ak8963.o
obj-$(CONFIG_MAG_AK9875) += compass_ak8975.o
obj-$(CONFIG_MAG_HMC5883L) += compass_hmc5883l.o
obj-$(CONFIG_DISPLAY) += display_ug2864hsweg01.o
obj-$(CONFIG_LED_STRIP) += light_ws2811strip.o
obj-$(CONFIG_SONAR) += sonar_hcsr04.o
obj-$(CONFIG_BEEPER) += sound_beeper.o
obj-$(CONFIG_TRANSPONDER) += transponder_ir.o

ifdef CONFIG_CPU_STM32F10X
obj-y	+= adc_stm32f10x.o bus_i2c_stm32f10x.o gpio_stm32f10x.o \
	serial_uart_stm32f10x.o system_stm32f10x.o timer_stm32f10x.o
obj-$(CONFIG_LED_STRIP) += light_led_stm32f10x.o light_ws2811strip_stm32f10x.o
obj-$(CONFIG_BEEPER) += sound_beeper_stm32f10x.o
endif

ifdef CONFIG_CPU_STM32F30X
obj-$(CONFIG_BEEPER) += sound_beeper_stm32f30x.o
obj-$(CONFIG_TRANSPONDER) += transponder_ir_stm32f30x.o
obj-$(CONFIG_LED_STRIP) += light_led_stm32f30x.o light_ws2811strip_stm32f30x.o
obj-y	+= adc_stm32f30x.o bus_i2c_stm32f30x.o gpio_stm32f30x.o \
	serial_uart_stm32f30x.o system_stm32f30x.o timer_stm32f30x.o
endif
