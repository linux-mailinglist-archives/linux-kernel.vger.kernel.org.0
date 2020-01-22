Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30E68144CA8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 08:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgAVHxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 02:53:08 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:57488 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726083AbgAVHxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 02:53:08 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AD14DC6E8B170EEAAC4C;
        Wed, 22 Jan 2020 15:53:05 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Wed, 22 Jan 2020 15:52:57 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     David Howells <dhowells@redhat.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next v2] watch_queue: fix error return code in watch_queue_set_size()
Date:   Wed, 22 Jan 2020 07:48:07 +0000
Message-ID: <20200122074807.10849-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200120085411.116252-1-weiyongjun1@huawei.com>
References: <20200120085411.116252-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return negative error code -ENOMEM from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: 009b0aa00c5a ("pipe: Add general notification queue support")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 kernel/watch_queue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index f195cbbbb3d3..f1028761cb9c 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -251,6 +251,7 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 	if (ret < 0)
 		goto error;
 
+	ret = -ENOMEM;
 	pages = kcalloc(sizeof(struct page *), nr_pages, GFP_KERNEL);
 	if (!pages)
 		goto error;



