Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61C715F4DE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 10:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfGDIrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 04:47:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727046AbfGDIqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:46:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 596202189E;
        Thu,  4 Jul 2019 08:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562230013;
        bh=8K68pvFL9h+6LZO5F69OG12auCpRKEuDDm/xOnAtw8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QbBP8VG1VFVUwhmefeiJXSmmlNPYPuGYP+6ovUyulJhrnbwwfRC2O/z5Id1uvRDV2
         WSf0Y75LxmhuI6ohwEJFM7Q9roaJjtkR+SgxQX/xjIbpKqLzeYvk+R05qg3ydQSSx3
         g+wG2Awi8tL6a/V+jaUI7sd4hOM9oYABWOe2depI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/11] firmware: arm_scpi: convert platform driver to use dev_groups
Date:   Thu,  4 Jul 2019 10:46:10 +0200
Message-Id: <20190704084617.3602-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190704084617.3602-1-gregkh@linuxfoundation.org>
References: <20190704084617.3602-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform drivers now have the option to have the platform core create
and remove any needed sysfs attribute files.  So take advantage of that
and do not register "by hand" a sysfs group of attributes.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/arm_scpi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 725164b83242..2774ec886d60 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -1011,10 +1011,6 @@ static int scpi_probe(struct platform_device *pdev)
 				   scpi_info->firmware_version));
 	scpi_info->scpi_ops = &scpi_ops;
 
-	ret = devm_device_add_groups(dev, versions_groups);
-	if (ret)
-		dev_err(dev, "unable to create sysfs version group\n");
-
 	return devm_of_platform_populate(dev);
 }
 
@@ -1033,6 +1029,7 @@ static struct platform_driver scpi_driver = {
 	},
 	.probe = scpi_probe,
 	.remove = scpi_remove,
+	.dev_groups = versions_groups,
 };
 module_platform_driver(scpi_driver);
 
-- 
2.22.0

