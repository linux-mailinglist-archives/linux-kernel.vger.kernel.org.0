Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5B1EE5F2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 18:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbfKDRZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 12:25:46 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6146 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728322AbfKDRZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:25:35 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 842DED078D7C1634B1EF;
        Tue,  5 Nov 2019 01:25:31 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Tue, 5 Nov 2019 01:25:23 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@huawei.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <olof@lixom.net>, <bhelgaas@google.com>, <arnd@arndb.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v3 5/5] logic_pio: Build into a library
Date:   Tue, 5 Nov 2019 01:22:19 +0800
Message-ID: <1572888139-47298-6-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1572888139-47298-1-git-send-email-john.garry@huawei.com>
References: <1572888139-47298-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Object file logic_pio.o is always built.

Ideally the object file should only be built when required. This is
tricky, as that would be for archs which define PCI_IOBASE, but no common
config option exists for that.

For now, continue to always build but at least ensure the symbols are not
included in the vmlinux when not referenced.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Makefile b/lib/Makefile
index c5892807e06f..27645143d8bb 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -108,7 +108,7 @@ obj-$(CONFIG_HAS_IOMEM) += iomap_copy.o devres.o
 obj-$(CONFIG_CHECK_SIGNATURE) += check_signature.o
 obj-$(CONFIG_DEBUG_LOCKING_API_SELFTESTS) += locking-selftest.o
 
-obj-y += logic_pio.o
+lib-y += logic_pio.o
 
 obj-$(CONFIG_GENERIC_HWEIGHT) += hweight.o
 
-- 
2.17.1

