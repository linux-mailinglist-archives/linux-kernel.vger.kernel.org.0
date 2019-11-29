Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93F5B10D3E4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2019 11:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfK2KXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Nov 2019 05:23:02 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59388 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfK2KXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 05:23:02 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 7EBF7292920
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org
Subject: [PATCH] platform/chrome: cros_ec_lpc: Use platform_get_irq_optional() for optional IRQs
Date:   Fri, 29 Nov 2019 11:22:54 +0100
Message-Id: <20191129102254.7910-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As platform_get_irq() now prints an error when the interrupt does not
exist, use platform_get_irq_optional() to get the IRQ which is optional
to avoid below error message during probe:

  [    5.113502] cros_ec_lpcs GOOG0004:00: IRQ index 0 not found

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/platform/chrome/cros_ec_lpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index dccf479c6625..ffdea7c347f2 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -396,7 +396,7 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 	 * Some boards do not have an IRQ allotted for cros_ec_lpc,
 	 * which makes ENXIO an expected (and safe) scenario.
 	 */
-	irq = platform_get_irq(pdev, 0);
+	irq = platform_get_irq_optional(pdev, 0);
 	if (irq > 0)
 		ec_dev->irq = irq;
 	else if (irq != -ENXIO) {
-- 
2.20.1

