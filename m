Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07C773BDDB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 22:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbfFJUxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 16:53:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49115 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbfFJUxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 16:53:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5AKqCGh4072505
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 10 Jun 2019 13:52:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5AKqCGh4072505
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560199933;
        bh=A2cy2pnoZYAsn5lO0GtT00kfuwyKxTuvGLoBKtmJWzc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=dykvvYF603sp4czAtt0C0HKGWWJNg7X3pc3wSZFqbew+2HoehZOq+Z0QILr1W4vUr
         70s0MsGotmzaDZPgX5EJfV8FU6ysZzgCDs6U3mvR8YyHVDIwjHPFk5VnN+XFu+UiRM
         AgnoFx/shzYK7QphsBVvKVe74AMdtl7CNAzfhoThCcoVIFFfFjVfQmUKIzTNgCO/kI
         kWELeZPpWHm/w99brAKD79wecYnC07XezNzC8Vzr5BcgnncGz2PZ/MRFXIY3o7mneu
         N6Cwb/Lp0zJ89euoE/4brY/M6Qm/yQ1urPY8j1ZBKwi4mtpi8oqYkGvEcvN7xurDfg
         tXbwD+06oH9yQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5AKqBJj4072502;
        Mon, 10 Jun 2019 13:52:11 -0700
Date:   Mon, 10 Jun 2019 13:52:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Uros Bizjak <tipbot@zytor.com>
Message-ID: <tip-515f0453752e3daba7c47d37d9172a66509a56fd@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, x86@kernel.org,
        bp@suse.de, reinette.chatre@intel.com, mingo@redhat.com,
        ubizjak@gmail.com, tglx@linutronix.de, hpa@zytor.com,
        fenghua.yu@intel.com
Reply-To: fenghua.yu@intel.com, hpa@zytor.com, tglx@linutronix.de,
          ubizjak@gmail.com, reinette.chatre@intel.com, mingo@redhat.com,
          bp@suse.de, x86@kernel.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190606200044.5730-1-ubizjak@gmail.com>
References: <20190606200044.5730-1-ubizjak@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/resctrl: Use _ASM_BX to avoid ifdeffery
Git-Commit-ID: 515f0453752e3daba7c47d37d9172a66509a56fd
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=0.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  515f0453752e3daba7c47d37d9172a66509a56fd
Gitweb:     https://git.kernel.org/tip/515f0453752e3daba7c47d37d9172a66509a56fd
Author:     Uros Bizjak <ubizjak@gmail.com>
AuthorDate: Thu, 6 Jun 2019 22:00:44 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 10 Jun 2019 22:36:38 +0200

x86/resctrl: Use _ASM_BX to avoid ifdeffery

Use the _ASM_BX macro which expands to either %rbx or %ebx, depending on
the 32-bit or 64-bit config selected.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190606200044.5730-1-ubizjak@gmail.com
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 604c0e3bcc83..09408794eab2 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -431,11 +431,7 @@ static int pseudo_lock_fn(void *_rdtgrp)
 #else
 	register unsigned int line_size asm("esi");
 	register unsigned int size asm("edi");
-#ifdef CONFIG_X86_64
-	register void *mem_r asm("rbx");
-#else
-	register void *mem_r asm("ebx");
-#endif /* CONFIG_X86_64 */
+	register void *mem_r asm(_ASM_BX);
 #endif /* CONFIG_KASAN */
 
 	/*
