Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6493B10270D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 15:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfKSOmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 09:42:02 -0500
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:41586 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727316AbfKSOl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:41:57 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D2D53C2577;
        Tue, 19 Nov 2019 14:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1574174517; bh=y/UJ6x3VYOJt5fIAD/1jTDgF9YTH0srcaXkWR4OGbd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fPtTti2LVDPM9DgKHzdr1nFE/0ZhNsu3lkSW1EvgO3qMMEaJ2jmBoYY+fZOcw3wet
         4EdJL/drirgbr5SPdnJATxMYvflcxei+311eYSEc1UqC+D4yqpKCOi/nGKgkhdq6NB
         u16RzcMaAu74XfVgGrgBi6L0/aE1I0JifzdswhnSTiI0o8P5Wx5USGSFXMu4s4BH6R
         3A8bzMEHS+c4px5RSnAnQ6d/OvzSX7T6t1HT0ObSi+yW3kRMRWeZXOr77t34lyHQGI
         aTJoi/sgyKANCULKv+0SvFWR9C2CVac6GPcWSdwoWLaDKWx6AYlA4glo4Jdv/4cjyv
         gn9EB64ZGggFw==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.76])
        by mailhost.synopsys.com (Postfix) with ESMTP id A75AEA0069;
        Tue, 19 Nov 2019 14:41:53 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     dri-devel@lists.freedesktop.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 3/4] DRM: ARC: PGU: replace unsupported by HW RGB888 format by XRGB888
Date:   Tue, 19 Nov 2019 17:41:46 +0300
Message-Id: <20191119144147.8022-4-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191119144147.8022-1-Eugeniy.Paltsev@synopsys.com>
References: <20191119144147.8022-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARC PGU doesn't support RGB888 (24 bit) format but supports
XRGB888 (32 bit) format. Fix incorrect format list in a driver.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 drivers/gpu/drm/arc/arcpgu_crtc.c | 6 +++---
 drivers/gpu/drm/arc/arcpgu_regs.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/arc/arcpgu_crtc.c b/drivers/gpu/drm/arc/arcpgu_crtc.c
index 5473b19a52ee..980e00180e6f 100644
--- a/drivers/gpu/drm/arc/arcpgu_crtc.c
+++ b/drivers/gpu/drm/arc/arcpgu_crtc.c
@@ -22,7 +22,7 @@
 
 static const u32 arc_pgu_supported_formats[] = {
 	DRM_FORMAT_RGB565,
-	DRM_FORMAT_RGB888,
+	DRM_FORMAT_XRGB8888,
 };
 
 static void arc_pgu_set_pxl_fmt(struct drm_crtc *crtc)
@@ -44,9 +44,9 @@ static void arc_pgu_set_pxl_fmt(struct drm_crtc *crtc)
 
 	reg_ctrl = arc_pgu_read(arcpgu, ARCPGU_REG_CTRL);
 	if (format == DRM_FORMAT_RGB565)
-		reg_ctrl &= ~ARCPGU_MODE_RGB888_MASK;
+		reg_ctrl &= ~ARCPGU_MODE_XRGB8888;
 	else
-		reg_ctrl |= ARCPGU_MODE_RGB888_MASK;
+		reg_ctrl |= ARCPGU_MODE_XRGB8888;
 	arc_pgu_write(arcpgu, ARCPGU_REG_CTRL, reg_ctrl);
 }
 
diff --git a/drivers/gpu/drm/arc/arcpgu_regs.h b/drivers/gpu/drm/arc/arcpgu_regs.h
index dab2c380f7f3..b689a382d556 100644
--- a/drivers/gpu/drm/arc/arcpgu_regs.h
+++ b/drivers/gpu/drm/arc/arcpgu_regs.h
@@ -25,7 +25,7 @@
 #define ARCPGU_CTRL_VS_POL_OFST	0x3
 #define ARCPGU_CTRL_HS_POL_MASK	0x1
 #define ARCPGU_CTRL_HS_POL_OFST	0x4
-#define ARCPGU_MODE_RGB888_MASK	0x04
+#define ARCPGU_MODE_XRGB8888	BIT(2)
 #define ARCPGU_STAT_BUSY_MASK	0x02
 
 #endif
-- 
2.21.0

