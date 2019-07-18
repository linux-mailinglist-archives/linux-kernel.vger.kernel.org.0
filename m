Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 422F36D461
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 21:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391139AbfGRTIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 15:08:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59143 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfGRTIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:08:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6IJ88ZV2123630
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Jul 2019 12:08:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6IJ88ZV2123630
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563476888;
        bh=aQAQe5BgxxOBXrEJ9nGnVWbNd5gMf/yIE7tOj2KUavw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=O5NKwY4Vn9dj1q/iryV8RiOpi8+DbgbGguQyUfVG78EHSqMzHoWIuimo5aYGenfmV
         9WeYYzAM1Ez/6zTOCiKM7UKCgwakTry3eFd88XBgDUBTzf7spg60b/T8yRDIZktrJB
         U9zkIazPhalQvuQloUxTymjvYpZuxXtUyxda/3s3aVN207FZztekUeBN4zstFQ2qBC
         9YnKCf6gupxmyVfZ5yjJK/HBBax0awJw3Q1F4I+hmnaWyFhczDvAcXS9938E2jzMTZ
         tmq51iu54Q8BgSfSRbok3tsnyWVi4ogcN4ktB8sWIVDg65wGp5gHDH8OwiyyRDfdDf
         Wq0JWJAwAJ2sg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6IJ87Lw2123627;
        Thu, 18 Jul 2019 12:08:07 -0700
Date:   Thu, 18 Jul 2019 12:08:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-d99a6ce70ec6ed990b74bd4e34232fd830d20d27@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, tglx@linutronix.de, peterz@infradead.org,
        pbonzini@redhat.com, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, jpoimboe@redhat.com, peterz@infradead.org,
          hpa@zytor.com, pbonzini@redhat.com
In-Reply-To: <c8cc9be60ebbceb3092aa5dd91916039a1f88275.1563413318.git.jpoimboe@redhat.com>
References: <c8cc9be60ebbceb3092aa5dd91916039a1f88275.1563413318.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] x86/kvm: Fix fastop function ELF metadata
Git-Commit-ID: d99a6ce70ec6ed990b74bd4e34232fd830d20d27
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

Commit-ID:  d99a6ce70ec6ed990b74bd4e34232fd830d20d27
Gitweb:     https://git.kernel.org/tip/d99a6ce70ec6ed990b74bd4e34232fd830d20d27
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Wed, 17 Jul 2019 20:36:37 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 18 Jul 2019 21:01:03 +0200

x86/kvm: Fix fastop function ELF metadata

Some of the fastop functions, e.g. em_setcc(), are actually just used as
global labels which point to blocks of functions.  The global labels are
incorrectly annotated as functions.  Also the functions themselves don't
have size annotations.

Fixes a bunch of warnings like the following:

  arch/x86/kvm/emulate.o: warning: objtool: seto() is missing an ELF size annotation
  arch/x86/kvm/emulate.o: warning: objtool: em_setcc() is missing an ELF size annotation
  arch/x86/kvm/emulate.o: warning: objtool: setno() is missing an ELF size annotation
  arch/x86/kvm/emulate.o: warning: objtool: setc() is missing an ELF size annotation

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/c8cc9be60ebbceb3092aa5dd91916039a1f88275.1563413318.git.jpoimboe@redhat.com

---
 arch/x86/kvm/emulate.c | 44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 8e409ad448f9..718f7d9afedc 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -312,29 +312,42 @@ static void invalidate_registers(struct x86_emulate_ctxt *ctxt)
 
 static int fastop(struct x86_emulate_ctxt *ctxt, void (*fop)(struct fastop *));
 
-#define FOP_FUNC(name) \
+#define __FOP_FUNC(name) \
 	".align " __stringify(FASTOP_SIZE) " \n\t" \
 	".type " name ", @function \n\t" \
 	name ":\n\t"
 
-#define FOP_RET   "ret \n\t"
+#define FOP_FUNC(name) \
+	__FOP_FUNC(#name)
+
+#define __FOP_RET(name) \
+	"ret \n\t" \
+	".size " name ", .-" name "\n\t"
+
+#define FOP_RET(name) \
+	__FOP_RET(#name)
 
 #define FOP_START(op) \
 	extern void em_##op(struct fastop *fake); \
 	asm(".pushsection .text, \"ax\" \n\t" \
 	    ".global em_" #op " \n\t" \
-	    FOP_FUNC("em_" #op)
+	    ".align " __stringify(FASTOP_SIZE) " \n\t" \
+	    "em_" #op ":\n\t"
 
 #define FOP_END \
 	    ".popsection")
 
+#define __FOPNOP(name) \
+	__FOP_FUNC(name) \
+	__FOP_RET(name)
+
 #define FOPNOP() \
-	FOP_FUNC(__stringify(__UNIQUE_ID(nop))) \
-	FOP_RET
+	__FOPNOP(__stringify(__UNIQUE_ID(nop)))
 
 #define FOP1E(op,  dst) \
-	FOP_FUNC(#op "_" #dst) \
-	"10: " #op " %" #dst " \n\t" FOP_RET
+	__FOP_FUNC(#op "_" #dst) \
+	"10: " #op " %" #dst " \n\t" \
+	__FOP_RET(#op "_" #dst)
 
 #define FOP1EEX(op,  dst) \
 	FOP1E(op, dst) _ASM_EXTABLE(10b, kvm_fastop_exception)
@@ -366,8 +379,9 @@ static int fastop(struct x86_emulate_ctxt *ctxt, void (*fop)(struct fastop *));
 	FOP_END
 
 #define FOP2E(op,  dst, src)	   \
-	FOP_FUNC(#op "_" #dst "_" #src) \
-	#op " %" #src ", %" #dst " \n\t" FOP_RET
+	__FOP_FUNC(#op "_" #dst "_" #src) \
+	#op " %" #src ", %" #dst " \n\t" \
+	__FOP_RET(#op "_" #dst "_" #src)
 
 #define FASTOP2(op) \
 	FOP_START(op) \
@@ -405,8 +419,9 @@ static int fastop(struct x86_emulate_ctxt *ctxt, void (*fop)(struct fastop *));
 	FOP_END
 
 #define FOP3E(op,  dst, src, src2) \
-	FOP_FUNC(#op "_" #dst "_" #src "_" #src2) \
-	#op " %" #src2 ", %" #src ", %" #dst " \n\t" FOP_RET
+	__FOP_FUNC(#op "_" #dst "_" #src "_" #src2) \
+	#op " %" #src2 ", %" #src ", %" #dst " \n\t"\
+	__FOP_RET(#op "_" #dst "_" #src "_" #src2)
 
 /* 3-operand, word-only, src2=cl */
 #define FASTOP3WCL(op) \
@@ -423,7 +438,7 @@ static int fastop(struct x86_emulate_ctxt *ctxt, void (*fop)(struct fastop *));
 	".type " #op ", @function \n\t" \
 	#op ": \n\t" \
 	#op " %al \n\t" \
-	FOP_RET
+	__FOP_RET(#op)
 
 asm(".pushsection .fixup, \"ax\"\n"
     ".global kvm_fastop_exception \n"
@@ -449,7 +464,10 @@ FOP_SETCC(setle)
 FOP_SETCC(setnle)
 FOP_END;
 
-FOP_START(salc) "pushf; sbb %al, %al; popf \n\t" FOP_RET
+FOP_START(salc)
+FOP_FUNC(salc)
+"pushf; sbb %al, %al; popf \n\t"
+FOP_RET(salc)
 FOP_END;
 
 /*
