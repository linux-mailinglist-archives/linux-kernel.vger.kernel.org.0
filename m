Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB3E8E1371
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 09:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389982AbfJWHwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 03:52:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4707 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732328AbfJWHwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 03:52:38 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A8E6AC35CB118D024D9F;
        Wed, 23 Oct 2019 15:52:30 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Wed, 23 Oct 2019
 15:52:18 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <abbotti@mev.co.uk>, <hsweeten@visionengravers.com>,
        <gregkh@linuxfoundation.org>, <yuehaibing@huawei.com>
CC:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] staging: comedi: remove unused variable 'route_table_size'
Date:   Wed, 23 Oct 2019 15:52:06 +0800
Message-ID: <20191023075206.33088-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/staging/comedi/drivers/ni_routes.c:52:21: warning:
 route_table_size defined but not used [-Wunused-const-variable=]

It is never used since introduction.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/comedi/drivers/ni_routes.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/comedi/drivers/ni_routes.c b/drivers/staging/comedi/drivers/ni_routes.c
index eb61494..673d732 100644
--- a/drivers/staging/comedi/drivers/ni_routes.c
+++ b/drivers/staging/comedi/drivers/ni_routes.c
@@ -49,8 +49,6 @@
 /* Helper for accessing data. */
 #define RVi(table, src, dest)	((table)[(dest) * NI_NUM_NAMES + (src)])
 
-static const size_t route_table_size = NI_NUM_NAMES * NI_NUM_NAMES;
-
 /*
  * Find the proper route_values and ni_device_routes tables for this particular
  * device.
-- 
2.7.4


