Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E775D122277
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 04:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfLQDTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 22:19:24 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:58328 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725836AbfLQDTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 22:19:23 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CF0AF7CC6665C0E49E48;
        Tue, 17 Dec 2019 11:19:21 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Tue, 17 Dec 2019
 11:19:13 +0800
Subject: [PATCH v3] async: Let kfree() out of the critical area of the lock
From:   Yunfeng Ye <yeyunfeng@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <gregkh@linuxfoundation.org>, <bvanassche@acm.org>,
        <alexander.h.duyck@linux.intel.com>, <bhelgaas@google.com>,
        <sakari.ailus@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
References: <89da0082-ebad-25c0-d82f-4a2feae628e6@huawei.com>
Message-ID: <8a8b27c2-60ac-5702-02dd-7950898e0a0d@huawei.com>
Date:   Tue, 17 Dec 2019 11:18:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <89da0082-ebad-25c0-d82f-4a2feae628e6@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The async_lock is big global lock, and kfree() is not always cheap, it
will increase lock contention. it's better let kfree() outside the lock
to keep the critical area as short as possible.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
v2 -> v3:
 - move kfree() after wake_up(&async_done)

v1 -> v2:
 - update the description
 - add "Reviewed-by"

 kernel/async.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/async.c b/kernel/async.c
index 4f9c1d614016..d2ab75e8b1ab 100644
--- a/kernel/async.c
+++ b/kernel/async.c
@@ -135,14 +135,14 @@ static void async_run_entry_fn(struct work_struct *work)
 	list_del_init(&entry->domain_list);
 	list_del_init(&entry->global_list);

-	/* 3) free the entry */
-	kfree(entry);
 	atomic_dec(&entry_count);
-
 	spin_unlock_irqrestore(&async_lock, flags);

-	/* 4) wake up any waiters */
+	/* 3) wake up any waiters */
 	wake_up(&async_done);
+
+	/* 4) free the entry */
+	kfree(entry);
 }

 /**
-- 
2.7.4


