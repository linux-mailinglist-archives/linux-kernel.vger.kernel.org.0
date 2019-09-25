Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61CCEBDE53
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 14:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405792AbfIYMwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 08:52:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2782 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732452AbfIYMwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 08:52:44 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 196E799B9D28E90673AE;
        Wed, 25 Sep 2019 20:52:40 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 25 Sep 2019
 20:52:36 +0800
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        <bvanassche@acm.org>, <bhelgaas@google.com>, <dsterba@suse.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        <alexander.h.duyck@linux.intel.com>, <sakari.ailus@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] async: Let kfree() out of the critical area of the lock
Message-ID: <216356b1-38c1-8477-c4e8-03f497dd6ac8@huawei.com>
Date:   Wed, 25 Sep 2019 20:52:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not necessary to put kfree() in the critical area of the lock, so
let it out.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 kernel/async.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/async.c b/kernel/async.c
index 4f9c1d6..1de270d 100644
--- a/kernel/async.c
+++ b/kernel/async.c
@@ -135,12 +135,12 @@ static void async_run_entry_fn(struct work_struct *work)
 	list_del_init(&entry->domain_list);
 	list_del_init(&entry->global_list);

-	/* 3) free the entry */
-	kfree(entry);
 	atomic_dec(&entry_count);
-
 	spin_unlock_irqrestore(&async_lock, flags);

+	/* 3) free the entry */
+	kfree(entry);
+
 	/* 4) wake up any waiters */
 	wake_up(&async_done);
 }
-- 
2.7.4

