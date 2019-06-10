Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEE473B709
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 16:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403767AbfFJOOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 10:14:38 -0400
Received: from inva021.nxp.com ([92.121.34.21]:40268 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390716AbfFJOOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 10:14:33 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 12DB22007D8;
        Mon, 10 Jun 2019 16:14:32 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2A5A22001D6;
        Mon, 10 Jun 2019 16:14:27 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id CA1EC402DD;
        Mon, 10 Jun 2019 22:14:20 +0800 (SGT)
From:   daniel.baluta@nxp.com
To:     jassisinghbrar@gmail.com, o.rempel@pengutronix.de
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        aisheng.dong@nxp.com, Daniel Baluta <daniel.baluta@nxp.com>
Subject: [RFC PATCH 1/2] mailbox: imx: Clear GIEn bit at shutdown
Date:   Mon, 10 Jun 2019 22:16:08 +0800
Message-Id: <20190610141609.17559-2-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610141609.17559-1-daniel.baluta@nxp.com>
References: <20190610141609.17559-1-daniel.baluta@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

GIEn is enabled at startup for RX doorbell mailboxes so
we need to clear the bit at shutdown in order to avoid
leaving the interrupt line enabled.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 25be8bb5e371..9f74dee1a58c 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -217,8 +217,8 @@ static void imx_mu_shutdown(struct mbox_chan *chan)
 	if (cp->type == IMX_MU_TYPE_TXDB)
 		tasklet_kill(&cp->txdb_tasklet);
 
-	imx_mu_xcr_rmw(priv, 0,
-		   IMX_MU_xCR_TIEn(cp->idx) | IMX_MU_xCR_RIEn(cp->idx));
+	imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_TIEn(cp->idx) |
+		       IMX_MU_xCR_RIEn(cp->idx) | IMX_MU_xCR_GIEn(cp->idx));
 
 	free_irq(priv->irq, chan);
 }
-- 
2.17.1

