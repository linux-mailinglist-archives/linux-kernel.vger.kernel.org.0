Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7A7480B4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 13:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfFQLbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 07:31:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45645 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfFQLbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:31:12 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hcpqv-0008OW-Ou; Mon, 17 Jun 2019 11:31:09 +0000
From:   Colin King <colin.king@canonical.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] clocksource: davinci-timer: fix memory leak of clockevent on error return
Date:   Mon, 17 Jun 2019 12:31:09 +0100
Message-Id: <20190617113109.24689-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently when the call to request_irq falls there is a memory leak of
clockevent on the error return path. Fix this by kfree'ing clockevent.

Addresses-Coverity: ("Resource leak")
Fixes: fe3b8194f274 ("clocksource: davinci-timer: add support for clockevents")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/clocksource/timer-davinci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
index a9ca02390b66..8512f12e250a 100644
--- a/drivers/clocksource/timer-davinci.c
+++ b/drivers/clocksource/timer-davinci.c
@@ -300,6 +300,7 @@ int __init davinci_timer_register(struct clk *clk,
 			 "clockevent/tim12", clockevent);
 	if (rv) {
 		pr_err("Unable to request the clockevent interrupt");
+		kfree(clockevent);
 		return rv;
 	}
 
-- 
2.20.1

