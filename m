Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29F8115285C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 10:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgBEJbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 04:31:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:55882 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728078AbgBEJbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 04:31:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 523E7AAC2;
        Wed,  5 Feb 2020 09:31:53 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Corey Minyard <minyard@acm.org>
Cc:     Patrick Vo <patrick.vo@hpe.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ipmi_si: Avoid spurious errors for optional IRQs
Date:   Wed,  5 Feb 2020 10:31:46 +0100
Message-Id: <20200205093146.1352-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although the IRQ assignment in ipmi_si driver is optional,
platform_get_irq() spews error messages unnecessarily:
  ipmi_si dmi-ipmi-si.0: IRQ index 0 not found

Fix this by switching to platform_get_irq_optional().

Fixes: 7723f4c5ecdb ("driver core: platform: Add an error message to platform_get_irq*()")
Reported-and-tested-by: Patrick Vo <patrick.vo@hpe.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/char/ipmi/ipmi_si_platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_platform.c b/drivers/char/ipmi/ipmi_si_platform.c
index c78127ccbc0d..638c693e17ad 100644
--- a/drivers/char/ipmi/ipmi_si_platform.c
+++ b/drivers/char/ipmi/ipmi_si_platform.c
@@ -194,7 +194,7 @@ static int platform_ipmi_probe(struct platform_device *pdev)
 	else
 		io.slave_addr = slave_addr;
 
-	io.irq = platform_get_irq(pdev, 0);
+	io.irq = platform_get_irq_optional(pdev, 0);
 	if (io.irq > 0)
 		io.irq_setup = ipmi_std_irq_setup;
 	else
@@ -378,7 +378,7 @@ static int acpi_ipmi_probe(struct platform_device *pdev)
 		io.irq = tmp;
 		io.irq_setup = acpi_gpe_irq_setup;
 	} else {
-		int irq = platform_get_irq(pdev, 0);
+		int irq = platform_get_irq_optional(pdev, 0);
 
 		if (irq > 0) {
 			io.irq = irq;
-- 
2.16.4

