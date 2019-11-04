Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12BC1EE219
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 15:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbfKDOXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 09:23:14 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52026 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbfKDOXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:23:14 -0500
Received: by mail-wm1-f67.google.com with SMTP id q70so16867448wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 06:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IHh6fuwY3ylN/KSaO/LHxSOUYpoJDg0CwXgvso5hvT8=;
        b=ibY+rbHF6z4Lp5b+pP9zccaPS6WWiB75TppTIb7c2ZOisGdb0fhUdF8j7cGz0o4er+
         dP5qBrtRUSfQ8bkQD+Go3NpQkku3cZ+OSjtDByFcqsimG22zHG5Wp3usevvm4HIvRkYJ
         ho1qT2BNanAvggF3aLlE2ItW2pzJkSq/y0yvZW0IOjVIwc0SO0NRZN7pWzSCJg0k33zL
         /Vnsu1GpVSG6WYThaWicCaBoMxuxpyVZaaW9/ISMaCbJ5YNOe6W+g0l2yoY3uE0yLd19
         P6PFFhUkgmLvaGspjmEbMLddFu22Kkk1RS8Rv9nx68wVneoLVPArW7kd9AaTNxOyL6Ni
         RPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IHh6fuwY3ylN/KSaO/LHxSOUYpoJDg0CwXgvso5hvT8=;
        b=I+lmgwb4CvPNhk73EgBytPbugpXldlhrzBRghTdzASPErdQFmjrbvroF1Hm0+guKhq
         zmaIdLmNbFrqCXwm44YAmdBlJThxrDgtnB9nUARO+mJTzGUBziZcHvLedFrErUNj3oTl
         ZDLl8dbTDV2rgZrh9Hc4fm3XmAIvHDi+RruLjpzt7HA5EALo6JZvLRitZVgP2fEdB4ky
         srBpIE/CG2KWQFyWWVQihAYlhl/U1KTU08A7cZdnAFgiPZbw2sZibNLvAtXNuHgW008M
         df5fHbDPVZ3fnIzZW52OamNj2F179RRBhXcGV2XVrJYzdzQeFX4gsRakDlqO5YarUXir
         IJ9w==
X-Gm-Message-State: APjAAAVodpXHdlvTBfJnw4BoQVepIpRkXr/L5L8cN54/zHMvWEsi6EwT
        2b3rJlcFjMOXwScRuiCm7TiMCQ==
X-Google-Smtp-Source: APXvYqxJ+0lQdw8jKRtG1S7irJjuc1QgDTXsjolo5uLw0rgPc3Q40pFmrJbOirMiB8yiE3feCU+4lQ==
X-Received: by 2002:a1c:7709:: with SMTP id t9mr16691798wmi.80.1572877392037;
        Mon, 04 Nov 2019 06:23:12 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:58da:b044:f184:d281])
        by smtp.gmail.com with ESMTPSA id l18sm21692446wrn.48.2019.11.04.06.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 06:23:11 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/5] clocksource/drivers/timer-of: Use unique device name instead of timer
Date:   Mon,  4 Nov 2019 15:22:54 +0100
Message-Id: <20191104142257.30029-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104142257.30029-1-daniel.lezcano@linaro.org>
References: <6fd4d800-b1f8-d757-458e-23742d20884c@linaro.org>
 <20191104142257.30029-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

If a hardware-specific driver does not provide a name, the timer-of core
falls back to device_node.name.  Due to generic DT node naming policies,
that name is almost always "timer", and thus doesn't identify the actual
timer used.

Fix this by using device_node.full_name instead, which includes the unit
addrees.

Example impact on /proc/timer_list:

    -Clock Event Device: timer
    +Clock Event Device: timer@fcfec400

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20191016144747.29538-3-geert+renesas@glider.be
---
 drivers/clocksource/timer-of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer-of.c
index 384394205a12..8c11bd743dd0 100644
--- a/drivers/clocksource/timer-of.c
+++ b/drivers/clocksource/timer-of.c
@@ -190,7 +190,7 @@ int __init timer_of_init(struct device_node *np, struct timer_of *to)
 	}
 
 	if (!to->clkevt.name)
-		to->clkevt.name = np->name;
+		to->clkevt.name = np->full_name;
 
 	to->np = np;
 
-- 
2.17.1

