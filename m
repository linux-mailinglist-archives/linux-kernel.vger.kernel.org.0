Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9048160D5B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 09:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgBQIch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 03:32:37 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33100 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbgBQIcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:32:36 -0500
Received: by mail-pf1-f195.google.com with SMTP id n7so8452001pfn.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 00:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QNyXncKaYuryFlTH69WlWZYPk4kAmZEfUmd5TonVcFM=;
        b=Gsd372ngP7zyebK4/CGgbTK5xouhrNYPxDq+3swGBCC0ZSYcePHQFjp3+n5hBWWXwC
         aWLvnXVIYcac0owRO8bnd7I+XHzLdoh0ve80PIU0mQdcjnmTj8h9mZRe5T1Q9IrkaAsk
         hOAWPYp0iDKpEhz1qqQwsRJmQzyQgd7bwPojIOMRp7zX7q4Yp7tWBw4TufZYAB1j9LOp
         p9E4e+xlAlnswSu2BH4Dov8tV/nQZ5cVmwCkfGjPUPTu5Yo+fuklw68b8DlYqAQ3UdLC
         hll/p8eOuGfqpSj4Sca0bR7qOM+BrDLmHVZjvsLDMEbPvUEAKgu77BRvUOjrxWnK+zLB
         RZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QNyXncKaYuryFlTH69WlWZYPk4kAmZEfUmd5TonVcFM=;
        b=crVjljg2ZGb5bJUvW6RyN5t3I+mCHUkZmbjmhFwjiJkpDndEVI8VfUDcDS8vlLgnlk
         uIFLh5v0f+iamYmK7SeJblomTrTErVaqRSooAhLm3o/QfMzjiaxY+KTR69gjixnvV8tR
         Uoo8GOf68u+kUQyRAptgtQ620OXuvJvjo+dWWWveSpzynHZC2lnTC2zHCcjW6SJOdex1
         VmvxLSY+1jUi+xL4q0RRkk49PdwQ1lURZHU6JiORZHLtKA2bVq6zxXeLdnGUJY0gnFn8
         Rivge2Pz6TyaQQvqF0po8re5/yOSajqriK8sw5PBqIY2sZJ1OklBZkWQIcLiJkRsfVeY
         2rvA==
X-Gm-Message-State: APjAAAXtBz2GFqmbtLrOQ5/JKoqK2Wyz4zN119N/5ivdjdwq2ymwRrL1
        S223214IGS82goR7Td6s7LU6uQ==
X-Google-Smtp-Source: APXvYqzwysnH2XvIMNTjcEFbE+ORuocovwK14WEoJienDNF8ZKjzY3xBRF7MpbE7yeGiBmwDUyg/ag==
X-Received: by 2002:a62:e217:: with SMTP id a23mr15644730pfi.50.1581928355848;
        Mon, 17 Feb 2020 00:32:35 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id z10sm16989319pgz.88.2020.02.17.00.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 00:32:35 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 4/8] riscv: move exception table immediately after RO_DATA
Date:   Mon, 17 Feb 2020 16:32:19 +0800
Message-Id: <20200217083223.2011-5-zong.li@sifive.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217083223.2011-1-zong.li@sifive.com>
References: <20200217083223.2011-1-zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move EXCEPTION_TABLE immediately after RO_DATA. Make it easy to set the
attribution of the sections which should be read-only at a time.
Move .sdata to indicate the start of data section with write permission.
This patch is prepared for STRICT_KERNEL_RWX support.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/kernel/vmlinux.lds.S | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 1e0193ded420..4ba8a5397e8b 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -9,6 +9,7 @@
 #include <asm/page.h>
 #include <asm/cache.h>
 #include <asm/thread_info.h>
+#include <asm/set_memory.h>
 
 OUTPUT_ARCH(riscv)
 ENTRY(_start)
@@ -52,12 +53,15 @@ SECTIONS
 	}
 
 	/* Start of data section */
-	_sdata = .;
 	RO_DATA(L1_CACHE_BYTES)
 	.srodata : {
 		*(.srodata*)
 	}
 
+	EXCEPTION_TABLE(0x10)
+
+	_sdata = .;
+
 	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
 	.sdata : {
 		__global_pointer$ = . + 0x800;
@@ -69,8 +73,6 @@ SECTIONS
 
 	BSS_SECTION(PAGE_SIZE, PAGE_SIZE, 0)
 
-	EXCEPTION_TABLE(0x10)
-
 	.rel.dyn : {
 		*(.rel.dyn*)
 	}
-- 
2.25.0

