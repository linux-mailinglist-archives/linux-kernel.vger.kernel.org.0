Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C35DCF59A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 13:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfD3LaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 07:30:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43931 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfD3LaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:30:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3UBTYcg1350551
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Apr 2019 04:29:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3UBTYcg1350551
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556623775;
        bh=tzqP+K1slI+8lkDw9KMmwPxdNB3wF9JoSTcYZ2Gu0vA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=FwPL4LRMUuEAkydDlPd1E2tmpB2Wz+cFAGQ8iuBCXrf1UHvBTIKRb08kBW2MA7rYe
         3hn5medFE5dY3fi/RVgosqJUekt604V5rFP9oICVSj1b0Si70I4r+jNkSGQP6BUcVP
         K5pNEvPCQgMksBlchjeVH1mvw4qdTBA1FUPBDR9w+vnMVlwEP07z2+jmuiqBdNo+/L
         c345GsfdV9BBMwy9KXIErqdli6/Yx7SR43xwlTeWrq2jp2rjt5GmdSmwLvHsJiq8Z2
         tR61NjmdL9zwouHRUzTNCvHYTugnnCl0OKu3wxPf6p2iQ0e4nVG0rZYqamNinNygmz
         Uece1pV0p2yrQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3UBTY7p1350548;
        Tue, 30 Apr 2019 04:29:34 -0700
Date:   Tue, 30 Apr 2019 04:29:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nadav Amit <tipbot@zytor.com>
Message-ID: <tip-3950746d9d8ef981c1cb842384e0e86e8d1aad76@git.kernel.org>
Cc:     ard.biesheuvel@linaro.org, bp@alien8.de,
        dave.hansen@linux.intel.com, linux_dti@icloud.com,
        riel@surriel.com, akpm@linux-foundation.org,
        deneen.t.dock@intel.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, kristen@linux.intel.com,
        hpa@zytor.com, will.deacon@arm.com, mingo@kernel.org,
        mhiramat@kernel.org, tglx@linutronix.de,
        rick.p.edgecombe@intel.com, luto@kernel.org,
        kernel-hardening@lists.openwall.com, peterz@infradead.org,
        namit@vmware.com
Reply-To: deneen.t.dock@intel.com, linux-kernel@vger.kernel.org,
          riel@surriel.com, akpm@linux-foundation.org,
          dave.hansen@linux.intel.com, linux_dti@icloud.com,
          ard.biesheuvel@linaro.org, bp@alien8.de,
          kernel-hardening@lists.openwall.com, namit@vmware.com,
          peterz@infradead.org, luto@kernel.org,
          rick.p.edgecombe@intel.com, mhiramat@kernel.org,
          tglx@linutronix.de, torvalds@linux-foundation.org, hpa@zytor.com,
          mingo@kernel.org, will.deacon@arm.com, kristen@linux.intel.com
In-Reply-To: <20190426001143.4983-22-namit@vmware.com>
References: <20190426001143.4983-22-namit@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/alternatives: Add comment about module removal
 races
Git-Commit-ID: 3950746d9d8ef981c1cb842384e0e86e8d1aad76
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO,T_DATE_IN_FUTURE_96_Q autolearn=no
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3950746d9d8ef981c1cb842384e0e86e8d1aad76
Gitweb:     https://git.kernel.org/tip/3950746d9d8ef981c1cb842384e0e86e8d1aad76
Author:     Nadav Amit <namit@vmware.com>
AuthorDate: Thu, 25 Apr 2019 17:11:41 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 30 Apr 2019 12:38:01 +0200

x86/alternatives: Add comment about module removal races

Add a comment to clarify that users of text_poke() must ensure that
no races with module removal take place.

Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <akpm@linux-foundation.org>
Cc: <ard.biesheuvel@linaro.org>
Cc: <deneen.t.dock@intel.com>
Cc: <kernel-hardening@lists.openwall.com>
Cc: <kristen@linux.intel.com>
Cc: <linux_dti@icloud.com>
Cc: <will.deacon@arm.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190426001143.4983-22-namit@vmware.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/alternative.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 18f959975ea0..7b9b49dfc05a 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -810,6 +810,11 @@ static void *__text_poke(void *addr, const void *opcode, size_t len)
  * It means the size must be writable atomically and the address must be aligned
  * in a way that permits an atomic write. It also makes sure we fit on a single
  * page.
+ *
+ * Note that the caller must ensure that if the modified code is part of a
+ * module, the module would not be removed during poking. This can be achieved
+ * by registering a module notifier, and ordering module removal and patching
+ * trough a mutex.
  */
 void *text_poke(void *addr, const void *opcode, size_t len)
 {
