Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D073209BA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 16:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfEPObv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 10:31:51 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47754 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbfEPObv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:31:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF7421715;
        Thu, 16 May 2019 07:31:50 -0700 (PDT)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B9A53F71E;
        Thu, 16 May 2019 07:31:49 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Steven Price <steven.price@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] initramfs: Don't free a non-existent initrd
Date:   Thu, 16 May 2019 15:31:25 +0100
Message-Id: <20190516143125.48948-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 54c7a8916a88 ("initramfs: free initrd memory if opening
/initrd.image fails"), the kernel has unconditionally attempted to free
the initrd even if it doesn't exist. In the non-existent case this
causes a boot-time splat if CONFIG_DEBUG_VIRTUAL is enabled due to a
call to virt_to_phys() with a NULL address.

Instead we should check that the initrd actually exists and only attempt
to free it if it does.

Fixes: 54c7a8916a88 ("initramfs: free initrd memory if opening /initrd.image fails")
Reported-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Steven Price <steven.price@arm.com>
---
 init/initramfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 435a428c2af1..178130fd61c2 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -669,7 +669,7 @@ static int __init populate_rootfs(void)
 	 * If the initrd region is overlapped with crashkernel reserved region,
 	 * free only memory that is not part of crashkernel region.
 	 */
-	if (!do_retain_initrd && !kexec_free_initrd())
+	if (!do_retain_initrd && initrd_start && !kexec_free_initrd())
 		free_initrd_mem(initrd_start, initrd_end);
 	initrd_start = 0;
 	initrd_end = 0;
-- 
2.20.1

