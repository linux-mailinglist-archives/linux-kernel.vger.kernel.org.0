Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3764F899FC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 11:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfHLJjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 05:39:53 -0400
Received: from inva021.nxp.com ([92.121.34.21]:57608 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727480AbfHLJjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:39:36 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 40026200638;
        Mon, 12 Aug 2019 11:39:35 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 33794200112;
        Mon, 12 Aug 2019 11:39:35 +0200 (CEST)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id DD67A205ED;
        Mon, 12 Aug 2019 11:39:34 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     andrew@lunn.ch, ruxandra.radulescu@nxp.com,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 07/10] staging: fsl-dpaa2/ethsw: remove redundant VLAN check
Date:   Mon, 12 Aug 2019 12:39:15 +0300
Message-Id: <1565602758-14434-8-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565602758-14434-1-git-send-email-ioana.ciornei@nxp.com>
References: <1565602758-14434-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ethsw_add_vlan() function is already called only when the VLAN is
not yet configured on the switch. Remove the redundant check.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
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

