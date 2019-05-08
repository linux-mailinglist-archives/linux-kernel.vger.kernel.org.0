Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0611176AB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 13:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfEHLUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 07:20:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54611 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbfEHLUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 07:20:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x48BKgpI978856
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 8 May 2019 04:20:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x48BKgpI978856
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1557314442;
        bh=C4WHQwbl2oWoZi0mnbtIuFRC+Y3pKDxsSvH0cz0TndE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=FUOjwihOxURfYaM/38wW4c0slTl94sdwQQJFIysYqrOCDJs8Zhb1FNf6lkOkbrGwF
         BwE1M/UQEtFVX3TOCgy7urkbJ/dyqKC0sIg0ajUjmHEptxqpQVKbhKiNDZyNhPgeQa
         rm+kSOEAchrQacyu7QLoMx/FMM+oCVNJXjab9/h2g7TbTYp/Y5pkkrwTYBqs9iFM07
         rpQ0xli8dEL29l8a9gnC8KzAil+dN1bfKIOnVDGB06n075D6EgvYALQ1eTZxxvdGYo
         0BF+pGM/OeE8ljHJnaW6+Wa1XCe9zpQTC1C3z/mX1aEPz9hkXEeDXdYMwP8rd280Dg
         /SScivc6RP9kw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x48BKf6j978853;
        Wed, 8 May 2019 04:20:41 -0700
Date:   Wed, 8 May 2019 04:20:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-0e72499c3cc0cead32f88b94a02204d2b80768bf@git.kernel.org>
Cc:     mingo@kernel.org, ak@linux.intel.com, hpa@zytor.com,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Reply-To: mhiramat@kernel.org, hpa@zytor.com, ak@linux.intel.com,
          mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190330004743.29541-7-andi@firstfloor.org>
References: <20190330004743.29541-7-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/kprobes: Make trampoline_handler() global and
 visible
Git-Commit-ID: 0e72499c3cc0cead32f88b94a02204d2b80768bf
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

Commit-ID:  0e72499c3cc0cead32f88b94a02204d2b80768bf
Gitweb:     https://git.kernel.org/tip/0e72499c3cc0cead32f88b94a02204d2b80768bf
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Fri, 29 Mar 2019 17:47:41 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 8 May 2019 13:13:58 +0200

x86/kprobes: Make trampoline_handler() global and visible

This function is referenced from assembler, so in LTO
it needs to be global and visible to not be optimized away.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lkml.kernel.org/r/20190330004743.29541-7-andi@firstfloor.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/kprobes/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index cf52ee0d8711..9e4fa2484d10 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -768,7 +768,7 @@ static struct kprobe kretprobe_kprobe = {
 /*
  * Called from kretprobe_trampoline
  */
-static __used void *trampoline_handler(struct pt_regs *regs)
+__used __visible void *trampoline_handler(struct pt_regs *regs)
 {
 	struct kprobe_ctlblk *kcb;
 	struct kretprobe_instance *ri = NULL;
