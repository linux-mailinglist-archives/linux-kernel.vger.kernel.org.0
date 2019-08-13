Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3A88B315
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 10:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfHMIzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 04:55:14 -0400
Received: from inva021.nxp.com ([92.121.34.21]:41610 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728284AbfHMIyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 04:54:54 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2B55020077B;
        Tue, 13 Aug 2019 10:54:53 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1F330200769;
        Tue, 13 Aug 2019 10:54:53 +0200 (CEST)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id C01C72060E;
        Tue, 13 Aug 2019 10:54:52 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     joe@perches.com, andrew@lunn.ch, ruxandra.radulescu@nxp.com,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v2 07/10] staging: fsl-dpaa2/ethsw: remove redundant VLAN check
Date:   Tue, 13 Aug 2019 11:54:36 +0300
Message-Id: <1565686479-32577-8-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565686479-32577-1-git-send-email-ioana.ciornei@nxp.com>
References: <1565686479-32577-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ethsw_add_vlan() function is already called only when the VLAN is
not yet configured on the switch. Remove the redundant check.

Reported-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
 - added Reported-by tag

 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 20519af4d804..b69b2b7be972 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -34,11 +34,6 @@ static int ethsw_add_vlan(struct ethsw_core *ethsw, u16 vid)
 		.fdb_id = 0,
 	};
 
-	if (ethsw->vlans[vid]) {
-		dev_err(ethsw->dev, "VLAN already configured\n");
-		return -EEXIST;
-	}
-
 	err = dpsw_vlan_add(ethsw->mc_io, 0,
 			    ethsw->dpsw_handle, vid, &vcfg);
 	if (err) {
-- 
1.9.1

