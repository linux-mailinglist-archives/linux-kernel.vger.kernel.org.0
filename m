Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6698FB72
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 08:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfHPGxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 02:53:02 -0400
Received: from mail.intenta.de ([178.249.25.132]:41766 "EHLO mail.intenta.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfHPGxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 02:53:02 -0400
X-Greylist: delayed 327 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Aug 2019 02:53:01 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=intenta.de; s=dkim1;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:CC:To:From:Date; bh=XGDxRJXRDAYSGkBgoHrcdJKPBcXv/0/xhS9n/WVSbHI=;
        b=vNyEnij5dWjnpCOiyaV0zqMrX6EVSo/1v2ELQ4u5e1Zkuy6LbAo0v7yKw1XMyQhk8bEoem2aNi8Yh1H5+nip7VemxX3m1iJ8+Nmba2+Dy6tw9sCj7VFv+ZzNUQM7BmOegpkJqK/aie7iAJSb7H3LPwemTxDeUsPaf0h4RNA74987eYu8ixkcl9Sk8lWpOVYKY1N5aZz1H4nKo5k2IrNIEw2Su5tn8fuInz2kir8GiI0tPR9WhyWqYQW45xyUhAnYEbsLuKXkBj5LZ1LiA5rwuLF0xeiLbmeblBDRdIRrTIuELb+L+VG4gXEvYGDlmUxy6J/BsJHnA0e2ARC5/dGB+Q==;
X-CTCH-RefID: str=0001.0A0C0202.5D565182.0082,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Date:   Fri, 16 Aug 2019 08:47:30 +0200
From:   Helmut Grohne <helmut.grohne@intenta.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] clocksource/drivers/sp804: make CONFIG_ARM_TIMER_SP804
 selectable again
Message-ID: <20190816064728.52ymq7rflmuqparz@laureti-dev>
References: <alpine.DEB.2.21.1908152227590.1908@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908152227590.1908@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: ICSMA002.intenta.de (10.10.16.48) To ICSMA002.intenta.de
 (10.10.16.48)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a dependency on CONFIG_COMPILE_TEST makes the relevant item
unselectable for practical purposes. The correct solution is to add a
dependency alternative on the relevant architecture.

Fixes: dfc82faad72520 ("clocksource/drivers/sp804: Add COMPILE_TEST to CONFIG_ARM_TIMER_SP804")
Link: https://lore.kernel.org/lkml/20190618120719.a4kgyiuljm5uivfq@laureti-dev/
Link: https://lore.kernel.org/lkml/alpine.DEB.2.21.1908152227590.1908@nanos.tec.linutronix.de/
Signed-off-by: Helmut Grohne <helmut.grohne@intenta.de>
---
 drivers/clocksource/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Hi Thomas,

On Thu, Aug 15, 2019 at 10:30:39PM +0200, Thomas Gleixner wrote:
> The obvious fix is to add
> 
>       depends on ARM || ARM64 || COMPILE_TEST
> 
> instead of reverting the whole thing. Care to do that?

Incidentally, that's what I proposed earlier as RFC. Resending that
variant now.

I also note that there are likely more instances for this pattern.
Should they be fixed in a similar way? You can find a lot using the
following incantation:

    $ git describe --tags
    v5.3-rc4
    $ git ls-files -- "*/Kconfig" | xargs git grep --cached 'bool .* if COMPILE_TEST$' -- | wc -l
    185
    $

Seems like an anti-pattern to me. It is particularly common in the
clocksource subtree.

Helmut

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 5e9317dc3d39..7081a250573b 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -393,7 +393,8 @@ config ARM_GLOBAL_TIMER
 	  This options enables support for the ARM global timer unit
 
 config ARM_TIMER_SP804
-	bool "Support for Dual Timer SP804 module" if COMPILE_TEST
+	bool "Support for Dual Timer SP804 module"
+	depends on ARM || ARM64 || COMPILE_TEST
 	depends on GENERIC_SCHED_CLOCK && CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select TIMER_OF if OF
-- 
2.11.0

