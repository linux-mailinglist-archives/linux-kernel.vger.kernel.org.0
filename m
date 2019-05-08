Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09719176A9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 13:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfEHLUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 07:20:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44349 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfEHLUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 07:20:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x48BK26c978738
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 8 May 2019 04:20:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x48BK26c978738
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1557314402;
        bh=Msk4XSyxdjuxG9YJTcVec6YrqAS4iypraAZMnWjYLdk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=FCy47X379VeKtvneVX+5aBKT90oz7LMYiRQQErRqEapfilTqBE66MY7UvWoosj7k3
         zNOl9c5jCsNNnTkLdBEBeSZCNIgAgv0scU2TTqXs7tvjoA3lPBfCzEASJLXu8XHiph
         ooWXhNlp5c25GNs3dyTNg4Q/RfVtUmpaZmjlbcuzHUUCl5Eh+0GYqIy6ckeoQbyuqa
         bwAsHapCAte5cc+SZ/7+O+aQ5hXbRQrpwScYoIyWBRjgASL4i05nxSPm/8IfDhdtst
         bkI84ejZoaWGSVr+RlBpeEh6FbwjhyWzyoXE+H2bZBTrjgpms+MUig830BtV7ZOoCU
         I8ssbJxLVacnA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x48BK1pn978708;
        Wed, 8 May 2019 04:20:01 -0700
Date:   Wed, 8 May 2019 04:20:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jia Zhang <tipbot@zytor.com>
Message-ID: <tip-81d30225bc0c246b53270eb90b23cfbb941a186d@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        zhang.jia@linux.alibaba.com, tglx@linutronix.de
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org,
          zhang.jia@linux.alibaba.com, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20190401114045.7280-1-zhang.jia@linux.alibaba.com>
References: <20190401114045.7280-1-zhang.jia@linux.alibaba.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/vdso: Remove hpet_page from vDSO
Git-Commit-ID: 81d30225bc0c246b53270eb90b23cfbb941a186d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-3.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        T_DATE_IN_FUTURE_96_Q autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  81d30225bc0c246b53270eb90b23cfbb941a186d
Gitweb:     https://git.kernel.org/tip/81d30225bc0c246b53270eb90b23cfbb941a186d
Author:     Jia Zhang <zhang.jia@linux.alibaba.com>
AuthorDate: Mon, 1 Apr 2019 19:40:45 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 8 May 2019 13:13:57 +0200

x86/vdso: Remove hpet_page from vDSO

This trivial cleanup finalizes the removal of vDSO HPET support.

Fixes: 1ed95e52d902 ("x86/vdso: Remove direct HPET access through the vDSO")
Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: luto@kernel.org
Cc: bp@alien8.de
Link: https://lkml.kernel.org/r/20190401114045.7280-1-zhang.jia@linux.alibaba.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/vdso/vdso2c.c | 3 ---
 arch/x86/include/asm/vdso.h  | 1 -
 2 files changed, 4 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
index 8e470b018512..3a4d8d4d39f8 100644
--- a/arch/x86/entry/vdso/vdso2c.c
+++ b/arch/x86/entry/vdso/vdso2c.c
@@ -73,14 +73,12 @@ const char *outfilename;
 enum {
 	sym_vvar_start,
 	sym_vvar_page,
-	sym_hpet_page,
 	sym_pvclock_page,
 	sym_hvclock_page,
 };
 
 const int special_pages[] = {
 	sym_vvar_page,
-	sym_hpet_page,
 	sym_pvclock_page,
 	sym_hvclock_page,
 };
@@ -93,7 +91,6 @@ struct vdso_sym {
 struct vdso_sym required_syms[] = {
 	[sym_vvar_start] = {"vvar_start", true},
 	[sym_vvar_page] = {"vvar_page", true},
-	[sym_hpet_page] = {"hpet_page", true},
 	[sym_pvclock_page] = {"pvclock_page", true},
 	[sym_hvclock_page] = {"hvclock_page", true},
 	{"VDSO32_NOTE_MASK", true},
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index 27566e57e87d..230474e2ddb5 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -19,7 +19,6 @@ struct vdso_image {
 	long sym_vvar_start;  /* Negative offset to the vvar area */
 
 	long sym_vvar_page;
-	long sym_hpet_page;
 	long sym_pvclock_page;
 	long sym_hvclock_page;
 	long sym_VDSO32_NOTE_MASK;
