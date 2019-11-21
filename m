Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7C81047FB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 02:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKUBWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 20:22:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:42608 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726922AbfKUBWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 20:22:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CA899B274;
        Thu, 21 Nov 2019 01:22:29 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     mingo@kernel.org, tglx@linutronix.de, bp@alien8.de
Cc:     peterz@infradead.org, x86@kernel.org, dave@stgolabs.net,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 4/4] x86/mm, pat:  Rename pat_rbtree.c to pat_interval.c
Date:   Wed, 20 Nov 2019 17:16:01 -0800
Message-Id: <20191121011601.20611-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191121011601.20611-1-dave@stgolabs.net>
References: <20191121011601.20611-1-dave@stgolabs.net>
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

