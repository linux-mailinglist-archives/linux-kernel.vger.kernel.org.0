Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3018C475
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 00:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfHMWql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 18:46:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:50764 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbfHMWqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 18:46:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3EBBBAD44;
        Tue, 13 Aug 2019 22:46:39 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     walken@google.com, peterz@infradead.org, akpm@linux-foundation.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 3/3] x86,mm/pat: Rename pat_rbtree.c to pat_interval.c
Date:   Tue, 13 Aug 2019 15:46:20 -0700
Message-Id: <20190813224620.31005-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190813224620.31005-1-dave@stgolabs.net>
References: <20190813224620.31005-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Considering the previous changes, this is a more proper name.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 arch/x86/mm/Makefile                         | 2 +-
 arch/x86/mm/{pat_rbtree.c => pat_interval.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/x86/mm/{pat_rbtree.c => pat_interval.c} (100%)

diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 84373dc9b341..de403df8eadc 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -23,7 +23,7 @@ CFLAGS_mem_encrypt_identity.o	:= $(nostackp)
 
 CFLAGS_fault.o := -I $(srctree)/$(src)/../include/asm/trace
 
-obj-$(CONFIG_X86_PAT)		+= pat_rbtree.o
+obj-$(CONFIG_X86_PAT)		+= pat_interval.o
 
 obj-$(CONFIG_X86_32)		+= pgtable_32.o iomap_32.o
 
diff --git a/arch/x86/mm/pat_rbtree.c b/arch/x86/mm/pat_interval.c
similarity index 100%
rename from arch/x86/mm/pat_rbtree.c
rename to arch/x86/mm/pat_interval.c
-- 
2.16.4

