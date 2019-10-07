Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 782C1CDA17
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 03:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfJGBSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Oct 2019 21:18:16 -0400
Received: from inva020.nxp.com ([92.121.34.13]:37848 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfJGBSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 21:18:16 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3BEFB1A05E8;
        Mon,  7 Oct 2019 03:18:14 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C10E61A0009;
        Mon,  7 Oct 2019 03:18:09 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id BC8B44031E;
        Mon,  7 Oct 2019 09:18:03 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, leonard.crestez@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2] firmware: imx: Skip return value check for some special SCU firmware APIs
Date:   Mon,  7 Oct 2019 09:15:59 +0800
Message-Id: <1570410959-32563-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SCU firmware does NOT always have return value stored in message
header's function element even the API has response data, those special
APIs are defined as void function in SCU firmware, so they should be
treated as return success always.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- Use direct API check instead of calling another function to check.
	- This patch is based on https://patchwork.kernel.org/patch/11129553/
---
 drivers/firmware/imx/imx-scu.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index 869be7a..03b43b7 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -162,6 +162,7 @@ static int imx_scu_ipc_write(struct imx_sc_ipc *sc_ipc, void *msg)
  */
 int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void *msg, bool have_resp)
 {
+	uint8_t saved_svc, saved_func;
 	struct imx_sc_rpc_msg *hdr;
 	int ret;
 
@@ -171,8 +172,11 @@ int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void *msg, bool have_resp)
 	mutex_lock(&sc_ipc->lock);
 	reinit_completion(&sc_ipc->done);
 
-	if (have_resp)
+	if (have_resp) {
 		sc_ipc->msg = msg;
+		saved_svc = ((struct imx_sc_rpc_msg *)msg)->svc;
+		saved_func = ((struct imx_sc_rpc_msg *)msg)->func;
+	}
 	sc_ipc->count = 0;
 	ret = imx_scu_ipc_write(sc_ipc, msg);
 	if (ret < 0) {
@@ -191,6 +195,16 @@ int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void *msg, bool have_resp)
 		/* response status is stored in hdr->func field */
 		hdr = msg;
 		ret = hdr->func;
+		/*
+		 * Some special SCU firmware APIs do NOT have return value
+		 * in hdr->func, but they do have response data, those special
+		 * APIs are defined as void function in SCU firmware, so they
+		 * should be treated as return success always.
+		 */
+		if ((saved_svc == IMX_SC_RPC_SVC_MISC) &&
+			(saved_func == IMX_SC_MISC_FUNC_UNIQUE_ID ||
+			 saved_func == IMX_SC_MISC_FUNC_GET_BUTTON_STATUS))
+			ret = 0;
 	}
 
 out:
-- 
2.7.4

