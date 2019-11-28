Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB70A10C120
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 01:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfK1AuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 19:50:10 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43646 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726984AbfK1AuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 19:50:10 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B07C85E1684CE081F3A8;
        Thu, 28 Nov 2019 08:50:07 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Thu, 28 Nov 2019 08:49:58 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <pmladek@suse.com>, <joe@perches.com>,
        <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <tj@kernel.org>, <arnd@arndb.de>,
        <sergey.senozhatsky@gmail.com>, <rostedt@goodmis.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 1/4] workqueue: Use pr_warn instead of pr_warning
Date:   Thu, 28 Nov 2019 08:47:49 +0800
Message-ID: <20191128004752.35268-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191128004752.35268-1-wangkefeng.wang@huawei.com>
References: <20191128004752.35268-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use pr_warn() instead of the remaining pr_warning() calls.

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 kernel/workqueue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index bc88fd939f4e..cfc923558e04 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4374,8 +4374,8 @@ void destroy_workqueue(struct workqueue_struct *wq)
 	for_each_pwq(pwq, wq) {
 		spin_lock_irq(&pwq->pool->lock);
 		if (WARN_ON(pwq_busy(pwq))) {
-			pr_warning("%s: %s has the following busy pwq\n",
-				   __func__, wq->name);
+			pr_warn("%s: %s has the following busy pwq\n",
+				__func__, wq->name);
 			show_pwq(pwq);
 			spin_unlock_irq(&pwq->pool->lock);
 			mutex_unlock(&wq->mutex);
-- 
2.20.1

