Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD768C88B0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 14:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfJBMeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 08:34:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbfJBMeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 08:34:09 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBE6D2133F;
        Wed,  2 Oct 2019 12:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570019649;
        bh=Hcr8/BgFHkH04GeUF/ksFgRmU2LHVysqMdnCjrTDy4Q=;
        h=From:To:Cc:Subject:Date:From;
        b=gx4FyY5nPBmmWoSH2Eg90I3B1GOqMzHr/VGT3TzxQrelIWIU4cTilrHD1IGeKzhDm
         pTa61pYXrgfxhup0cYM52pTHRCGZlqltDqVHjDIFi1jv7yPijWREJDaSALciCvMeqm
         03ZkuejCqo/jXpug5SnRx57DYGGO4Y6z8UQMwFXI=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux@armlinux.org.uk
Cc:     dinguyen@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        p.zabel@pengutronix.de, thor.thayer@linux.intel.com
Subject: [PATCHv2] ARM: drivers/amba: release the resource to allow for deferred probe
Date:   Wed,  2 Oct 2019 07:33:49 -0500
Message-Id: <20191002123349.23771-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit "79bdcb202a35 ARM: 8906/1: drivers/amba: add reset control to
amba bus probe", the amba bus driver needs to be deferred probe because the
reset driver is probed later. However with a deferred probe, the call to
request_resource() in the driver returns -EBUSY. The reason is the driver
has not released the resource from the previous probe attempt.

This patch fixes how we handle the condition of EPROBE_DEFER that is returned
from getting the reset controls. For this condition, the patch will jump
to err_release, which will release the resource.

Fixes: 79bdcb202a35 ("ARM: 8906/1: drivers/amba: add reset control to
amba bus probe")
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v2: release the resource when of_reset_control_array_get_optional_shared()
    returns EPROBE_DEFER
---
 drivers/amba/bus.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index f39f075abff9..1109437815eb 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -409,9 +409,12 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
 		 */
 		rstc = of_reset_control_array_get_optional_shared(dev->dev.of_node);
 		if (IS_ERR(rstc)) {
-			if (PTR_ERR(rstc) != -EPROBE_DEFER)
+			ret = PTR_ERR(rstc);
+			if (ret == -EPROBE_DEFER)
+				goto err_release;
+			else
 				dev_err(&dev->dev, "Can't get amba reset!\n");
-			return PTR_ERR(rstc);
+			return ret;
 		}
 		reset_control_deassert(rstc);
 		reset_control_put(rstc);
-- 
2.20.0

