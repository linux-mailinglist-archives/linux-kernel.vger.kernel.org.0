Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11CCD194677
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 19:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgCZS1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 14:27:51 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51770 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgCZS1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 14:27:51 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 89B7F297957
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] soc: mediatek: mtk-mmsys: Export ddp_dis/connect symbols
Date:   Thu, 26 Mar 2020 19:27:42 +0100
Message-Id: <20200326182742.487026-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building on arm64 with allmodconfig or CONFIG_DRM_MEDIATEK=m we see
the following error.

  ERROR: modpost: "mtk_mmsys_ddp_disconnect"
  [drivers/gpu/drm/mediatek/mediatek-drm.ko] undefined!
  ERROR: modpost: "mtk_mmsys_ddp_connect"
  [drivers/gpu/drm/mediatek/mediatek-drm.ko] undefined!

Export mtk_mmsys_ddp_connect and mtk_mmsys_ddp_disconnect symbols to be
able to be used for other modules.

Fixes: 396c3fccaf03 ("soc / drm: mediatek: Move routing control to mmsys device")
Reported-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/soc/mediatek/mtk-mmsys.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 32a92ec447c5..05e322c9c301 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -259,6 +259,7 @@ void mtk_mmsys_ddp_connect(struct device *dev,
 		writel_relaxed(reg, config_regs + addr);
 	}
 }
+EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_connect);
 
 void mtk_mmsys_ddp_disconnect(struct device *dev,
 			      enum mtk_ddp_comp_id cur,
@@ -279,6 +280,7 @@ void mtk_mmsys_ddp_disconnect(struct device *dev,
 		writel_relaxed(reg, config_regs + addr);
 	}
 }
+EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_disconnect);
 
 static int mtk_mmsys_probe(struct platform_device *pdev)
 {
-- 
2.25.1

