Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC86E188C4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 13:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfEILMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 07:12:31 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40333 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfEILLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 07:11:33 -0400
Received: by mail-wm1-f65.google.com with SMTP id h11so2625783wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 04:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kv9Gg7wOfmL+wc19PLSZwbSNlh1m7pR6gGXghMqKj+Q=;
        b=ZSOSTbeLUM+WduaH5DIUMhdAUFskp10W/dVpZKJcgy5jCLvb5X//1FQXBf4kqQn41s
         gNi17ihaAJ8vshdbXN1DiFXQmPvEUuGS/7EJe3P2Mo6R5q3E99PmsntDrhSE0olQHw+s
         lF7T9lgxVat/P8ULcY1irobhb1DFegGLMKGRh18kh68gLXzRcdANccvn4TOVQ9eb2AiT
         Gmc/QjCNi2NVn3zYJZZvERQa14Wh4j4tMaHzmiU36t0/IMQ9Jtu6MjojDDc8sd17Cqkz
         gpWUIiSY+WTEDAP5YLbieswGyjp/fcqnK6GIZGxWr3jfl0I9KApye7laXduQryxGpvZn
         cHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kv9Gg7wOfmL+wc19PLSZwbSNlh1m7pR6gGXghMqKj+Q=;
        b=i6Yf9GefoNCXbhsHaKCxE8oZf7xVbSamEKBcFsDnSrioQeoWwoWKntmn380wNAeb5L
         pmsIM0dq/P+EKdMgwjMAX3cTLNwj/zgCA4/ZK8HBvwByCyQ/bidVeFpCWDyOSMZQSwJy
         54kOCZmDoFAurqmApY/xvvVyIiZTKSv1z5ZUE8O5n+C2wNZFQcT3E6jrNyOLPV3ZW6fG
         0aW2Zg+KjxxqqTshAPpAw4p1mHxyNLQ7YiuMBUNAlcL4Q9H0D0csCNKhnShlKEFMeGq5
         O1MZ3YqqxCDQuEYIak+rGsyppQ+PNqWGi0KJIgd4lxyokJzVfcVVrsXGX4Av5jA47NF4
         ifvg==
X-Gm-Message-State: APjAAAWgYaFyx/UTGlRD8V75CUCTpJKAiBvE35IJ5XWMQg2U5Qu4fKer
        eI9CZe9qzoeWf2Ffu6C9wcRpDQ==
X-Google-Smtp-Source: APXvYqyoTntIAacpHZLYaCz1rLZjIPXuE6640gazLE0T0vNuP1WrX0AYcYy+SWE6b4IvQDlY9r65vA==
X-Received: by 2002:a1c:9a14:: with SMTP id c20mr2585565wme.104.1557400291553;
        Thu, 09 May 2019 04:11:31 -0700 (PDT)
Received: from mai.irit.fr ([141.115.39.235])
        by smtp.gmail.com with ESMTPSA id z7sm2299778wme.26.2019.05.09.04.11.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 04:11:30 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH 04/15] clocksource/drivers/timer-milbeaut: Fix to enable one-shot timer
Date:   Thu,  9 May 2019 13:10:37 +0200
Message-Id: <20190509111048.11151-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509111048.11151-1-daniel.lezcano@linaro.org>
References: <7e786ba3-a664-8fd9-dd17-6a5be996a712@linaro.org>
 <20190509111048.11151-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sugaya Taichi <sugaya.taichi@socionext.com>

Fix mlb_set_oneshot_state() to enable one-shot timer.
The function should stop and start a timer, but "start" statement was
dropped. Kick the register to start one-shot timer.

Fixes: b58f28f306db ("clocksource/drivers/timer-milbeaut: Introduce timer for Milbeaut SoCs")
Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-milbeaut.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/timer-milbeaut.c b/drivers/clocksource/timer-milbeaut.c
index f2019a88e3ee..9fd5d081fac4 100644
--- a/drivers/clocksource/timer-milbeaut.c
+++ b/drivers/clocksource/timer-milbeaut.c
@@ -79,6 +79,8 @@ static int mlb_set_state_oneshot(struct clock_event_device *clk)
 	struct timer_of *to = to_timer_of(clk);
 	u32 val = MLB_TMR_TMCSR_CSL_DIV2;
 
+	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
+	val |= MLB_TMR_TMCSR_CNTE | MLB_TMR_TMCSR_TRG | MLB_TMR_TMCSR_INTE;
 	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
 	return 0;
 }
-- 
2.17.1

