Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFB2511707E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 16:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfLIPbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 10:31:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:38610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbfLIPbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 10:31:40 -0500
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94E552068E;
        Mon,  9 Dec 2019 15:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575905500;
        bh=uBbljxlnOsISZjmm7To1ryWgpDjQAcMD05X26vwmrac=;
        h=From:To:Cc:Subject:Date:From;
        b=qJLP9NHyDdEhNvGzgfjwQxhXKeXn6lW2J5jdge6fhuHoaY4A4jizURhn5wru6lusT
         ciE9P3kW8cWrSpf54lCYbAM/S3EZGc2Ph/9cEdHzxMsaCAku0mebXaWeCKJhtabkpT
         3S76DgbQSnYZlu20VC3ClvnlesZkRI5JYL21zn/k=
From:   Mike Rapoport <rppt@kernel.org>
To:     Vineet Gupta <vgupta@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH] ARC: mm: drop stale define of __ARCH_USE_5LEVEL_HACK
Date:   Mon,  9 Dec 2019 17:31:35 +0200
Message-Id: <20191209153135.22475-1-rppt@kernel.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Commit 6aae3425aa9c ("ARC: mm: remove __ARCH_USE_5LEVEL_HACK") make ARC
paging code 5-level compliant but left behind a stale define of
__ARCH_USE_5LEVEL_HACK in arch/arc/include/asm/hugepage.h.

Remove it.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arc/include/asm/hugepage.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arc/include/asm/hugepage.h b/arch/arc/include/asm/hugepage.h
index 9a74ce71a767..30ac40fed2c5 100644
--- a/arch/arc/include/asm/hugepage.h
+++ b/arch/arc/include/asm/hugepage.h
@@ -8,7 +8,6 @@
 #define _ASM_ARC_HUGEPAGE_H
 
 #include <linux/types.h>
-#define __ARCH_USE_5LEVEL_HACK
 #include <asm-generic/pgtable-nopmd.h>
 
 static inline pte_t pmd_pte(pmd_t pmd)
-- 
2.24.0

