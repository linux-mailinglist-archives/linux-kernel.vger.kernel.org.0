Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 165921888CA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 16:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgCQPNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 11:13:22 -0400
Received: from out28-217.mail.aliyun.com ([115.124.28.217]:35288 "EHLO
        out28-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbgCQPNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 11:13:21 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2359753|-1;CH=green;DM=||false|;DS=CONTINUE|ham_system_inform|0.00824287-0.00013658-0.991621;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03291;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.H0zKH5l_1584457917;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.H0zKH5l_1584457917)
          by smtp.aliyun-inc.com(10.147.42.241);
          Tue, 17 Mar 2020 23:13:13 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, paul@crapouillou.net,
        dongsheng.qiu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: [PATCH RESEND] clk: Ingenic: Add support for TCU of X1000.
Date:   Tue, 17 Mar 2020 23:11:33 +0800
Message-Id: <1584457893-40418-3-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584457893-40418-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1584457893-40418-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

X1000 has a different TCU, since X1000 OST has been independent of TCU.
This patch is add TCU support of X1000, and prepare for later OST driver.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---
 drivers/clk/ingenic/tcu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/ingenic/tcu.c b/drivers/clk/ingenic/tcu.c
index ad7daa4..8799907 100644
--- a/drivers/clk/ingenic/tcu.c
+++ b/drivers/clk/ingenic/tcu.c
@@ -317,10 +317,17 @@ static const struct ingenic_soc_info jz4770_soc_info = {
 	.has_tcu_clk = false,
 };
 
+static const struct ingenic_soc_info x1000_soc_info = {
+	.num_channels = 8,
+	.has_ost = false, /* X1000 has OST, but it not belong TCU */
+	.has_tcu_clk = false,
+};
+
 static const struct of_device_id ingenic_tcu_of_match[] __initconst = {
 	{ .compatible = "ingenic,jz4740-tcu", .data = &jz4740_soc_info, },
 	{ .compatible = "ingenic,jz4725b-tcu", .data = &jz4725b_soc_info, },
 	{ .compatible = "ingenic,jz4770-tcu", .data = &jz4770_soc_info, },
+	{ .compatible = "ingenic,x1000-tcu", .data = &x1000_soc_info, },
 	{ /* sentinel */ }
 };
 
@@ -471,3 +478,4 @@ static void __init ingenic_tcu_init(struct device_node *np)
 CLK_OF_DECLARE_DRIVER(jz4740_cgu, "ingenic,jz4740-tcu", ingenic_tcu_init);
 CLK_OF_DECLARE_DRIVER(jz4725b_cgu, "ingenic,jz4725b-tcu", ingenic_tcu_init);
 CLK_OF_DECLARE_DRIVER(jz4770_cgu, "ingenic,jz4770-tcu", ingenic_tcu_init);
+CLK_OF_DECLARE_DRIVER(x1000_cgu, "ingenic,x1000-tcu", ingenic_tcu_init);
-- 
2.7.4

