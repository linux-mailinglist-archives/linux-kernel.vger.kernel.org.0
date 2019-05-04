Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46625138C2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2019 12:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfEDK0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 May 2019 06:26:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:48518 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727582AbfEDK0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 06:26:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2711EAF03;
        Sat,  4 May 2019 10:26:07 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>
Date:   Sat, 04 May 2019 20:24:57 +1000
Subject: [PATCH 4/4] mmc: mtk-sd: select REGULATOR
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        thirtythreeforty@gmail.com
Message-ID: <155696549700.8632.10790498625986428152.stgit@noble.brown>
In-Reply-To: <155696540998.8632.5242582397805128125.stgit@noble.brown>
References: <155696540998.8632.5242582397805128125.stgit@noble.brown>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mtk-sd driver requires a regulator to be present, even if it is
the "fixed" regulator.  So select REGULATOR to make it hard to build
unusable configurations.

Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/mmc/host/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 9c01310a0d2e..1249cde7004d 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -941,6 +941,7 @@ config MMC_BCM2835
 config MMC_MTK
 	tristate "MediaTek SD/MMC Card Interface support"
 	depends on HAS_DMA
+	select REGULATOR
 	help
 	  This selects the MediaTek(R) Secure digital and Multimedia card Interface.
 	  If you have a machine with a integrated SD/MMC card reader, say Y or M here.


