Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 097E1196376
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Mar 2020 05:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgC1ECu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Mar 2020 00:02:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12208 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725372AbgC1ECt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 00:02:49 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7127A9B55272DCE6073D;
        Sat, 28 Mar 2020 12:02:43 +0800 (CST)
Received: from localhost.localdomain (10.160.196.180) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.487.0; Sat, 28 Mar
 2020 12:02:36 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     <linux-erofs@lists.ozlabs.org>, Chao Yu <yuchao0@huawei.com>
CC:     LKML <linux-kernel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>,
        "Gao Xiang" <gaoxiang25@huawei.com>
Subject: [PATCH] MAINTAINERS: erofs: update my email address
Date:   Sat, 28 Mar 2020 12:00:36 +0800
Message-ID: <20200328040036.117974-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.160.196.180]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This email address will not be available in a few days.
Update my own email address to xiang@kernel.org, which
should be available all the time.

Cc: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a0d86490c2c6..f82cc2a36fb3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6249,7 +6249,7 @@ F:	drivers/video/fbdev/s1d13xxxfb.c
 F:	include/video/s1d13xxxfb.h
 
 EROFS FILE SYSTEM
-M:	Gao Xiang <gaoxiang25@huawei.com>
+M:	Gao Xiang <xiang@kernel.org>
 M:	Chao Yu <yuchao0@huawei.com>
 L:	linux-erofs@lists.ozlabs.org
 S:	Maintained
-- 
2.17.1

