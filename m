Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7721899FB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 11:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfHLJjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 05:39:52 -0400
Received: from inva020.nxp.com ([92.121.34.13]:49694 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbfHLJjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:39:36 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E8C0C1A02B0;
        Mon, 12 Aug 2019 11:39:35 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DC9A41A011B;
        Mon, 12 Aug 2019 11:39:35 +0200 (CEST)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 9C832205ED;
        Mon, 12 Aug 2019 11:39:35 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     andrew@lunn.ch, ruxandra.radulescu@nxp.com,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 09/10] staging: fsl-dpaa2/ethsw: register_netdev only when ready
Date:   Mon, 12 Aug 2019 12:39:17 +0300
Message-Id: <1565602758-14434-10-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565602758-14434-1-git-send-email-ioana.ciornei@nxp.com>
References: <1565602758-14434-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register_netdev() call should be made only when ready to process any
user request on the interface. Move the call to be the last one issued
in the probe sequence.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 28da109aef5e..14a9eebf687e 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1588,23 +1588,21 @@ static int ethsw_probe_port(struct ethsw_core *ethsw, u16 port_idx)
 	port_netdev->min_mtu = ETH_MIN_MTU;
 	port_netdev->max_mtu = ETHSW_MAX_FRAME_LENGTH;
 
+	err = ethsw_port_init(port_priv, port_idx);
+	if (err)
+		goto err_port_probe;
+
 	err = register_netdev(port_netdev);
 	if (err < 0) {
 		dev_err(dev, "register_netdev error %d\n", err);
-		goto err_register_netdev;
+		goto err_port_probe;
 	}
 
 	ethsw->ports[port_idx] = port_priv;
 
-	err = ethsw_port_init(port_priv, port_idx);
-	if (err)
-		goto err_ethsw_port_init;
-
 	return 0;
 
-err_ethsw_port_init:
-	unregister_netdev(port_netdev);
-err_register_netdev:
+err_port_probe:
 	free_netdev(port_netdev);
 
 	return err;
-- 
1.9.1

