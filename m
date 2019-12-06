Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43EBC1155F2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 17:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfLFQ5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 11:57:45 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:41079 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfLFQ5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 11:57:30 -0500
Received: by mail-qv1-f66.google.com with SMTP id b18so135850qvo.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 08:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lJzGk9L/f6bPyPgYlAcUVdIxyQcpeRxruAGEz+vTV7Y=;
        b=dTufEYSOAx36oyFkeiQICWowhaatARYQQGK1xmTuY4MNM3N3514anP760dGGD9Kxke
         Wsgxde3ZzP898bsuzCyT7aLluN5EHzCPJYTNhNYwafR8K7EnqX54YFTnAfMtWJPfrXWp
         0SgE0x8YZQ2St9+lH0dPaeTkc6/CeOzWytsFkzLpFUeNCkxPgflZfAxDO5rlIAUdldtY
         cm1C08OXbcCJKEKqBHf07dUSxlRHJqA7bMJ8Vhty9EMskaWlf1ugsieq6Y/Zdit1OHa8
         0Gdo3d/+MOAcQ+3amlrsQfHPhzbzAtZZjLTK7K5IjBrGD1+HosxnLdovMREd4Fot4YjU
         rJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lJzGk9L/f6bPyPgYlAcUVdIxyQcpeRxruAGEz+vTV7Y=;
        b=WcGL+9rgJ67pQBF8P6lq+3vA+PeozEhFN0lRxgGRXIKSc/boAgIxaxFRVjV8p7pjAL
         h4O7Ez7cF+TnzgK0jKwXXLBtOdbNsKLVfrOXiRjnhR0/9r3u+mA8QAan2AUeprshFMji
         tUqh1XwEyVnQk+v1nfZ6JM3QbXtzP0RuSLWQ9lgLUCWMdSMEUAIYkT44YySGN+/CQJYJ
         3k+9m4yi0LVM/hOUUwbEWcCh8n1M4Kb6ff1xyy35Qx4E6AzvJ3MS2EYu24/DQDZjzAWu
         FehtblqJfPW36bL9lVlE1JFywIKemekfqE8mc5BoLuNo+UO4DuegjKHAiqAWQEH0Sce0
         TPoA==
X-Gm-Message-State: APjAAAWk6svuWEYZIEjtq3bn8qajGj04ukr+WHvwfWwbvp1YzpDbjsb4
        5XW1OI5luOd419ZWSPaq2Q==
X-Google-Smtp-Source: APXvYqyxpqgLlH2Sc1APdAldDSJbnxlSTjTy508o6SrtjlJvi74yUDJf5nq/tceYzow0tQTQVkc6Dg==
X-Received: by 2002:a05:6214:2b4:: with SMTP id m20mr13584002qvv.48.1575651449623;
        Fri, 06 Dec 2019 08:57:29 -0800 (PST)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y28sm6531373qtk.65.2019.12.06.08.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 08:57:29 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/4] x86/boot: Add max_addr field in struct boot_params
Date:   Fri,  6 Dec 2019 11:57:05 -0500
Message-Id: <20191206165707.20806-3-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191206165707.20806-1-msys.mizuma@gmail.com>
References: <20191206165707.20806-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Add max_addr field in struct boot_params. max_addr shows the
maximum memory address to be reachable by memory hot-add.
max_addr is set by parsing ACPI SRAT.

Reviewed-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 Documentation/x86/zero-page.rst       | 4 ++++
 arch/x86/include/uapi/asm/bootparam.h | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/x86/zero-page.rst b/Documentation/x86/zero-page.rst
index f088f5881666..cc3938d68481 100644
--- a/Documentation/x86/zero-page.rst
+++ b/Documentation/x86/zero-page.rst
@@ -19,6 +19,7 @@ Offset/Size	Proto	Name			Meaning
 058/008		ALL	tboot_addr      	Physical address of tboot shared page
 060/010		ALL	ist_info		Intel SpeedStep (IST) BIOS support information
 						(struct ist_info)
+078/010		ALL	max_addr		The possible maximum physical memory address [1]_
 080/010		ALL	hd0_info		hd0 disk parameter, OBSOLETE!!
 090/010		ALL	hd1_info		hd1 disk parameter, OBSOLETE!!
 0A0/010		ALL	sys_desc_table		System description table (struct sys_desc_table),
@@ -43,3 +44,6 @@ Offset/Size	Proto	Name			Meaning
 						(array of struct e820_entry)
 D00/1EC		ALL	eddbuf			EDD data (array of struct edd_info)
 ===========	=====	=======================	=================================================
+
+.. [1] max_addr shows the maximum memory address to be reachable by memory
+       hot-add. max_addr is set by parsing ACPI SRAT.
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index c895df5482c5..6efad338bba9 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -158,7 +158,7 @@ struct boot_params {
 	__u64  tboot_addr;				/* 0x058 */
 	struct ist_info ist_info;			/* 0x060 */
 	__u64 acpi_rsdp_addr;				/* 0x070 */
-	__u8  _pad3[8];					/* 0x078 */
+	__u64 max_addr;					/* 0x078 */
 	__u8  hd0_info[16];	/* obsolete! */		/* 0x080 */
 	__u8  hd1_info[16];	/* obsolete! */		/* 0x090 */
 	struct sys_desc_table sys_desc_table; /* obsolete! */	/* 0x0a0 */
-- 
2.20.1

