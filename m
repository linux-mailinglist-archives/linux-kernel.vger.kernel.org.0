Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB0B78B8DA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 14:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbfHMMnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 08:43:22 -0400
Received: from inva021.nxp.com ([92.121.34.21]:51646 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728442AbfHMMnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 08:43:16 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DC04F2007A0;
        Tue, 13 Aug 2019 14:43:14 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D01F820079E;
        Tue, 13 Aug 2019 14:43:14 +0200 (CEST)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 7D2FB2060E;
        Tue, 13 Aug 2019 14:43:14 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     joe@perches.com, andrew@lunn.ch, ruxandra.radulescu@nxp.com,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v3 08/10] staging: fsl-dpaa2/ethsw: reword error message
Date:   Tue, 13 Aug 2019 15:43:05 +0300
Message-Id: <1565700187-16048-9-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565700187-16048-1-git-send-email-ioana.ciornei@nxp.com>
References: <1565700187-16048-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current state, the dpaa2-ethsw driver supports only one bridge
per DPSW object. Reword the error message so that this information is
much more clear.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
 - added Suggested-by tag
Changes in v3:
 - none

 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index b69b2b7be972..28da109aef5e 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1119,8 +1119,7 @@ static int port_bridge_join(struct net_device *netdev,
 		if (ethsw->ports[i]->bridge_dev &&
 		    (ethsw->ports[i]->bridge_dev != upper_dev)) {
 			netdev_err(netdev,
-				   "Another switch port is connected to %s\n",
-				   ethsw->ports[i]->bridge_dev->name);
+				   "Only one bridge supported per DPSW object!\n");
 			return -EINVAL;
 		}
 
-- 
1.9.1

