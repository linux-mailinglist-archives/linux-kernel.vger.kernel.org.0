Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 694D5C39FD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 18:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389862AbfJAQHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 12:07:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44564 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733278AbfJAQHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:07:48 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 67E1F4656D2A73744456;
        Wed,  2 Oct 2019 00:07:45 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Wed, 2 Oct 2019 00:07:15 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@hisilicon.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>, <bhelgaas@google.com>, <olof@lixom.net>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 1/3] lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops are set at registration
Date:   Wed, 2 Oct 2019 00:04:25 +0800
Message-ID: <1569945867-82243-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1569945867-82243-1-git-send-email-john.garry@huawei.com>
References: <1569945867-82243-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the only LOGIC_PIO_INDIRECT host (hisi-lpc) now sets the ops prior
to registration, enforce this check for accessors ops at registration
instead of in the IO port accessors to simplify and marginally optimise
the code.

A slight misalignment is also tidied.

Also add myself as an author.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 lib/logic_pio.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index 905027574e5d..f511a99bb389 100644
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2017 HiSilicon Limited, All Rights Reserved.
  * Author: Gabriele Paoloni <gabriele.paoloni@huawei.com>
  * Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
+ * Author: John Garry <john.garry@huawei.com>
  */
 
 #define pr_fmt(fmt)	"LOGIC PIO: " fmt
@@ -39,7 +40,8 @@ int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
 	resource_size_t iio_sz = MMIO_UPPER_LIMIT;
 	int ret = 0;
 
-	if (!new_range || !new_range->fwnode || !new_range->size)
+	if (!new_range || !new_range->fwnode || !new_range->size ||
+	    (new_range->flags == LOGIC_PIO_INDIRECT && !new_range->ops))
 		return -EINVAL;
 
 	start = new_range->hw_start;
@@ -237,7 +239,7 @@ type logic_in##bw(unsigned long addr)					\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) { \
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
 									\
-		if (entry && entry->ops)				\
+		if (entry)						\
 			ret = entry->ops->in(entry->hostdata,		\
 					addr, sizeof(type));		\
 		else							\
@@ -253,7 +255,7 @@ void logic_out##bw(type value, unsigned long addr)			\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
 									\
-		if (entry && entry->ops)				\
+		if (entry)						\
 			entry->ops->out(entry->hostdata,		\
 					addr, value, sizeof(type));	\
 		else							\
@@ -261,7 +263,7 @@ void logic_out##bw(type value, unsigned long addr)			\
 	}								\
 }									\
 									\
-void logic_ins##bw(unsigned long addr, void *buffer,		\
+void logic_ins##bw(unsigned long addr, void *buffer,			\
 		   unsigned int count)					\
 {									\
 	if (addr < MMIO_UPPER_LIMIT) {					\
@@ -269,7 +271,7 @@ void logic_ins##bw(unsigned long addr, void *buffer,		\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
 									\
-		if (entry && entry->ops)				\
+		if (entry)						\
 			entry->ops->ins(entry->hostdata,		\
 				addr, buffer, sizeof(type), count);	\
 		else							\
@@ -286,7 +288,7 @@ void logic_outs##bw(unsigned long addr, const void *buffer,		\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
 									\
-		if (entry && entry->ops)				\
+		if (entry)						\
 			entry->ops->outs(entry->hostdata,		\
 				addr, buffer, sizeof(type), count);	\
 		else							\
-- 
2.17.1

