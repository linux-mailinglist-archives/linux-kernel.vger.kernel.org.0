Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC20415BBD3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 10:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbgBMJkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 04:40:47 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:46304 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729440AbgBMJkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:40:47 -0500
Received: from ramsan ([84.195.182.253])
        by andre.telenet-ops.be with bizsmtp
        id 29gj220075USYZQ019gj7i; Thu, 13 Feb 2020 10:40:44 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j2AzD-0007zc-5i; Thu, 13 Feb 2020 10:40:43 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j2A0b-0006Ku-4K; Thu, 13 Feb 2020 09:38:05 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] powerpc/time: Replace <linux/clk-provider.h> by <linux/of_clk.h>
Date:   Thu, 13 Feb 2020 09:38:04 +0100
Message-Id: <20200213083804.24315-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PowerPC time code is not a clock provider, and just needs to call
of_clk_init().

Hence it can include <linux/of_clk.h> instead of <linux/clk-provider.h>.

Remove the #ifdef protecting the of_clk_init() call, as a stub is
available for the !CONFIG_COMMON_CLK case.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
v2:
  - Add Reviewed-by,
  - Remove #ifdef.
---
 arch/powerpc/kernel/time.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 1168e8b37e30696d..8ce3fa8a8c0a2d63 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -50,7 +50,7 @@
 #include <linux/irq.h>
 #include <linux/delay.h>
 #include <linux/irq_work.h>
-#include <linux/clk-provider.h>
+#include <linux/of_clk.h>
 #include <linux/suspend.h>
 #include <linux/sched/cputime.h>
 #include <linux/processor.h>
@@ -1158,9 +1158,7 @@ void __init time_init(void)
 	init_decrementer_clockevent();
 	tick_setup_hrtimer_broadcast();
 
-#ifdef CONFIG_COMMON_CLK
 	of_clk_init(NULL);
-#endif
 }
 
 /*
-- 
2.17.1

