Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02ECC8EB28
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 14:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbfHOMLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 08:11:02 -0400
Received: from mail.intenta.de ([178.249.25.132]:34744 "EHLO mail.intenta.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729900AbfHOMLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 08:11:01 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Aug 2019 08:11:01 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=intenta.de; s=dkim1;
        h=Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date; bh=tiUovoTmX8WTknD03H5cq8pLU7iviOHB1c7ypfV349k=;
        b=p4QqYh7IcmNGRSHbu88v7pbctwn1qYSGXbdB4lNq9NsKA8K73mAUVoWO+77cte5bvgJfgDShKnVt0dvqVBHr3wrDytDvkZFUMnpi0Ie+a1VtJVUo5kwjXysHD5YxCJruUIWvl8VU/yZ/WAM+VsFEJw1T1HFvVMh07cAfIVNEvmPJ4dbvwfSxWnxy/LrbieyRbvIE4c1TN3jzL4C4mv4eHjJBQajatDIqvCyRYdHGIUJ/yeZg1RYNZ1sLc3q7zqQRrTv/7DJ/zsqV3w9/ZGdxXIM6ObuVaq6tbkG07YqofEKSEF1dkMpS4HpBiptMArloRMVeiGy7tLzAJ3BN1R6VdQ==;
X-CTCH-RefID: str=0001.0A0C0202.5D554A2A.0078,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Date:   Thu, 15 Aug 2019 14:03:54 +0200
From:   Helmut Grohne <helmut.grohne@intenta.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] Revert "clocksource/drivers/sp804: Add COMPILE_TEST to
 CONFIG_ARM_TIMER_SP804"
Message-ID: <20190815120352.3sakpao2cpjl3sl2@laureti-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: ICSMA002.intenta.de (10.10.16.48) To ICSMA002.intenta.de
 (10.10.16.48)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit dfc82faad72520769ca146f857e65c23632eed5a.

The commit effectively makes ARM_TIMER_SP804 depend on COMPILE_TEST,
which makes it unselectable for practical uses.

Link: https://lore.kernel.org/lkml/20190618120719.a4kgyiuljm5uivfq@laureti-dev/
Signed-off-by: Helmut Grohne <helmut.grohne@intenta.de>
---
 drivers/clocksource/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 5e9317dc3d39..72e924374591 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -393,7 +393,7 @@ config ARM_GLOBAL_TIMER
 	  This options enables support for the ARM global timer unit
 
 config ARM_TIMER_SP804
-	bool "Support for Dual Timer SP804 module" if COMPILE_TEST
+	bool "Support for Dual Timer SP804 module"
 	depends on GENERIC_SCHED_CLOCK && CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select TIMER_OF if OF
-- 
2.11.0

