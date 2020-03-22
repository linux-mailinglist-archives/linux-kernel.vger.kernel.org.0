Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB14718E9B1
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Mar 2020 16:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgCVPe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Mar 2020 11:34:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgCVPe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 11:34:57 -0400
Received: from DESKTOP-GFFITBK.localdomain (218-161-90-76.HINET-IP.hinet.net [218.161.90.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3782920736;
        Sun, 22 Mar 2020 15:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584891296;
        bh=bFnnF2dZO5qJovO73F2Ej1VVG447VC5SqBeFPILlMsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qxoUzW1f5wpb6gvf6E4Lnfjp+mjt2q+z/bIw4lyzOe/a41T2EjD+C32SX0oAC/GQG
         3EcVAQ2xf0590fKrPlhK360bm4aYGN0/zgQ86i1aDeOl2r9eS16odHzZGEAoESnAc8
         THvT7Al1sh8PenOLjXQICQuJz2iBv0xw9uUd4C5w=
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH 4/4] MAINTAINERS: add files for Mediatek DRM drivers
Date:   Sun, 22 Mar 2020 23:34:24 +0800
Message-Id: <20200322153424.2447-5-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200322153424.2447-1-chunkuang.hu@kernel.org>
References: <20200322153424.2447-1-chunkuang.hu@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mediatek HDMI phy driver is moved from drivers/gpu/drm/mediatek to
drivers/phy/mediatek, so add the new folder to the Mediatek DRM drivers'
information.

Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 38fe2f3f7b6f..129777037538 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5612,6 +5612,7 @@ M:	Philipp Zabel <p.zabel@pengutronix.de>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 F:	drivers/gpu/drm/mediatek/
+F:	drivers/phy/mediatek/phy-mtk-hdmi*
 F:	Documentation/devicetree/bindings/display/mediatek/
 
 DRM DRIVERS FOR NVIDIA TEGRA
-- 
2.17.1

