Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A101F899FD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 11:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfHLJjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 05:39:54 -0400
Received: from inva020.nxp.com ([92.121.34.13]:49682 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727072AbfHLJjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:39:35 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DABB21A0665;
        Mon, 12 Aug 2019 11:39:34 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CE0A21A011B;
        Mon, 12 Aug 2019 11:39:34 +0200 (CEST)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 8DFD7205ED;
        Mon, 12 Aug 2019 11:39:34 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     andrew@lunn.ch, ruxandra.radulescu@nxp.com,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 06/10] staging: fsl-dpaa2/ethsw: remove unnecessary memset
Date:   Mon, 12 Aug 2019 12:39:14 +0300
Message-Id: <1565602758-14434-7-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565602758-14434-1-git-send-email-ioana.ciornei@nxp.com>
References: <1565602758-14434-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ethtool core already zeroes the memory before calling
.get_ethtool_stats() thus making the memset unnecessary. Remove it.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c
index 12e33a3a1bf1..0f9f8345e534 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c
@@ -149,9 +149,6 @@ static void ethsw_ethtool_get_stats(struct net_device *netdev,
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	int i, err;
 
-	memset(data, 0,
-	       sizeof(u64) * ETHSW_NUM_COUNTERS);
-
 	for (i = 0; i < ETHSW_NUM_COUNTERS; i++) {
 		err = dpsw_if_get_counter(port_priv->ethsw_data->mc_io, 0,
 					  port_priv->ethsw_data->dpsw_handle,
-- 
1.9.1

