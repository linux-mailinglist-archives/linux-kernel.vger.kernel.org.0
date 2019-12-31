Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFAD612D7E6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Dec 2019 11:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfLaK3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Dec 2019 05:29:30 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:60202 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727056AbfLaK30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 05:29:26 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from vadimp@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 31 Dec 2019 12:29:24 +0200
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id xBVATJ7b008518;
        Tue, 31 Dec 2019 12:29:23 +0200
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     andy@infradead.org, dvhart@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH platform-next v1 4/9] platform/x86: mlx-platform: Cosmetic changes
Date:   Tue, 31 Dec 2019 10:29:12 +0000
Message-Id: <20191231102917.24181-5-vadimp@mellanox.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191231102917.24181-1-vadimp@mellanox.com>
References: <20191231102917.24181-1-vadimp@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant semicolons at the end of few functions.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
 drivers/platform/x86/mlx-platform.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-platform.c
index aed6ac18074e..7e92dc52071f 100644
--- a/drivers/platform/x86/mlx-platform.c
+++ b/drivers/platform/x86/mlx-platform.c
@@ -1918,7 +1918,7 @@ static int __init mlxplat_dmi_default_matched(const struct dmi_system_id *dmi)
 	mlxplat_wd_data[0] = &mlxplat_mlxcpld_wd_set_type1[0];
 
 	return 1;
-};
+}
 
 static int __init mlxplat_dmi_msn21xx_matched(const struct dmi_system_id *dmi)
 {
@@ -1937,7 +1937,7 @@ static int __init mlxplat_dmi_msn21xx_matched(const struct dmi_system_id *dmi)
 	mlxplat_wd_data[0] = &mlxplat_mlxcpld_wd_set_type1[0];
 
 	return 1;
-};
+}
 
 static int __init mlxplat_dmi_msn274x_matched(const struct dmi_system_id *dmi)
 {
@@ -1956,7 +1956,7 @@ static int __init mlxplat_dmi_msn274x_matched(const struct dmi_system_id *dmi)
 	mlxplat_wd_data[0] = &mlxplat_mlxcpld_wd_set_type1[0];
 
 	return 1;
-};
+}
 
 static int __init mlxplat_dmi_msn201x_matched(const struct dmi_system_id *dmi)
 {
@@ -1975,7 +1975,7 @@ static int __init mlxplat_dmi_msn201x_matched(const struct dmi_system_id *dmi)
 	mlxplat_wd_data[0] = &mlxplat_mlxcpld_wd_set_type1[0];
 
 	return 1;
-};
+}
 
 static int __init mlxplat_dmi_qmb7xx_matched(const struct dmi_system_id *dmi)
 {
@@ -1998,7 +1998,7 @@ static int __init mlxplat_dmi_qmb7xx_matched(const struct dmi_system_id *dmi)
 	mlxplat_regmap_config = &mlxplat_mlxcpld_regmap_config_ng;
 
 	return 1;
-};
+}
 
 static const struct dmi_system_id mlxplat_dmi_table[] __initconst = {
 	{
-- 
2.11.0

