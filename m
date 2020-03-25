Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC9D51926EC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 12:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgCYLNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 07:13:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgCYLNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 07:13:52 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEA2B20714;
        Wed, 25 Mar 2020 11:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585134832;
        bh=BzCuAlwuxAGX3F005NMoJ1SQbjE8q7I0TQauHBZ+31o=;
        h=From:To:Cc:Subject:Date:From;
        b=YKnz9Hecl5fxuD2C7GFv4OgVyH5qObz8ssS4YRbT+X2qm4uFTkze2Xy/WOTKAIx4p
         MbacL9p1KQ5APanJBD1/IcPOu7Ub8XAddFVr6IVWbskaNV8/HkmR6cCGJGgDkaVzFe
         G5G4M+ftNeePFy0vNPDu5KMBY8SVoDgdZvQcZT4c=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] mm/mremap: Add comment explaining the untagging behaviour of mremap()
Date:   Wed, 25 Mar 2020 11:13:46 +0000
Message-Id: <20200325111347.32553-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit dcde237319e6 ("mm: Avoid creating virtual address aliases in
brk()/mmap()/mremap()") changed mremap() so that only the 'old' address
is untagged, leaving the 'new' address in the form it was passed from
userspace. This prevents the unexpected creation of aliasing virtual
mappings in userspace, but looks a bit odd when you read the code.

Add a comment justifying the untagging behaviour in mremap().

Cc: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 mm/mremap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/mremap.c b/mm/mremap.c
index af363063ea23..d28f08a36b96 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -606,6 +606,16 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	LIST_HEAD(uf_unmap_early);
 	LIST_HEAD(uf_unmap);
 
+	/*
+	 * There is a deliberate asymmetry here: we strip the pointer tag
+	 * from the old address but leave the new address alone. This is
+	 * for consistency with mmap(), where we prevent the creation of
+	 * aliasing mappings in userspace by leaving the tag bits of the
+	 * mapping address intact. A non-zero tag will cause the subsequent
+	 * range checks to reject the address as invalid.
+	 *
+	 * See Documentation/arm64/tagged-address-abi.rst for more information.
+	 */
 	addr = untagged_addr(addr);
 
 	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE))
-- 
2.25.1.696.g5e7596f4ac-goog

