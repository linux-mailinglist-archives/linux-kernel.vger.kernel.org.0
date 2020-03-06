Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B60BE17B728
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 08:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgCFHEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 02:04:14 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11187 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbgCFHEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 02:04:13 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 62D92CEAAB18E70D95E6;
        Fri,  6 Mar 2020 15:04:08 +0800 (CST)
Received: from huawei.com (10.67.133.63) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Fri, 6 Mar 2020
 15:03:59 +0800
From:   Qiang Su <suqiang4@huawei.com>
To:     <gregkh@linuxfoundation.org>, <suqiang4@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <leeyou.li@huawei.com>,
        <nixiaoming@huawei.com>
Subject: [PATCH] UIO: fix up inapposite whiteplace in uio head file
Date:   Fri, 6 Mar 2020 15:03:59 +0800
Message-ID: <20200306070359.71398-1-suqiang4@huawei.com>
X-Mailer: git-send-email 2.12.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.133.63]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whitespace is used in the inapposite place,
which makes checkpatch complain.

Signed-off-by: Qiang Su <suqiang4@huawei.com>
---
 include/linux/uio_driver.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/uio_driver.h b/include/linux/uio_driver.h
index 01081c4726c0..461db05819f4 100644
--- a/include/linux/uio_driver.h
+++ b/include/linux/uio_driver.h
@@ -24,10 +24,10 @@ struct uio_map;
  * struct uio_mem - description of a UIO memory region
  * @name:		name of the memory region for identification
  * @addr:               address of the device's memory rounded to page
- * 			size (phys_addr is used since addr can be
- * 			logical, virtual, or physical & phys_addr_t
- * 			should always be large enough to handle any of
- * 			the address types)
+ *			size (phys_addr is used since addr can be
+ *			logical, virtual, or physical & phys_addr_t
+ *			should always be large enough to handle any of
+ *			the address types)
  * @offs:               offset of device memory within the page
  * @size:		size of IO (multiple of page size)
  * @memtype:		type of memory addr points to
@@ -67,16 +67,16 @@ struct uio_port {
 #define MAX_UIO_PORT_REGIONS	5
 
 struct uio_device {
-        struct module           *owner;
+	struct module           *owner;
 	struct device		dev;
-        int                     minor;
-        atomic_t                event;
-        struct fasync_struct    *async_queue;
-        wait_queue_head_t       wait;
-        struct uio_info         *info;
+	int                     minor;
+	atomic_t                event;
+	struct fasync_struct    *async_queue;
+	wait_queue_head_t       wait;
+	struct uio_info         *info;
 	struct mutex		info_lock;
-        struct kobject          *map_dir;
-        struct kobject          *portio_dir;
+	struct kobject          *map_dir;
+	struct kobject          *portio_dir;
 };
 
 /**
-- 
2.12.3

