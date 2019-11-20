Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AACE103B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 14:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbfKTNdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 08:33:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:41340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730719AbfKTNdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:33:54 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87976219FA;
        Wed, 20 Nov 2019 13:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574256833;
        bh=I2ItxMWjRTEwYmAhHosn5S3+pzi92xqBKTYGklWPoUI=;
        h=From:To:Cc:Subject:Date:From;
        b=DXLsXb1V6t+zEdcUm0IV+EcRRH5mN6kgkgu5xpppSYvdEfjEDweqKnvvNe2Jq1PgL
         UyiNDWj3EFBVqrvpPkA5X0jWyW2Zc8pS0qkrN+NMx7QBl5WukUMYSnzLE2Q9kSWchf
         3sk5RnjK+QqRXtVk5CA8HYUnBzW9Z8m4aAOz0tQ4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] drm/rockchip: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:33:48 +0800
Message-Id: <20191120133348.6640-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/gpu/drm/rockchip/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 6f4222f8beeb..1670a5cae3c7 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -28,17 +28,17 @@ config ROCKCHIP_ANALOGIX_DP
 	  on RK3288 or RK3399 based SoC, you should select this option.
 
 config ROCKCHIP_CDN_DP
-        bool "Rockchip cdn DP"
+	bool "Rockchip cdn DP"
 	depends on EXTCON=y || (EXTCON=m && DRM_ROCKCHIP=m)
-        help
+	help
 	  This selects support for Rockchip SoC specific extensions
 	  for the cdn DP driver. If you want to enable Dp on
 	  RK3399 based SoC, you should select this
 	  option.
 
 config ROCKCHIP_DW_HDMI
-        bool "Rockchip specific extensions for Synopsys DW HDMI"
-        help
+	bool "Rockchip specific extensions for Synopsys DW HDMI"
+	help
 	  This selects support for Rockchip SoC specific extensions
 	  for the Synopsys DesignWare HDMI driver. If you want to
 	  enable HDMI on RK3288 or RK3399 based SoC, you should select
-- 
2.17.1

