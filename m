Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 767E2E2FA5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 12:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392796AbfJXK7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 06:59:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48532 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730032AbfJXK7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 06:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=y4FIcVrjYVao1y+XFkUuHSfQ9vMJSK8t08LureODAF8=; b=qEmmqDKS+UlLB0wGgwYVneHd9
        B7YiviGzJbBf77W/xSdcEoGcfjQD0gi9QqrPkGhjXbJaInO5wvIPOwz0oe3r8cG/GuXy4uEZdwDkt
        vlT3kpBa8zXzAvKF6a/xtOblBwjTCd8brfI1e+JEx1QoXFBT3T6u29VBidvy4RJIvTpzrH8u4a7oi
        avDiOW1Fq8A3d9dOnt4ROZ8PXQQiyo7Diq8EXyEqHUnD/+z8kSVDPRQtYLHMV/s4+BK0HEgmoEOAa
        Yh7r3sSjzrtVx2diPZZJciC6Vg4pUqAsGnhEMi/sCHvz4xIdwXlsopjcuL5jHuiMZC4+axSFzmzwc
        dzdqZ0SaA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNapg-0004HT-8B; Thu, 24 Oct 2019 10:59:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9FF74300489;
        Thu, 24 Oct 2019 12:58:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0993B2100B87F; Thu, 24 Oct 2019 12:59:05 +0200 (CEST)
Date:   Thu, 24 Oct 2019 12:59:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jeyu@kernel.org
Subject: Re: [PATCH v4 15/16] module: Move where we mark modules RO,X
Message-ID: <20191024105904.GB4131@hirez.programming.kicks-ass.net>
References: <20191018073525.768931536@infradead.org>
 <20191018074634.801435443@infradead.org>
 <20191021135312.jbbxsuipxldocdjk@treble>
 <20191021141402.GI1817@hirez.programming.kicks-ass.net>
 <20191023114835.GT1817@hirez.programming.kicks-ass.net>
 <20191023151654.GF19358@hirez.programming.kicks-ass.net>
 <20191023171514.7hkhtvfcj5vluwcg@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023171514.7hkhtvfcj5vluwcg@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 12:15:14PM -0500, Josh Poimboeuf wrote:
> On Wed, Oct 23, 2019 at 05:16:54PM +0200, Peter Zijlstra wrote:
> > @@ -157,6 +158,14 @@ static int __apply_relocate_add(Elf64_Sh
> >  
> >  		val = sym->st_value + rel[i].r_addend;
> >  
> > +		/*
> > +		 * .klp.rela.* sections should only contain module
> > +		 * related RELAs. All core-kernel RELAs should be in
> > +		 * normal .rela.* sections and be applied when loading
> > +		 * the patch module itself.
> > +		 */
> > +		WARN_ON_ONCE(klp && core_kernel_text(val));
> > +
> 
> This isn't quite true, we also use .klp.rela sections to access
> unexported vmlinux symbols.

Yes, you said in that earlier email. That all makes it really hard to
validate this. But unless we validate it, it will stay buggy :/

Hmmm.... /me ponders

The alternative would be to apply the .klp.rela.* sections twice, once
at patch-module load time and then apply those core_kernel_text()
entries, and then once later and skip over them.

How's this?

---
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -126,12 +126,20 @@ int apply_relocate(Elf32_Shdr *sechdrs,
 	return 0;
 }
 #else /*X86_64*/
+
+enum rela_filter {
+	rela_all = 0,
+	rela_core,
+	rela_mod,
+};
+
 static int __apply_relocate_add(Elf64_Shdr *sechdrs,
 		   const char *strtab,
 		   unsigned int symindex,
 		   unsigned int relsec,
 		   struct module *me,
-		   void *(*write)(void *addr, const void *val, size_t size))
+		   void *(*write)(void *addr, const void *val, size_t size),
+		   enum rela_filter filter)
 {
 	unsigned int i;
 	Elf64_Rela *rel = (void *)sechdrs[relsec].sh_addr;
@@ -157,6 +165,11 @@ static int __apply_relocate_add(Elf64_Sh
 
 		val = sym->st_value + rel[i].r_addend;
 
+		if (filter) {
+			if ((filter == rela_core) != !!core_kernel_text(val))
+				continue;
+		}
+
 		switch (ELF64_R_TYPE(rel[i].r_info)) {
 		case R_X86_64_NONE:
 			break;
@@ -223,18 +236,21 @@ int apply_relocate_add(Elf64_Shdr *sechd
 		   unsigned int relsec,
 		   struct module *me)
 {
-	return __apply_relocate_add(sechdrs, strtab, symindex, relsec, me, memcpy);
+	return __apply_relocate_add(sechdrs, strtab, symindex, relsec, me, memcpy, rela_all);
 }
 
 int klp_apply_relocate_add(Elf64_Shdr *sechdrs,
 		   const char *strtab,
 		   unsigned int symindex,
 		   unsigned int relsec,
-		   struct module *me)
+		   struct module *me, bool late)
 {
 	int ret;
 
-	ret = __apply_relocate_add(sechdrs, strtab, symindex, relsec, me, text_poke);
+	if (!late)
+		return __apply_relocate_add(sechdrs, strtab, symindex, relsec, me, memcpy, rela_core);
+
+	ret = __apply_relocate_add(sechdrs, strtab, symindex, relsec, me, text_poke, rela_mod);
 	if (!ret)
 		text_poke_sync();
 
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -222,7 +222,7 @@ extern int klp_apply_relocate_add(Elf64_
 			      const char *strtab,
 			      unsigned int symindex,
 			      unsigned int relsec,
-			      struct module *me);
+			      struct module *me, bool late);
 
 #else /* !CONFIG_LIVEPATCH */
 
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -245,15 +245,6 @@ static int klp_resolve_symbols(Elf_Shdr
 	return 0;
 }
 
-int __weak klp_apply_relocate_add(Elf64_Shdr *sechdrs,
-			      const char *strtab,
-			      unsigned int symindex,
-			      unsigned int relsec,
-			      struct module *me)
-{
-	return apply_relocate_add(sechdrs, strtab, symindex, relsec, me);
-}
-
 static int klp_write_object_relocations(struct module *pmod,
 					struct klp_object *obj)
 {
@@ -296,7 +287,7 @@ static int klp_write_object_relocations(
 
 		ret = klp_apply_relocate_add(pmod->klp_info->sechdrs,
 					 pmod->core_kallsyms.strtab,
-					 pmod->klp_info->symndx, i, pmod);
+					 pmod->klp_info->symndx, i, pmod, true);
 		if (ret)
 			break;
 	}
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2328,8 +2328,13 @@ static int apply_relocations(struct modu
 			continue;
 
 		/* Livepatch relocation sections are applied by livepatch */
-		if (info->sechdrs[i].sh_flags & SHF_RELA_LIVEPATCH)
+		if (info->sechdrs[i].sh_flags & SHF_RELA_LIVEPATCH) {
+			if (info->sechdrs[i].sh_type == SHT_RELA) {
+				klp_apply_relocate_add(info->sechdrs, info->strtab,
+						       info->index.sym, i, mod, false);
+			}
 			continue;
+		}
 
 		if (info->sechdrs[i].sh_type == SHT_REL)
 			err = apply_relocate(info->sechdrs, info->strtab,
