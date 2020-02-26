Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5537A16F679
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 05:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgBZEbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 23:31:01 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:33802 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgBZEbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 23:31:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1582691455; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XF+6O0zVwMpssxe/NPpst6+w+SnWT3lSa/N6HXCCB8k=;
        b=WnUWgdYBrn4vYJskBy79Cx5OPVeQikQfKzUQv5FN+BnWT5BuZDdb69lhL+kDvk//Rj2Rvs
        5wXw8NocFtk6X62MmZlwelkq4WYC1w/PDdQvTVcD/MZvAUjKpWcnIsKHBrnOMT9zUJBl5r
        1kiwce6oRjf1fjFdRfVEyT4B8Cir1ew=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 2/3] gpu/drm: ingenic: Switch emulated fbdev to 16bpp
Date:   Wed, 26 Feb 2020 01:30:40 -0300
Message-Id: <20200226043041.289764-2-paul@crapouillou.net>
In-Reply-To: <20200226043041.289764-1-paul@crapouillou.net>
References: <20200226043041.289764-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fbdev emulation is only ever used on Ingenic SoCs to run old SDL1
based games at 16bpp (rgb565). Recent applications generally talk to
DRM directly, and can request their favourite pixel format; so we can
make everybody happy by switching the emulated fbdev to 16bpp.

v2: No change

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
index 5493a80d7d2f..3f8cc98d41fe 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
@@ -807,7 +807,7 @@ static int ingenic_drm_probe(struct platform_device *pdev)
 		goto err_devclk_disable;
 	}
 
-	ret = drm_fbdev_generic_setup(drm, 32);
+	ret = drm_fbdev_generic_setup(drm, 16);
 	if (ret)
 		dev_warn(dev, "Unable to start fbdev emulation: %i", ret);
 
-- 
2.25.0

