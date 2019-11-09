Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86172F6028
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2019 16:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfKIP6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Nov 2019 10:58:39 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37742 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfKIP6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 10:58:39 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iTT8G-0002aK-GI; Sat, 09 Nov 2019 15:58:36 +0000
From:   Colin King <colin.king@canonical.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org
Subject: [PATCH] clocksource/drivers/davinci: fix memory leak on clockevent on error return
Date:   Sat,  9 Nov 2019 15:58:36 +0000
Message-Id: <20191109155836.223635-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In the case where request_irq fails, the return path does not kfree
clockevent and hence we have a memory leak.  Fix this by kfree'ing
clockevent before returning.

Addresses-Coverity: ("Resource leak")
Fixes: 721154f972aa ("clocksource/drivers/davinci: Add support for clockevents")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/clocksource/timer-davinci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
index 62745c962049..910d4d2f0d64 100644
--- a/drivers/clocksource/timer-davinci.c
+++ b/drivers/clocksource/timer-davinci.c
@@ -299,6 +299,7 @@ int __init davinci_timer_register(struct clk *clk,
 			 "clockevent/tim12", clockevent);
 	if (rv) {
 		pr_err("Unable to request the clockevent interrupt");
+		kfree(clockevent);
 		return rv;
 	}
 
-- 
2.20.1

