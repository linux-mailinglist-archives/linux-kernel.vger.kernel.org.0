Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD499DC9AE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 17:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392435AbfJRPtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 11:49:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41510 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbfJRPtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8KT4IP36gZnTunsT5P5euYTxP0e3wr/fT7JdxQVYOvk=; b=TowSnp7uroisERgSakdSB5a83
        VQugpqnfOob+51TIzb+FT9gj6iB8L15Aq2RrJ8cJ7KWypqdC4/Zj4HiHR/HRiT9egOtbKOTkwY61l
        tzdnZ484xOMi+3wPIai8IkQA+pNgU4KOSnM8fMqdTVYHh4UI+MJpwWkl+ewUnI3Nc+4bEdAOex3/o
        LsNBI3Fbt+tQwFqrR58MU404N+CQ5rLFsPJKJlRE/CFeqNDE0UXEp4wk0mqbIleuffKvlJLaQv+yw
        FQT/ZE9Hw4GKUUuo5TFjR+Y0ZgofYryV5prI6bxZzHhq6wWgU1KOAnxdQKR/hIKV8BQhm2LVh2TM9
        l7rgGbv1A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLUVH-0006ZL-Dn; Fri, 18 Oct 2019 15:49:23 +0000
Date:   Fri, 18 Oct 2019 08:49:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/8] riscv: add prototypes for assembly language
 functions from entry.S
Message-ID: <20191018154923.GA23279@infradead.org>
References: <20191018080841.26712-1-paul.walmsley@sifive.com>
 <20191018080841.26712-2-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018080841.26712-2-paul.walmsley@sifive.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 01:08:34AM -0700, Paul Walmsley wrote:
> Add prototypes for assembly language functions defined in entry.S,
> and include these prototypes into C source files that call those
> functions.
> 
> This patch resolves the following warnings from sparse:
> 
> arch/riscv/kernel/signal.c:32:53: warning: incorrect type in initializer (different address spaces)

I don't see how adding prototypes will fix an address space warning.

> +asmlinkage void do_trap_unknown(struct pt_regs *regs);
> +asmlinkage void do_trap_insn_misaligned(struct pt_regs *regs);
> +asmlinkage void do_trap_insn_fault(struct pt_regs *regs);
> +asmlinkage void do_trap_insn_illegal(struct pt_regs *regs);
> +asmlinkage void do_trap_load_misaligned(struct pt_regs *regs);
> +asmlinkage void do_trap_load_fault(struct pt_regs *regs);
> +asmlinkage void do_trap_store_misaligned(struct pt_regs *regs);
> +asmlinkage void do_trap_store_fault(struct pt_regs *regs);
> +asmlinkage void do_trap_ecall_u(struct pt_regs *regs);
> +asmlinkage void do_trap_ecall_s(struct pt_regs *regs);
> +asmlinkage void do_trap_ecall_m(struct pt_regs *regs);
> +asmlinkage void do_trap_break(struct pt_regs *regs);

All these are not defined in entry.S, but called from entry.S.

And as Luc pointed out last time the easiest way to fix the sparse
warnings is to add __visible to the definitions of those functions.
