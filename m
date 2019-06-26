Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD36A56EB6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 18:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfFZQ2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 12:28:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50168 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726042AbfFZQ2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 12:28:39 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2A0A9EADBB0639188F3A;
        Thu, 27 Jun 2019 00:28:31 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Thu, 27 Jun 2019 00:28:25 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@huawei.com>
CC:     <bhelgaas@google.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <arnd@arndb.de>, <olof@lixom.net>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v3 2/6] lib: logic_pio: Avoid possible overlap for unregistering regions
Date:   Thu, 27 Jun 2019 00:26:54 +0800
Message-ID: <1561566418-22714-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1561566418-22714-1-git-send-email-john.garry@huawei.com>
References: <1561566418-22714-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code was originally written to not support unregistering logical PIO
regions.

To accommodate supporting unregistering logical PIO regions, subtly modify
LOGIC_PIO_CPU_MMIO region registration code, such that the "end" of the
registered regions is the "end" of the last region, and not the sum of
the sizes of all the registered regions.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 lib/logic_pio.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index 761296376fbc..d0165c88f705 100644
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -35,7 +35,7 @@ int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
 	struct logic_pio_hwaddr *range;
 	resource_size_t start;
 	resource_size_t end;
-	resource_size_t mmio_sz = 0;
+	resource_size_t mmio_end = 0;
 	resource_size_t iio_sz = MMIO_UPPER_LIMIT;
 	int ret = 0;
 
@@ -56,7 +56,7 @@ int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
 			/* for MMIO ranges we need to check for overlap */
 			if (start >= range->hw_start + range->size ||
 			    end < range->hw_start) {
-				mmio_sz += range->size;
+				mmio_end = range->io_start + range->size;
 			} else {
 				ret = -EFAULT;
 				goto end_register;
@@ -69,16 +69,16 @@ int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
 
 	/* range not registered yet, check for available space */
 	if (new_range->flags == LOGIC_PIO_CPU_MMIO) {
-		if (mmio_sz + new_range->size - 1 > MMIO_UPPER_LIMIT) {
+		if (mmio_end + new_range->size - 1 > MMIO_UPPER_LIMIT) {
 			/* if it's too big check if 64K space can be reserved */
-			if (mmio_sz + SZ_64K - 1 > MMIO_UPPER_LIMIT) {
+			if (mmio_end + SZ_64K - 1 > MMIO_UPPER_LIMIT) {
 				ret = -E2BIG;
 				goto end_register;
 			}
 			new_range->size = SZ_64K;
 			pr_warn("Requested IO range too big, new size set to 64K\n");
 		}
-		new_range->io_start = mmio_sz;
+		new_range->io_start = mmio_end;
 	} else if (new_range->flags == LOGIC_PIO_INDIRECT) {
 		if (iio_sz + new_range->size - 1 > IO_SPACE_LIMIT) {
 			ret = -E2BIG;
-- 
2.17.1

