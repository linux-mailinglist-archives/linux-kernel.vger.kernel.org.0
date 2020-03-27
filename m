Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0F3195749
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 13:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbgC0MmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 08:42:16 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37944 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbgC0MmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 08:42:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id x7so4523087pgh.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 05:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SOrOCCE4z6J1sHuFdxhVTWwdjpzsQ9adaFltG09BEVg=;
        b=Zmey7RsgY68gZWN8kn7J/bo1k0I5hL0K5gpKxpY/nsuhHSOvUn//t6VTyA4quSZuw4
         w14513DwK6CaTS3h900o86OPh57a6eL6rua/lzuOOnaitGQbO3XpDG/1B29SNo3fL/j3
         bCB5Tz4QWUYD+Jk6dD0MFC+5JdsJ1h9GKB9MkDn++uQ7HhxZr2TxfMl9DZYI3zlgQqOF
         Bzf1T7YDvBZYf9qOgWOc3eon+XSD7fwg//6qy6r/mnmvVo3g5tDDrkewZUZzqOzgDGBN
         KUMIwGPhtjQ3/wIpX+GNVYUvU0iYuotNuoAbX4xHMP59RfBeKoeQ+jAt0vqJCJfyXyp9
         CUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SOrOCCE4z6J1sHuFdxhVTWwdjpzsQ9adaFltG09BEVg=;
        b=Uix1jdPZgeKI4X0ghCgJaHM4RHdvMHmHymEoAzKoRIwLpnQDyrCc81TPolPOBVcSI9
         ND5GgF7InQhNACXOscEqPTImz/SGqQwPPb2w7JbPCrApiJzB0mTbTpT53ZlDp4od6cOu
         5VGLm3EeJhGyNl8gulYfykOkwxGywotTsmMDftkIAjlDyItaPzI0aFdIyvgJ1yVMEwj3
         OOLK5as9VmW3qaFIpkDPZpZ1+jViBBA7XhH1TBKi38PVvIL0q+97KOdS/uHew+CnRNgR
         JLnWpnHaf8ZpP9qd4zmjZ8E3P0XIYK/BCRxJR074HSee7FbXGrPXzIjXeWWTMzQS+Yfk
         YE3g==
X-Gm-Message-State: ANhLgQ1i8qTjDTZod24M84wW+JvL/Scq4y0Le+gF5KC8d/Yo3y+KKZ+B
        W0Mw/5s6kV2wLfau/bdGsps=
X-Google-Smtp-Source: ADFU+vsFUmet2yQ6YpnWSdQbIgJuXPOdUp3HDtFcl6nPspvzZdJH4Ydk8NCDgZHufjhSQ6s+Poi5fg==
X-Received: by 2002:a63:1d52:: with SMTP id d18mr13398372pgm.443.1585312934746;
        Fri, 27 Mar 2020 05:42:14 -0700 (PDT)
Received: from localhost.localdomain ([49.207.51.33])
        by smtp.gmail.com with ESMTPSA id x186sm4014317pfb.151.2020.03.27.05.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 05:42:14 -0700 (PDT)
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, SoC Team <soc@kernel.org>
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Lindgren <tony@atomide.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>
Subject: [PATCH v4 1/5] ARM: ep93xx: Replace setup_irq() by request_irq()
Date:   Fri, 27 Mar 2020 18:11:43 +0530
Message-Id: <20200327124143.3520-1-afzal.mohd.ma@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAK8P3a2sqika7=3D6Zgkz+v8HtGEc0q0+skWG8mSKuL+qSoYLw@mail.gmail.com>
References: <CAK8P3a2sqika7=3D6Zgkz+v8HtGEc0q0+skWG8mSKuL+qSoYLw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_irq() is preferred over setup_irq(). Invocations of setup_irq()
occur after memory allocators are ready.

Per tglx[1], setup_irq() existed in olden days when allocators were not
ready by the time early interrupts were initialized.

Hence replace setup_irq() by request_irq().

[1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---

v4:
 * Add received tags

v3:
 * Split out from series, also create subarch level patch as Thomas
	suggested to take it thr' respective maintainers
 * Modify string displayed in case of error as suggested by Thomas
 * Re-arrange code as required to improve readability
 * Remove irrelevant parts from commit message & improve
 
v2:
 * Replace pr_err("request_irq() on %s failed" by
           pr_err("%s: request_irq() failed"
 * Commit message massage

 arch/arm/mach-ep93xx/timer-ep93xx.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-ep93xx/timer-ep93xx.c b/arch/arm/mach-ep93xx/timer-ep93xx.c
index de998830f534..dd4b164d1831 100644
--- a/arch/arm/mach-ep93xx/timer-ep93xx.c
+++ b/arch/arm/mach-ep93xx/timer-ep93xx.c
@@ -117,15 +117,11 @@ static irqreturn_t ep93xx_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction ep93xx_timer_irq = {
-	.name		= "ep93xx timer",
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= ep93xx_timer_interrupt,
-	.dev_id		= &ep93xx_clockevent,
-};
-
 void __init ep93xx_timer_init(void)
 {
+	int irq = IRQ_EP93XX_TIMER3;
+	unsigned long flags = IRQF_TIMER | IRQF_IRQPOLL;
+
 	/* Enable and register clocksource and sched_clock on timer 4 */
 	writel(EP93XX_TIMER4_VALUE_HIGH_ENABLE,
 	       EP93XX_TIMER4_VALUE_HIGH);
@@ -136,7 +132,9 @@ void __init ep93xx_timer_init(void)
 			     EP93XX_TIMER4_RATE);
 
 	/* Set up clockevent on timer 3 */
-	setup_irq(IRQ_EP93XX_TIMER3, &ep93xx_timer_irq);
+	if (request_irq(irq, ep93xx_timer_interrupt, flags, "ep93xx timer",
+			&ep93xx_clockevent))
+		pr_err("Failed to request irq %d (ep93xx timer)\n", irq);
 	clockevents_config_and_register(&ep93xx_clockevent,
 					EP93XX_TIMER123_RATE,
 					1,
-- 
2.25.1

