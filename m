Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D71636D479
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 21:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391141AbfGRTMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 15:12:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59793 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRTMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:12:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6IJBwca2124343
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Jul 2019 12:11:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6IJBwca2124343
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563477119;
        bh=6Rj46KtNRyDo8ybnIo8yan74dq7igiRGR7khPhDutHA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=d0nBMDxwilpe7clO/W/qJK5Cg4+qTgZh6NA6k3llk4o06shA7daRCvbpVu/tfhMhZ
         x2dcn0CQPq71iGejXCcwY/DEP9LmNL/+iED194D8yy0vAJrJJxhzj6czmv8FIqsQru
         On8hCDMrcHWjnNaEmTWtmCvbZVLGK7m2uwfEOHw/O+aRH7m4YHmG+18RaEaoULfgC6
         Xwx6+IkW+38X6TqDfu+a2gAirdR2cZYxhDFqzNmLlydpsj8zng3adjYJpdrN59mfpE
         Q9seV/8hJxN0Yw3QXYgc1Kr43vxhT+kPTa70yDhioUbtmOqkLHr7MFnDKsu9MPd2EX
         ti2pNGPU+2DPg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6IJBvFe2124337;
        Thu, 18 Jul 2019 12:11:57 -0700
Date:   Thu, 18 Jul 2019 12:11:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-3a6ab4bcc52263dd5b1d2fd2e4ce95a38c798b4d@git.kernel.org>
Cc:     peterz@infradead.org, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org, hpa@zytor.com, peterz@infradead.org,
          jpoimboe@redhat.com
In-Reply-To: <6b6e436774678b4b9873811ff023bd29935bee5b.1563413318.git.jpoimboe@redhat.com>
References: <6b6e436774678b4b9873811ff023bd29935bee5b.1563413318.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] x86/uaccess: Remove ELF function annotation from
 copy_user_handle_tail()
Git-Commit-ID: 3a6ab4bcc52263dd5b1d2fd2e4ce95a38c798b4d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_48_96,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3a6ab4bcc52263dd5b1d2fd2e4ce95a38c798b4d
Gitweb:     https://git.kernel.org/tip/3a6ab4bcc52263dd5b1d2fd2e4ce95a38c798b4d
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Wed, 17 Jul 2019 20:36:42 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 18 Jul 2019 21:01:05 +0200

x86/uaccess: Remove ELF function annotation from copy_user_handle_tail()

After an objtool improvement, it's complaining about the CLAC in
copy_user_handle_tail():

  arch/x86/lib/copy_user_64.o: warning: objtool: .altinstr_replacement+0x12: redundant UACCESS disable
  arch/x86/lib/copy_user_64.o: warning: objtool:   copy_user_handle_tail()+0x6: (alt)
  arch/x86/lib/copy_user_64.o: warning: objtool:   copy_user_handle_tail()+0x2: (alt)
  arch/x86/lib/copy_user_64.o: warning: objtool:   copy_user_handle_tail()+0x0: <=== (func)

copy_user_handle_tail() is incorrectly marked as a callable function, so
objtool is rightfully concerned about the CLAC with no corresponding
STAC.

Remove the ELF function annotation.  The copy_user_handle_tail() code
path is already verified by objtool because it's jumped to by other
callable asm code (which does the corresponding STAC).

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/6b6e436774678b4b9873811ff023bd29935bee5b.1563413318.git.jpoimboe@redhat.com

---
 arch/x86/lib/copy_user_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 378a1f70ae7d..4fe1601dbc5d 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -239,7 +239,7 @@ copy_user_handle_tail:
 	ret
 
 	_ASM_EXTABLE_UA(1b, 2b)
-ENDPROC(copy_user_handle_tail)
+END(copy_user_handle_tail)
 
 /*
  * copy_user_nocache - Uncached memory copy with exception handling
