Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92C5E188B6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 13:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfEILLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 07:11:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34418 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfEILLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 07:11:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id f7so2490497wrq.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 04:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UqB421RDZrmI+ZkHu7BcjtNVEU1ZDEYv3yb1vRTJinE=;
        b=FGNyjK32xMkhdBSlyAsZbwrfAZB8J+kCwspE8uIxSD/faC2u5BR/dh7S4oBmUfL4eu
         dtYytfPQhXcdi/oGgONY+LLd7ig76ahnAH2+cm0mFvCCfCdN5LMcUyifRvIyDUKyCFJn
         //Z4+NQ5Vr3mYU3hkdRKUKl+xCpJi5KqOfiZPic9+Q1K+skd2UcV8UWbJVnrL5q1WZ2i
         jIjNSXyf9VGDmzp4TYb/cxSDrx8pL5sN00RFyCfB4c1VmnzW04sZh7gTSaGS4m4IxjIg
         66YMxbUPhUfcsNIEu+arAHs0NfP3qeClxVkPgNSDapCxMcz2mtKWBxliZF7h0m0yVwkQ
         hWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UqB421RDZrmI+ZkHu7BcjtNVEU1ZDEYv3yb1vRTJinE=;
        b=Ltg7dArUmw7VzZ0gJW3lXUOEeb0sCwxyaaMVxc0Byek2ORVq8QOKon67CT6K/pJKDo
         NXDiXwhiYoEQUQVb+SuVid6A4NymG0d2tVvY1j4V/veneRGXQll32cKakfUX8HYt21YF
         BaplguNYp5nxlYA2q38UpGCRevUE/fsU1uCDTwFTEjlh9qOIJOSH5x4oNplX07G/fQqo
         +vhcEAFxijw9/92iq4OputY9pNgJGHAowbNJCByZ/afUu6nCQ0QHDES3N5YFeGDRswhJ
         x8Rne6PRGDHRQH+SlDdEDMMoaqX+wRYjLULsPFuaYqh1kZknvvLop3YaWIh5kb5ISsRm
         +VIw==
X-Gm-Message-State: APjAAAUGhwKGgVJ2NbcLmTuXJaX/f42kx8+1Q5SfD1WGqYAAogYV0WWK
        crmTOSnatHSb0km1R3G8WvIszw==
X-Google-Smtp-Source: APXvYqwWBNC6sjUiGkfMAQ4dNFuB5MYf06Vf/1gQLYImEOdWZ71VuN3MKOjabuWQJ7BcZTqGJat26w==
X-Received: by 2002:adf:94a5:: with SMTP id 34mr2536002wrr.275.1557400302307;
        Thu, 09 May 2019 04:11:42 -0700 (PDT)
Received: from mai.irit.fr ([141.115.39.235])
        by smtp.gmail.com with ESMTPSA id z7sm2299778wme.26.2019.05.09.04.11.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 04:11:41 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 12/15] clocksource/drivers/timer-atmel-pit: Rework Kconfig option
Date:   Thu,  9 May 2019 13:10:45 +0200
Message-Id: <20190509111048.11151-12-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509111048.11151-1-daniel.lezcano@linaro.org>
References: <7e786ba3-a664-8fd9-dd17-6a5be996a712@linaro.org>
 <20190509111048.11151-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

Allow building the PIT driver when COMPILE_TEST is enabled. Also remove its
default value so it can be disabled.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index eb1560187434..2137f672a12f 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -399,8 +399,11 @@ config ARMV7M_SYSTICK
 	  This options enables support for the ARMv7M system timer unit
 
 config ATMEL_PIT
+	bool "Atmel PIT support" if COMPILE_TEST
+	depends on HAS_IOMEM
 	select TIMER_OF if OF
-	def_bool SOC_AT91SAM9 || SOC_SAMA5
+	help
+	  Support for the Periodic Interval Timer found on Atmel SoCs.
 
 config ATMEL_ST
 	bool "Atmel ST timer support" if COMPILE_TEST
-- 
2.17.1

