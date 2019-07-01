Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11E9558F52
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 02:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfF1Aur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 20:50:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42826 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfF1Auo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 20:50:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so2053733pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 17:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HyzOL0Pl+1y/hQEqhIjAQ6BJ3vDTfLUIBzwx5JkXRP0=;
        b=JZF2qyNhhxO1xiffbwYctT1sL2m1hRCZYB2fFeHoXvSQgLroWuOTJ3Cf6HwJXCh33r
         +xBmvSxvp4ugnVf/0ZwcdVOEuKKkRGUR1a1jnplnfKiSwysiIAGIgcfe1+tuNAotOOvv
         4Sn5qJkflpsw5AohLaUs6oWZp4nif4hpdaRl5kw/bLfF33/OQtfy5G+AN+wRyc6UT20N
         GiSRYQu4+mBaz/Fqx+uT7hfYmxZvMsJh4md4COzccf12NPu4bhWy1H9U2uYVM3401vtN
         CJ/tiO/H7APhiF8q0wkjotzPh4ZjNBHU56Z6kUOrW42apVkFUUPuXB08LbLkHKoRRhg0
         ylsQ==
X-Gm-Message-State: APjAAAVQvTJi8W3WFP1I48YiX6jvyHuNb7VYArMfCMUqE0zihIBgaoqx
        yaeYDdhnrM15le1VMwT8ZgpHZA==
X-Google-Smtp-Source: APXvYqyay7rVPVpVcsRzGh+/9SNCtJQC202Bq3sWWQElqi3PmD+sGV/yqCXTSXq2gCqbKzdKLOZO6w==
X-Received: by 2002:a63:db07:: with SMTP id e7mr2197338pgg.110.1561683043927;
        Thu, 27 Jun 2019 17:50:43 -0700 (PDT)
Received: from localhost (c-76-21-109-208.hsd1.ca.comcast.net. [76.21.109.208])
        by smtp.gmail.com with ESMTPSA id o32sm365158pje.9.2019.06.27.17.50.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 17:50:42 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
        Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>
Subject: [PATCH 13/15] fpga: dfl: afu: add STP (SignalTap) support
Date:   Thu, 27 Jun 2019 17:49:49 -0700
Message-Id: <20190628004951.6202-14-mdf@kernel.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190628004951.6202-1-mdf@kernel.org>
References: <20190628004951.6202-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wu Hao <hao.wu@intel.com>

STP (SignalTap) is one of the private features under the port for
debugging. This patch adds private feature driver support for it
to allow userspace applications to mmap related mmio region and
provide STP service.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/dfl-afu-main.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index bcf6e285a854..8241aced2d5d 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -513,6 +513,36 @@ static const struct dfl_feature_ops port_afu_ops = {
 	.uinit = port_afu_uinit,
 };
 
+static int port_stp_init(struct platform_device *pdev,
+			 struct dfl_feature *feature)
+{
+	struct resource *res = &pdev->resource[feature->resource_index];
+
+	dev_dbg(&pdev->dev, "PORT STP Init.\n");
+
+	return afu_mmio_region_add(dev_get_platdata(&pdev->dev),
+				   DFL_PORT_REGION_INDEX_STP,
+				   resource_size(res), res->start,
+				   DFL_PORT_REGION_MMAP | DFL_PORT_REGION_READ |
+				   DFL_PORT_REGION_WRITE);
+}
+
+static void port_stp_uinit(struct platform_device *pdev,
+			   struct dfl_feature *feature)
+{
+	dev_dbg(&pdev->dev, "PORT STP UInit.\n");
+}
+
+static const struct dfl_feature_id port_stp_id_table[] = {
+	{.id = PORT_FEATURE_ID_STP,},
+	{0,}
+};
+
+static const struct dfl_feature_ops port_stp_ops = {
+	.init = port_stp_init,
+	.uinit = port_stp_uinit,
+};
+
 static struct dfl_feature_driver port_feature_drvs[] = {
 	{
 		.id_table = port_hdr_id_table,
@@ -526,6 +556,10 @@ static struct dfl_feature_driver port_feature_drvs[] = {
 		.id_table = port_err_id_table,
 		.ops = &port_err_ops,
 	},
+	{
+		.id_table = port_stp_id_table,
+		.ops = &port_stp_ops,
+	},
 	{
 		.ops = NULL,
 	}
-- 
2.22.0

