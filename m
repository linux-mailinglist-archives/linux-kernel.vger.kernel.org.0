Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09C5C6987C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 17:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbfGOPnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 11:43:47 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46243 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbfGOPnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 11:43:47 -0400
Received: by mail-io1-f65.google.com with SMTP id i10so34741078iol.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 08:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ux4r2/PNo8POgrTWBBb9IwIfMsL91QvApA0a47O8zQ=;
        b=U1qTWOmNtX6PNvymsBLNcI7hc6yrlxBO4qqxO7yZStMeLK1saH667xnPH3p3Q8H3Fo
         qY/2p0TyE18U5+WG+fwMapRAZ/ULPxOhndS9KfZd1oyNwAoKnOqU5CsbZaM/FWHFZywN
         ZhhLbxF2XNtZfxeX+NqD1ODiLuqF66ek0PtiC/03BgNqIqWOmDdH3eI/D2ib3QVHwCf4
         pZ3yLIqHreKDMAwOOKLyxleDUKRpemewDRU+ycAmOuHaLdgSxZ+nH++1VibBSPqAxGwQ
         GjzG1egRLI19c0ECiqcOguG09ZfZPXX5kcQgh4PW8mXNWdW/QocunocZPd7WKLtj0G6J
         tBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ux4r2/PNo8POgrTWBBb9IwIfMsL91QvApA0a47O8zQ=;
        b=FQsKFeAXpid4mGQbgKtJgjgEzu1qd/DtGWxc1E/+108vzTClqjYRHHkwPfibM15lVx
         IelFvUH7EKXvC+jnpHtmgA001e50R/7EPHIJtxJidjIa6Xnri/j+MgVo9yegvTQOP30K
         2F0ChSlsajq97uqjBupDOEoSJXAp0DkvGu7/sOiWQSlsukVCKUwYHj9POq42aGYgsyq/
         k9RIHF+4rGEqgQtiKHA7xICG4TD7Xcx5k6alBzz08n82sCLXupWarmVXLhSjqjmV+2iA
         Gyk0GV33CzNS0It6udylXYjI/m0jDHK6SoKJzqMYJrXxg7iQ22dGf9p1rxIaHLQI1pUZ
         jp7A==
X-Gm-Message-State: APjAAAXFqTWZ26NlAxRl4BRT934WW4/Hr1XoTBmYufWrn8At3z73wLaU
        pzGcp78rKH9gkirVzGrp+WkFHG6C7pjAu+REZw==
X-Google-Smtp-Source: APXvYqzUvnC3d2mQv2FQYTr+0Qc6tfJdHOGsUKJd6KbPMqOD4BSCg93CCwy6F2lvkLet3DUSvZS5iv1emwrtu0a/Pq0=
X-Received: by 2002:a5e:a712:: with SMTP id b18mr25011425iod.220.1563205426117;
 Mon, 15 Jul 2019 08:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAKKbWA6S7KotAFtLO=ow=XYnLL2Ny5Mz2kcgM1cs+j=5mHQNmw@mail.gmail.com>
 <CAKKbWA5nwsa5kcZ8GCuC3WKJptb6RtZ65izFphd=KaALqeg+BA@mail.gmail.com>
In-Reply-To: <CAKKbWA5nwsa5kcZ8GCuC3WKJptb6RtZ65izFphd=KaALqeg+BA@mail.gmail.com>
From:   Avi Fishman <avifishman70@gmail.com>
Date:   Mon, 15 Jul 2019 18:42:58 +0300
Message-ID: <CAKKbWA5AuDRDuczTd+tonhc7hi3L=nKX5MCjbspOvAPNR9odyg@mail.gmail.com>
Subject: [PATCH] [v3] clocksource/drivers/npcm: fix GENMASK and timer operation
To:     Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Avi Fishman <avifishman70@gmail.com>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clocksource/drivers/npcm: fix GENMASK and timer operation

NPCM7XX_Tx_OPER GENMASK() changed from (27, 3) to (28, 27)
Since NPCM7XX_REG_TICR0 register reset value of those bits was 0,
it did not cause an issue

in npcm7xx_timer_oneshot() the original NPCM7XX_REG_TCSR0 register was
read again after masking it with ~NPCM7XX_Tx_OPER so the masking didn't
take effect.

npcm7xx_timer_periodic() was not wrong but it wrote to NPCM7XX_REG_TICR0
in a middle of read modify write to NPCM7XX_REG_TCSR0 which is
confusing.

Signed-off-by: Avi Fishman <avifishman70@gmail.com>
---
 drivers/clocksource/timer-npcm7xx.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/timer-npcm7xx.c
b/drivers/clocksource/timer-npcm7xx.c
index 8a30da7f083b..9780ffd8010e 100644
--- a/drivers/clocksource/timer-npcm7xx.c
+++ b/drivers/clocksource/timer-npcm7xx.c
@@ -32,7 +32,7 @@
 #define NPCM7XX_Tx_INTEN               BIT(29)
 #define NPCM7XX_Tx_COUNTEN             BIT(30)
 #define NPCM7XX_Tx_ONESHOT             0x0
-#define NPCM7XX_Tx_OPER                        GENMASK(27, 3)
+#define NPCM7XX_Tx_OPER                        GENMASK(28, 27)
 #define NPCM7XX_Tx_MIN_PRESCALE                0x1
 #define NPCM7XX_Tx_TDR_MASK_BITS       24
 #define NPCM7XX_Tx_MAX_CNT             0xFFFFFF
@@ -84,8 +84,6 @@ static int npcm7xx_timer_oneshot(struct
clock_event_device *evt)

        val = readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
        val &= ~NPCM7XX_Tx_OPER;
-
-       val = readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
        val |= NPCM7XX_START_ONESHOT_Tx;
        writel(val, timer_of_base(to) + NPCM7XX_REG_TCSR0);

@@ -97,12 +95,11 @@ static int npcm7xx_timer_periodic(struct
clock_event_device *evt)
        struct timer_of *to = to_timer_of(evt);
        u32 val;

+       writel(timer_of_period(to), timer_of_base(to) + NPCM7XX_REG_TICR0);
+
        val = readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
        val &= ~NPCM7XX_Tx_OPER;
-
-       writel(timer_of_period(to), timer_of_base(to) + NPCM7XX_REG_TICR0);
        val |= NPCM7XX_START_PERIODIC_Tx;
-
        writel(val, timer_of_base(to) + NPCM7XX_REG_TCSR0);

        return 0;

-- 
2.18.0
