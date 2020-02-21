Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B56F166FB2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 07:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgBUGiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 01:38:04 -0500
Received: from inva021.nxp.com ([92.121.34.21]:44852 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgBUGiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 01:38:04 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 064D0206BA3;
        Fri, 21 Feb 2020 07:38:02 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ED5712022C5;
        Fri, 21 Feb 2020 07:37:54 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5BB064032D;
        Fri, 21 Feb 2020 14:37:42 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        leonard.crestez@nxp.com, peng.fan@nxp.com, yuehaibing@huawei.com,
        ping.bai@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] clk: imx: pll14xx: Return error if pll type is invalid
Date:   Fri, 21 Feb 2020 14:31:56 +0800
Message-Id: <1582266716-19821-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pll type is invalid, ONLY output error message is NOT enough,
should return error immediately.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-pll14xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index 37e311e..a83bbbe 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -410,6 +410,8 @@ struct clk_hw *imx_clk_hw_pll14xx(const char *name, const char *parent_name,
 	default:
 		pr_err("%s: Unknown pll type for pll clk %s\n",
 		       __func__, name);
+		kfree(pll);
+		return ERR_PTR(-EINVAL);
 	};
 
 	pll->base = base;
-- 
2.7.4

