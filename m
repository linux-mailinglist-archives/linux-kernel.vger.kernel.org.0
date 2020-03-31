Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16DA319A11E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 23:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731250AbgCaVqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 17:46:20 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50362 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730014AbgCaVqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:46:20 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 25A652970A8
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     mark.rutland@arm.com, ck.hu@mediatek.com, sboyd@kernel.org,
        ulrich.hecht+renesas@gmail.com
Cc:     matthias.bgg@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <mbrugger@suse.com>,
        linux-clk@vger.kernel.org, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 1/4] soc: mediatek: Enable mmsys driver by default if Mediatek arch is selected
Date:   Tue, 31 Mar 2020 23:46:06 +0200
Message-Id: <20200331214609.1742152-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mmsys driver supports only MT8173 device for now, but like other system
controllers is an important piece for other Mediatek devices. Actually
it depends on the mt8173 clock specific driver but that dependency is
not real as it can build without the clock driver. Instead of depends on
a specific model, make the driver depends on the generic ARCH_MEDIATEK and
enable by default so other Mediatek devices can start using it without
flood the Kconfig.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/soc/mediatek/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
index e84513318725..59a56cd790ec 100644
--- a/drivers/soc/mediatek/Kconfig
+++ b/drivers/soc/mediatek/Kconfig
@@ -46,8 +46,7 @@ config MTK_SCPSYS
 
 config MTK_MMSYS
 	bool "MediaTek MMSYS Support"
-	depends on COMMON_CLK_MT8173_MMSYS
-	default COMMON_CLK_MT8173_MMSYS
+	default ARCH_MEDIATEK
 	help
 	  Say yes here to add support for the MediaTek Multimedia
 	  Subsystem (MMSYS).
-- 
2.25.1

