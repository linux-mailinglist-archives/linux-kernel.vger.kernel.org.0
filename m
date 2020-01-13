Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8296A13963B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 17:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgAMQ2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 11:28:49 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:37935 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728800AbgAMQ2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:28:48 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from vadimp@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 13 Jan 2020 18:28:41 +0200
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 00DGSefW032667;
        Mon, 13 Jan 2020 18:28:41 +0200
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     andy@infradead.org, dvhart@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH platform-next v3 01/11] platform/x86: mlx-platform: Cosmetic changes
Date:   Mon, 13 Jan 2020 16:28:29 +0000
Message-Id: <20200113162839.18103-2-vadimp@mellanox.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200113162839.18103-1-vadimp@mellanox.com>
References: <20200113162839.18103-1-vadimp@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant semicolons at the end of few functions.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
v1-v2:
 Comments pointed out by Andy:
 - Move this patch to be the first in series.
---
 drivers/platform/x86/mlx-platform.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-platform.c
index 8fe51e43f1bc..565a67a65554 100644
--- a/drivers/platform/x86/mlx-platform.c
+++ b/drivers/platform/x86/mlx-platform.c
@@ -1834,7 +1834,7 @@ static int __init mlxplat_dmi_default_matched(const struct dmi_system_id *dmi)
 	mlxplat_wd_data[0] = &mlxplat_mlxcpld_wd_set_type1[0];
 
 	return 1;
-};
+}
 
 static int __init mlxplat_dmi_msn21xx_matched(const struct dmi_system_id *dmi)
 {
@@ -1853,7 +1853,7 @@ static int __init mlxplat_dmi_msn21xx_matched(const struct dmi_system_id *dmi)
 	mlxplat_wd_data[0] = &mlxplat_mlxcpld_wd_set_type1[0];
 
 	return 1;
-};
+}
 
 static int __init mlxplat_dmi_msn274x_matched(const struct dmi_system_id *dmi)
 {
@@ -1872,7 +1872,7 @@ static int __init mlxplat_dmi_msn274x_matched(const struct dmi_system_id *dmi)
 	mlxplat_wd_data[0] = &mlxplat_mlxcpld_wd_set_type1[0];
 
 	return 1;
-};
+}
 
 static int __init mlxplat_dmi_msn201x_matched(const struct dmi_system_id *dmi)
 {
@@ -1891,7 +1891,7 @@ static int __init mlxplat_dmi_msn201x_matched(const struct dmi_system_id *dmi)
 	mlxplat_wd_data[0] = &mlxplat_mlxcpld_wd_set_type1[0];
 
 	return 1;
-};
+}
 
 static int __init mlxplat_dmi_qmb7xx_matched(const struct dmi_system_id *dmi)
 {
@@ -1914,7 +1914,7 @@ static int __init mlxplat_dmi_qmb7xx_matched(const struct dmi_system_id *dmi)
 	mlxplat_regmap_config = &mlxplat_mlxcpld_regmap_config_ng;
 
 	return 1;
-};
+}
 
 static const struct dmi_system_id mlxplat_dmi_table[] __initconst = {
 	{
-- 
2.11.0

