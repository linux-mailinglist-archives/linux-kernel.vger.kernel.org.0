Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6105E73D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 16:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfGCO46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 10:56:58 -0400
Received: from inva020.nxp.com ([92.121.34.13]:54560 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfGCO4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:56:49 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E35931A0DC6;
        Wed,  3 Jul 2019 16:56:48 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D7CC61A039E;
        Wed,  3 Jul 2019 16:56:48 +0200 (CEST)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 8E30D205F0;
        Wed,  3 Jul 2019 16:56:48 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     leoyang.li@nxp.com
Cc:     laurentiu.tudor@nxp.com, Roy.Pledge@nxp.com,
        linux-kernel@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 3/3] soc: fsl: FSL_MC_DPIO selects directly FSL_GUTS
Date:   Wed,  3 Jul 2019 17:56:40 +0300
Message-Id: <1562165800-30721-4-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1562165800-30721-1-git-send-email-ioana.ciornei@nxp.com>
References: <1562165800-30721-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make FSL_MC_DPIO select directly FSL_GUTS. Without this change we could
be in a situation where both FSL_MC_DPIO and SOC_BUS are enabled but
FSL_GUTS is not.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/soc/fsl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
index b6804c04e96f..7e62c1d0aee7 100644
--- a/drivers/soc/fsl/Kconfig
+++ b/drivers/soc/fsl/Kconfig
@@ -22,7 +22,7 @@ config FSL_GUTS
 config FSL_MC_DPIO
         tristate "QorIQ DPAA2 DPIO driver"
         depends on FSL_MC_BUS
-        select SOC_BUS
+        select FSL_GUTS
         help
 	  Driver for the DPAA2 DPIO object.  A DPIO provides queue and
 	  buffer management facilities for software to interact with
-- 
1.9.1

