Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D13B188B5C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 18:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgCQRBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 13:01:02 -0400
Received: from lists.gateworks.com ([108.161.130.12]:51761 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgCQRBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:01:01 -0400
Received: from 68-189-91-139.static.snlo.ca.charter.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <tharvey@gateworks.com>)
        id 1jEFbj-00005R-CC; Tue, 17 Mar 2020 17:02:23 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Lee Jones <lee.jones@linaro.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Jones <rjones@gateworks.com>
Cc:     Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v6 0/3] Add support for the Gateworks System Controller
Date:   Tue, 17 Mar 2020 10:00:50 -0700
Message-Id: <1584464453-28200-1-git-send-email-tharvey@gateworks.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the Gateworks System Controller used on Gateworks
Laguna, Ventana, and Newport product families.

The GSC is an MSP430 I2C slave controller whose firmware embeds the following
features:
 - I/O expander (16 GPIO's emulating a PCA955x)
 - EEPROM (enumating AT24)
 - RTC (enumating DS1672)
 - HWMON
 - Interrupt controller with tamper detect, user pushbotton
 - Watchdog controller capable of full board power-cycle
 - Power Control capable of full board power-cycle

see http://trac.gateworks.com/wiki/gsc for more details
---
v6:
 - hwmon: fix size of info field
 - hwmon: improve pwm output control documentation 
 - hwmon: include unit suffix in divider and offset
 - hwmon: change subnode name to gsc-adc
 - hwmon: change to fan subnode
 - hwmon: fix voltage offset
 - dt-bindings: fix commit message typo
 - dt-bindings: drop invalid description from #interrupt-cells property
 - dt-bindings: fix adc pattern property
 - dt-bindings: add unit suffix
 - dt-bindings: replace hwmon/adc with adc/channel
 - dt-bindings: changed adc type to gw,mode 
 - dt-bindings: add unit suffix and drop ref for voltage-divider
 - dt-bindings: add unit suffix for voltage-offset
 - dt-bindings: moved fan to its own subnode with base register

v5:
 - fix checkpatch issues
 - fix dt_binding_check issues
 - address feedback from v4

v4:
 - hwmon: move to using pwm<n>_auto_point<m>_{pwm,temp} for FAN PWM
 - hwmon: remove unncessary resolution/scaling properties for ADCs
 - bindings: update to yaml Documentation
 - removed watchdog driver

v3:
 - removed unnecessary input driver
 - added wdt driver
 - bindings: encorporated feedback from mailng list
 - hwmon:
 - encoroprated feedback from mailng list
 - added support for raw ADC voltage input used in newer GSC firmware

v2:
 - change license comment block style
 - remove COMPILE_TEST
 - fixed whitespace issues
 - replaced a printk with dev_err
 - remove DEBUG
 - simplify regmap_bulk_read err check
 - remove break after returns in switch statement
 - fix fan setpoint buffer address
 - remove unnecessary parens
 - consistently use struct device *dev pointer
 - add validation for hwmon child node props
 - move parsing of of to own function
 - use strlcpy to ensure null termination
 - fix static array sizes and removed unnecessary initializers
 - dynamically allocate channels
 - fix fan input label
 - support platform data

Tim Harvey (3):
  dt-bindings: mfd: Add Gateworks System Controller bindings
  mfd: add Gateworks System Controller core driver
  hwmon: add Gateworks System Controller support

 .../devicetree/bindings/mfd/gateworks-gsc.yaml     | 172 ++++++++++
 Documentation/hwmon/gsc-hwmon.rst                  |  53 +++
 Documentation/hwmon/index.rst                      |   1 +
 MAINTAINERS                                        |  11 +
 drivers/hwmon/Kconfig                              |   9 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/gsc-hwmon.c                          | 372 +++++++++++++++++++++
 drivers/mfd/Kconfig                                |  10 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/gateworks-gsc.c                        | 292 ++++++++++++++++
 include/linux/mfd/gsc.h                            |  72 ++++
 include/linux/platform_data/gsc_hwmon.h            |  44 +++
 12 files changed, 1038 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
 create mode 100644 Documentation/hwmon/gsc-hwmon.rst
 create mode 100644 drivers/hwmon/gsc-hwmon.c
 create mode 100644 drivers/mfd/gateworks-gsc.c
 create mode 100644 include/linux/mfd/gsc.h
 create mode 100644 include/linux/platform_data/gsc_hwmon.h

-- 
2.7.4

