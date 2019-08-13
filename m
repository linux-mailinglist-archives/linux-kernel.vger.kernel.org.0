Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9BD8B316
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 10:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbfHMIzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 04:55:18 -0400
Received: from inva021.nxp.com ([92.121.34.21]:41534 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbfHMIyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 04:54:53 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5BCD5200778;
        Tue, 13 Aug 2019 10:54:52 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4ED60200752;
        Tue, 13 Aug 2019 10:54:52 +0200 (CEST)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 059E02060E;
        Tue, 13 Aug 2019 10:54:51 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     joe@perches.com, andrew@lunn.ch, ruxandra.radulescu@nxp.com,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v2 05/10] staging: fsl-dpaa2/ethsw: use bool when encoding learning/flooding state
Date:   Tue, 13 Aug 2019 11:54:34 +0300
Message-Id: <1565686479-32577-6-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565686479-32577-1-git-send-email-ioana.ciornei@nxp.com>
References: <1565686479-32577-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a bool instead of an u8 in ethsw_set_learning() and
ethsw_port_set_flood() to encode an binary type property.

Reported-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
 - added Reported-by tag

 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 9ade73928e60..20519af4d804 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -149,12 +149,12 @@ static int ethsw_port_add_vlan(struct ethsw_port_priv *port_priv,
 	return 0;
 }
 
-static int ethsw_set_learning(struct ethsw_core *ethsw, u8 flag)
+static int ethsw_set_learning(struct ethsw_core *ethsw, bool enable)
 {
 	enum dpsw_fdb_learning_mode learn_mode;
 	int err;
 
-	if (flag)
+	if (enable)
 		learn_mode = DPSW_FDB_LEARNING_MODE_HW;
 	else
 		learn_mode = DPSW_FDB_LEARNING_MODE_DIS;
@@ -165,24 +165,24 @@ static int ethsw_set_learning(struct ethsw_core *ethsw, u8 flag)
 		dev_err(ethsw->dev, "dpsw_fdb_set_learning_mode err %d\n", err);
 		return err;
 	}
-	ethsw->learning = !!flag;
+	ethsw->learning = enable;
 
 	return 0;
 }
 
-static int ethsw_port_set_flood(struct ethsw_port_priv *port_priv, u8 flag)
+static int ethsw_port_set_flood(struct ethsw_port_priv *port_priv, bool enable)
 {
 	int err;
 
 	err = dpsw_if_set_flooding(port_priv->ethsw_data->mc_io, 0,
 				   port_priv->ethsw_data->dpsw_handle,
-				   port_priv->idx, flag);
+				   port_priv->idx, enable);
 	if (err) {
 		netdev_err(port_priv->netdev,
 			   "dpsw_if_set_flooding err %d\n", err);
 		return err;
 	}
-	port_priv->flood = !!flag;
+	port_priv->flood = enable;
 
 	return 0;
 }
-- 
1.9.1

