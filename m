Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED6E2103C50
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 14:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbfKTNmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 08:42:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:50538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbfKTNml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:42:41 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F99022528;
        Wed, 20 Nov 2019 13:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257360;
        bh=pdipjRi4P49KZP7Yr/wuNV4P+ANuzZPwZuqKI+VchMs=;
        h=From:To:Cc:Subject:Date:From;
        b=Zipoz+pigWmup0gqJ1GSCbCD25wEr3eBW4pwvOixhrK9XOmWQ61hVxMXJzRDHEJKL
         Oy7B2nGM3cA3vLGhnI77v8RrHN6AMxOuOwern3E1wdaAU/46RzjJZmjJlIDNx8bYul
         3bvTUQYhOe7zNX1BeFm8B5jBOQ4PLdN2hUqVdXCQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] clocksource: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:42:36 +0800
Message-Id: <20191120134236.15959-1-krzk@kernel.org>
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
 drivers/clocksource/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 5fdd76cb1768..c981ff64bc13 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -470,7 +470,7 @@ config OXNAS_RPS_TIMER
 	  This enables support for the Oxford Semiconductor OXNAS RPS timers.
 
 config SYS_SUPPORTS_SH_CMT
-        bool
+	bool
 
 config MTK_TIMER
 	bool "Mediatek timer driver" if COMPILE_TEST
@@ -490,13 +490,13 @@ config SPRD_TIMER
 	  Enables support for the Spreadtrum timer driver.
 
 config SYS_SUPPORTS_SH_MTU2
-        bool
+	bool
 
 config SYS_SUPPORTS_SH_TMU
-        bool
+	bool
 
 config SYS_SUPPORTS_EM_STI
-        bool
+	bool
 
 config CLKSRC_JCORE_PIT
 	bool "J-Core PIT timer driver" if COMPILE_TEST
@@ -591,21 +591,21 @@ config CLKSRC_PXA
 	  platforms.
 
 config H8300_TMR8
-        bool "Clockevent timer for the H8300 platform" if COMPILE_TEST
-        depends on HAS_IOMEM
+	bool "Clockevent timer for the H8300 platform" if COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables the 8 bits timer for the H8300 platform.
 
 config H8300_TMR16
-        bool "Clockevent timer for the H83069 platform" if COMPILE_TEST
-        depends on HAS_IOMEM
+	bool "Clockevent timer for the H83069 platform" if COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables the 16 bits timer for the H8300 platform with the
 	  H83069 cpu.
 
 config H8300_TPU
-        bool "Clocksource for the H8300 platform" if COMPILE_TEST
-        depends on HAS_IOMEM
+	bool "Clocksource for the H8300 platform" if COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables the clocksource for the H8300 platform with the
 	  H8S2678 cpu.
-- 
2.17.1

