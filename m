Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62B94103C3D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 14:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfKTNmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 08:42:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:49692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730129AbfKTNl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:41:57 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B52D82251E;
        Wed, 20 Nov 2019 13:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257317;
        bh=s0ELTg1bHdr8W5pRC7ta+v8vIihQy7QuM3LKuIglQPI=;
        h=From:To:Cc:Subject:Date:From;
        b=TFQuk4Zpjou+M4hhvxNdfl3PQD01W5I0ATs/HPwPtndCDooFFWDpfJRVT3L8XuOC8
         lNSq576DcKPgLw5t6/fkhWEa8l8tKXrS+9QefeW7oucCaXgzxtNq2nLBxtB/28gXMd
         HLYqJ2M+uEF8MQbvVWEnfz92hJkK9r4KjexZp6VA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH] hwmon: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:41:53 +0800
Message-Id: <20191120134153.15418-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/hwmon/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 2b73d5fc7966..1dc4f1226496 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -495,10 +495,10 @@ config SENSORS_F75375S
 	  will be called f75375s.
 
 config SENSORS_MC13783_ADC
-        tristate "Freescale MC13783/MC13892 ADC"
-        depends on MFD_MC13XXX
-        help
-          Support for the A/D converter on MC13783 and MC13892 PMIC.
+	tristate "Freescale MC13783/MC13892 ADC"
+	depends on MFD_MC13XXX
+	help
+	  Support for the A/D converter on MC13783 and MC13892 PMIC.
 
 config SENSORS_FSCHMD
 	tristate "Fujitsu Siemens Computers sensor chips"
@@ -1314,10 +1314,10 @@ config SENSORS_NPCM7XX
 	imply THERMAL
 	help
 	  This driver provides support for Nuvoton NPCM750/730/715/705 PWM
-          and Fan controllers.
+	  and Fan controllers.
 
-          This driver can also be built as a module. If so, the module
-          will be called npcm750-pwm-fan.
+	  This driver can also be built as a module. If so, the module
+	  will be called npcm750-pwm-fan.
 
 config SENSORS_NSA320
 	tristate "ZyXEL NSA320 and compatible fan speed and temperature sensors"
-- 
2.17.1

