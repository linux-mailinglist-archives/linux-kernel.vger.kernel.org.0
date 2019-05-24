Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 108AD29072
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 07:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731893AbfEXFlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 01:41:21 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:61724 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfEXFlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 01:41:21 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x4O5eDEB025409;
        Fri, 24 May 2019 14:40:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x4O5eDEB025409
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1558676415;
        bh=iN9az4yLq8H8s7g0mKC1/aWat7k8YMfbSGrf+YN/OP8=;
        h=From:To:Cc:Subject:Date:From;
        b=2jZOEwPt/oMl8dLaQxV1S+FMPlz/CpP9UQrNnUt8ovtrQgf0dAAhr3X5W5D6lVNeW
         Yu+JH/F/59av5IGQ0yP3Kk0BupUuthgNiwjhlyyXKJ73U2G4uF9FbtDt+rlorZ11BJ
         fbdRw0L5nht8Yk2uSDtIjDXZ+Tuq0Vy3J/i5+emzxRsavL4th0VEp3eakmKBsODkoQ
         R7273/Kda8aOtU4xZfO0zHnaN/WCZsPf1qwp8+SypnyLdarmQqhrfW/O0gcN4mjZ2u
         smH7NhM9o7DQLdWPl2NahHOrnOfjU5gEdmx/rWpPntDPgQv30z3eZJalTBpPocjXZ3
         L0aNnVoX0q8zQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] clocksource: arc_timer: use BIT() instead of _BITUL()
Date:   Fri, 24 May 2019 14:40:10 +0900
Message-Id: <20190524054010.19323-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is in-kernel C code, so there is no reason to use _BITUL().
Replace it with equivalent BIT().

I added #include <linux/bits.h> explicitly although it has been included
by other headers eventually.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/clocksource/arc_timer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/arc_timer.c b/drivers/clocksource/arc_timer.c
index b28970ca4a7a..b1f21bf3b83c 100644
--- a/drivers/clocksource/arc_timer.c
+++ b/drivers/clocksource/arc_timer.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/interrupt.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clocksource.h>
@@ -142,7 +143,7 @@ static u64 arc_read_rtc(struct clocksource *cs)
 		l = read_aux_reg(AUX_RTC_LOW);
 		h = read_aux_reg(AUX_RTC_HIGH);
 		status = read_aux_reg(AUX_RTC_CTRL);
-	} while (!(status & _BITUL(31)));
+	} while (!(status & BIT(31)));
 
 	return (((u64)h) << 32) | l;
 }
-- 
2.17.1

