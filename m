Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A25B9635D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 16:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbfHTO7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 10:59:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730582AbfHTO64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:58:56 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6FBC2339E;
        Tue, 20 Aug 2019 14:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566313136;
        bh=5au+uySpHKMUgQfB6f0HCtqCGXnnNO/toEwWtCgwQRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Elx0d63ofvknVaHHM1m3EBtPbefELcg0n3vF+T4OsO7EWe2obiob7hBXk34t8DXgX
         /deiwyMkNRRojaOHdjBUgvAmPYJsQlgR/ggamqiW/EdmVZ/NOiFZPauXKUMKL5VDar
         337mhbwmYMfLpXYOpuzq/e/sIXYbvJmJvJ9o6yMg=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
        linux@armlinux.org.uk, frowand.list@gmail.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, daniel.thompson@linaro.org,
        linus.walleij@linaro.org, manivannan.sadhasivam@linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCHv4 1/1] drivers/amba: add reset control to amba bus probe
Date:   Tue, 20 Aug 2019 09:58:34 -0500
Message-Id: <20190820145834.7301-2-dinguyen@kernel.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190820145834.7301-1-dinguyen@kernel.org>
References: <20190820145834.7301-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The primecell controller on some SoCs, i.e. SoCFPGA, is held in reset by
default. Until recently, the DMA controller was brought out of reset by the
bootloader(i.e. U-Boot). But a recent change in U-Boot, the peripherals
that are not used are held in reset and are left to Linux to bring them
out of reset.

Add a mechanism for getting the reset property and de-assert the primecell
module from reset if found. This is a not a hard fail if the reset properti
is not present in the device tree node, so the driver will continue to
probe.

Because there are different variants of the controller that may have
multiple reset signals, the code will find all reset(s) specified and
de-assert them.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v4: cleaned up indentation in loop
    fix up a few checkpatch warnings
    add Reviewed-by:
v3: add a reset_control_put()
    add error handling
v2: move reset control to bus code
    find all reset properties and de-assert them
---
 drivers/amba/bus.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 100e798a5c82..76a1cd56a1ab 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -18,6 +18,7 @@
 #include <linux/limits.h>
 #include <linux/clk/clk-conf.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 
 #include <asm/irq.h>
 
@@ -401,6 +402,26 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
 	ret = amba_get_enable_pclk(dev);
 	if (ret == 0) {
 		u32 pid, cid;
+		int count;
+		struct reset_control *rstc;
+
+		/*
+		 * Find reset control(s) of the amba bus and de-assert them.
+		 */
+		count = reset_control_get_count(&dev->dev);
+		while (count > 0) {
+			rstc = of_reset_control_get_shared_by_index(dev->dev.of_node, count - 1);
+			if (IS_ERR(rstc)) {
+				if (PTR_ERR(rstc) == -EPROBE_DEFER)
+					ret = -EPROBE_DEFER;
+				else
+					dev_err(&dev->dev, "Can't get amba reset!\n");
+				break;
+			}
+			reset_control_deassert(rstc);
+			reset_control_put(rstc);
+			count--;
+		}
 
 		/*
 		 * Read pid and cid based on size of resource
-- 
2.20.0

