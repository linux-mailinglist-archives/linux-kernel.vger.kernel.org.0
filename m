Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB5B229248
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 10:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389357AbfEXIAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 04:00:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37367 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389001AbfEXIAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:00:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4O7wjmW114869
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 24 May 2019 00:58:45 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4O7wjmW114869
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558684726;
        bh=d498370uNJzjkSB2ppzDKeE46E+k/K8w1znYVdM5fv0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=XvrD3J9VuJz6VfVGXV61ImGoXS0Y5jh8JEvS9oaVuC7m/eBDhmPw7N/LXJEsiGexN
         GDRzOV5E0QQjR83PWr7xgYgfq/+UD3Al+MbmW6HhDqoyGaTTP1ZZIjJwg5F++jZxzU
         4fIDgQaW8H2TYN/hE9B7aKljBJkqio5cvw2UH5oudZz3k2aybO7l61aYn+4RarCqrH
         IoMaMKFnTphsSpSAQlKOf9c9h+fukTzV3mreUO/PwE4yTeDEoP8c2DTaFmQ0edsB7F
         tWKH9jQvXf8+VTtiMoqEWABFAUAzhvUzN/IClIhU3HNb47FjEeZONFpjy9mBMSxJGR
         tSv26q+vLmaQg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4O7widk114866;
        Fri, 24 May 2019 00:58:44 -0700
Date:   Fri, 24 May 2019 00:58:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-2777cae2b19d4a08ad233b3504c19c6f7a6a2ef3@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        a.p.zijlstra@chello.nl, mingo@kernel.org, riel@surriel.com,
        hpa@zytor.com, brgerst@gmail.com, torvalds@linux-foundation.org,
        jgross@suse.com, luto@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dvlasenk@redhat.com, peterz@infradead.org
Reply-To: linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
          a.p.zijlstra@chello.nl, riel@surriel.com,
          torvalds@linux-foundation.org, tglx@linutronix.de, bp@alien8.de,
          mingo@kernel.org, hpa@zytor.com, brgerst@gmail.com,
          luto@kernel.org, jgross@suse.com, dvlasenk@redhat.com,
          peterz@infradead.org
In-Reply-To: <20190425091717.GA72229@gmail.com>
References: <20190425091717.GA72229@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/paravirt] x86/paravirt: Detect over-sized patching bugs in
 paravirt_patch_insns()
Git-Commit-ID: 2777cae2b19d4a08ad233b3504c19c6f7a6a2ef3
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=2.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_03_06,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO autolearn=no autolearn_force=no
        version=3.4.2
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  2777cae2b19d4a08ad233b3504c19c6f7a6a2ef3
Gitweb:     https://git.kernel.org/tip/2777cae2b19d4a08ad233b3504c19c6f7a6a2ef3
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Thu, 25 Apr 2019 11:17:17 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Apr 2019 12:00:31 +0200

x86/paravirt: Detect over-sized patching bugs in paravirt_patch_insns()

So paravirt_patch_insns() contains this gem of logic:

unsigned paravirt_patch_insns(void *insnbuf, unsigned len,
                              const char *start, const char *end)
{
        unsigned insn_len = end - start;

        if (insn_len > len || start == NULL)
                insn_len = len;
        else
                memcpy(insnbuf, start, insn_len);

        return insn_len;
}

Note how 'len' (size of the original instruction) is checked against the new
instruction, and silently discarded with no warning printed whatsoever.

This crashes the kernel in funny ways if the patching template is buggy,
and usually in much later places.

Instead do a direct BUG_ON(), there's no way to continue successfully at that point.

I've tested this patch, with the vanilla kernel check never triggers, and
if I intentionally increase the size of one of the patch templates to a
too high value the assert triggers:

[    0.164385] kernel BUG at arch/x86/kernel/paravirt.c:167!

Without this patch a broken kernel randomly crashes in later places,
after the silent patching failure.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20190425091717.GA72229@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/paravirt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index c0e0101133f3..7f9121f2fdac 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -163,10 +163,10 @@ unsigned paravirt_patch_insns(void *insnbuf, unsigned len,
 {
 	unsigned insn_len = end - start;
 
-	if (insn_len > len || start == NULL)
-		insn_len = len;
-	else
-		memcpy(insnbuf, start, insn_len);
+	/* Alternative instruction is too large for the patch site and we cannot continue: */
+	BUG_ON(insn_len > len || start == NULL);
+
+	memcpy(insnbuf, start, insn_len);
 
 	return insn_len;
 }
