Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A648607D5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2019 16:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfGEO1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jul 2019 10:27:44 -0400
Received: from inva021.nxp.com ([92.121.34.21]:50594 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfGEO1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 10:27:19 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E6F0A20076B;
        Fri,  5 Jul 2019 16:27:17 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DA71C20076A;
        Fri,  5 Jul 2019 16:27:17 +0200 (CEST)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 99FEA204D6;
        Fri,  5 Jul 2019 16:27:17 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     ruxandra.radulescu@nxp.com,
        Razvan Stefanescu <razvan.stefanescu@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v2 1/6] staging: fsl-dpaa2/ethsw: Fix setting port learning/flooding flags
Date:   Fri,  5 Jul 2019 17:27:11 +0300
Message-Id: <1562336836-17119-2-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1562336836-17119-1-git-send-email-ioana.ciornei@nxp.com>
References: <1562336836-17119-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Razvan Stefanescu <razvan.stefanescu@nxp.com>

ethsw_set_learning()/ethsw_set_flood() use flags parameter as an
enable/disable (1/0) indicator. Previous usage sent incorrect values.

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@nxp.com>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
 - none

 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index f73edaf6ce87..87470070c3a5 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -673,11 +673,12 @@ static int port_attr_br_flags_set(struct net_device *netdev,
 		return 0;
 
 	/* Learning is enabled per switch */
-	err = ethsw_set_learning(port_priv->ethsw_data, flags & BR_LEARNING);
+	err = ethsw_set_learning(port_priv->ethsw_data,
+				 !!(flags & BR_LEARNING));
 	if (err)
 		goto exit;
 
-	err = ethsw_port_set_flood(port_priv, flags & BR_FLOOD);
+	err = ethsw_port_set_flood(port_priv, !!(flags & BR_FLOOD));
 
 exit:
 	return err;
-- 
1.9.1

