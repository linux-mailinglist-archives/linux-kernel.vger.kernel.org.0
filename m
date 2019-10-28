Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3B49E711C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 13:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389001AbfJ1MN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 08:13:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37118 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727763AbfJ1MNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:13:20 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1F608B5101211CB44221;
        Mon, 28 Oct 2019 20:13:15 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 28 Oct 2019 20:13:05 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@huawei.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <olof@lixom.net>, <bhelgaas@google.com>, <arnd@arndb.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 2/5] logic_pio: Define PIO_INDIRECT_SIZE for !CONFIG_INDIRECT_PIO
Date:   Mon, 28 Oct 2019 20:10:02 +0800
Message-ID: <1572264605-172363-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1572264605-172363-1-git-send-email-john.garry@huawei.com>
References: <1572264605-172363-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the goal of expanding the test coverage of the HiSi LPC driver to
!ARM64, define a dummy PIO_INDIRECT_SIZE for !CONFIG_INDIRECT_PIO, which
is required by the named driver.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 include/linux/logic_pio.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/logic_pio.h b/include/linux/logic_pio.h
index 88e1e6304a71..54945aa824b4 100644
--- a/include/linux/logic_pio.h
+++ b/include/linux/logic_pio.h
@@ -108,10 +108,10 @@ void logic_outsl(unsigned long addr, const void *buffer, unsigned int count);
  * area by redefining the macro below.
  */
 #define PIO_INDIRECT_SIZE 0x4000
-#define MMIO_UPPER_LIMIT (IO_SPACE_LIMIT - PIO_INDIRECT_SIZE)
 #else
-#define MMIO_UPPER_LIMIT IO_SPACE_LIMIT
+#define PIO_INDIRECT_SIZE 0
 #endif /* CONFIG_INDIRECT_PIO */
+#define MMIO_UPPER_LIMIT (IO_SPACE_LIMIT - PIO_INDIRECT_SIZE)
 
 struct logic_pio_hwaddr *find_io_range_by_fwnode(struct fwnode_handle *fwnode);
 unsigned long logic_pio_trans_hwaddr(struct fwnode_handle *fwnode,
-- 
2.17.1

