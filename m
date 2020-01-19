Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60846141DCE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jan 2020 13:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgASMl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jan 2020 07:41:57 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9199 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726778AbgASMl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 07:41:57 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2B7E7B8D7D2AF1843CC5;
        Sun, 19 Jan 2020 20:41:54 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Sun, 19 Jan 2020 20:41:44 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <keescook@chromium.org>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <chenzhou10@huawei.com>
Subject: [PATCH -next] lkdtm: remove unnecessary terminated-null assign
Date:   Sun, 19 Jan 2020 20:36:59 +0800
Message-ID: <20200119123659.29950-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scnprintf implementation of kernel guarantees that its result is
terminated with null byte if size is larger than 0. So we don't need
to set terminated-null again.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/misc/lkdtm/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index ee0d6e7..5ad2630 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -341,7 +341,6 @@ static ssize_t lkdtm_debugfs_read(struct file *f, char __user *user_buf,
 		n += scnprintf(buf + n, PAGE_SIZE - n, "%s\n",
 			      crashtypes[i].name);
 	}
-	buf[n] = '\0';
 
 	out = simple_read_from_buffer(user_buf, count, off,
 				      buf, n);
-- 
2.7.4

