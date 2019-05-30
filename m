Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC8830525
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 01:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfE3XFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 19:05:37 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44511 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfE3XFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 19:05:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id b8so11455524edm.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 16:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bEA2mYeJh1shNIcIboFF9URy4voSeyylYAUKZKzKyCc=;
        b=uIMjGKPWOclW1HWwRpjqFG7vuh+7BmMDAbLxgbO+aASJ1r4MaADqE6zXZaHYJ3IHFh
         E110AA4Ur+2oVLceRmV/Q0VnjTgRZL8qAgk/YluPZvJuvdYvp2dkfWgHST+QhiWb7sBY
         wrzd6HoXDkwu6ZNL8ONrXsVD2OpHUfet42AYkwmIHjyyqd44Mk+abhaOxTgMJozLZCnd
         AqjZKy0YgswlFKsSljYdC2mCiIqZKb5qQK4q5a7b4K3WsCBxexBCG/y5DXVCk+8kbf4Q
         XOz7tLxyyzASqTfyUkejrZogSYKWgwpCtmPjUQzTBqqA3o7GWQSJV8Cbp5aDqTVbDGYg
         WONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bEA2mYeJh1shNIcIboFF9URy4voSeyylYAUKZKzKyCc=;
        b=NSObbvptYq23ILxm4hUyNZalO0qs+Vm4lRivZb/g3Otkqui9h6V7ElvUZarnflPUk2
         3hBAFOvh0AZB9ywPNhPrqYJbYI5Cxlmq1wEpYgtY6FdlFUcQqYGB/5Z+V1/qf6nmx0iH
         r1T6NKcdBDB+HV9hbrPnnL8RZysthZyupsAvdHToe8daJaR/4RsP6BBBur7BAsAcyZvz
         dohbMashtRf72Xv2bk1KBCALkbOd17ZmLgUmGCY1BTT24Nq4PLlLEO22112+I62gj4Lr
         FZacIUoVBkzv7NDqajbMxWdoCZ6Iw5y1t5XSLrGv9PkRIszk4ft8Jv5BRR12raoqe3na
         pmvA==
X-Gm-Message-State: APjAAAVdsVP0d4QIond82ygcvbiju+Y2NDkySbd0R9f2aL+ex5K+2OZn
        kPe9365pFVVT53q0qeTsAVA=
X-Google-Smtp-Source: APXvYqxJGSRpr46y3oRaHd59PLhsy4TMgmhKM69B2vIO1cLZXB1Sqy5XBHTKzSkICe8Hh/CuI9zlEQ==
X-Received: by 2002:a17:906:b743:: with SMTP id fx3mr6151335ejb.208.1559257534866;
        Thu, 30 May 2019 16:05:34 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d22sm640338ejm.83.2019.05.30.16.05.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 16:05:34 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     marc.zyngier@arm.com, Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] arm64: Enable BCM7038_L1_IRQ for ARCH_BRCMSTB
Date:   Thu, 30 May 2019 16:05:18 -0700
Message-Id: <20190530230518.4334-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530230518.4334-1-f.fainelli@gmail.com>
References: <20190530230518.4334-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARCH_BRCMSTB makes use of the irq-bcm7038-l1.c irqchip driver, enable
it.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index c7ad684926c3..b9128f245d2a 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -66,6 +66,7 @@ config ARCH_BITMAIN
 
 config ARCH_BRCMSTB
 	bool "Broadcom Set-Top-Box SoCs"
+	select BCM7038_L1_IRQ
 	select BRCMSTB_L2_IRQ
 	select GENERIC_IRQ_CHIP
 	help
-- 
2.17.1

