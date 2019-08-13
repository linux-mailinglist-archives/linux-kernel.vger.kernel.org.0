Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E43D68B319
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 10:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbfHMIzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 04:55:25 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56112 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbfHMIyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 04:54:53 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 02E431A0765;
        Tue, 13 Aug 2019 10:54:52 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EAC7D1A02F4;
        Tue, 13 Aug 2019 10:54:51 +0200 (CEST)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 98D7F2060E;
        Tue, 13 Aug 2019 10:54:51 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     joe@perches.com, andrew@lunn.ch, ruxandra.radulescu@nxp.com,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v2 04/10] staging: fsl-dpaa2/ethsw: remove debug message
Date:   Tue, 13 Aug 2019 11:54:33 +0300
Message-Id: <1565686479-32577-5-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565686479-32577-1-git-send-email-ioana.ciornei@nxp.com>
References: <1565686479-32577-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since ethtool will be loud enough if the .set_link_ksettings() callback
fails, remove the debug messages which do not add additional
information.

Reported-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
 - added Reported-by tag

 drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c
index 95e9f1096999..12e33a3a1bf1 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c
@@ -91,8 +91,6 @@ static void ethsw_get_drvinfo(struct net_device *netdev,
 	struct dpsw_link_cfg cfg = {0};
 	int err = 0;
 
-	netdev_dbg(netdev, "Setting link parameters...");
-
 	/* Due to a temporary MC limitation, the DPSW port must be down
 	 * in order to be able to change link settings. Taking steps to let
 	 * the user know that.
@@ -116,11 +114,6 @@ static void ethsw_get_drvinfo(struct net_device *netdev,
 				   port_priv->ethsw_data->dpsw_handle,
 				   port_priv->idx,
 				   &cfg);
-	if (err)
-		/* ethtool will be loud enough if we return an error; no point
-		 * in putting our own error message on the console by default
-		 */
-		netdev_dbg(netdev, "ERROR %d setting link cfg", err);
 
 	return err;
 }
-- 
1.9.1

