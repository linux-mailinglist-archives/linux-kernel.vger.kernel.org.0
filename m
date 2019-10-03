Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F963C9CC8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 13:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbfJCLBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 07:01:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50316 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbfJCLBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mIDyYRFzI6ytRUgMFKgNN0EZHGbTeOEsH8ft0Bg8Fzk=; b=hiPLFdlzn6nxKMq6GsJk68awK
        tQ/DYlxJNlYM07uYBf1GU8zg3nazk+OnTT7FIgMhETSgZSeqQJeqoocWAnyWRGQjfDnFEJa+nWWVH
        if/+PFHS4m/de0OXimcf6qIJ1ESKu51LfPOBHeXnCzT3+49xg3cjMnf9W4/1m+Et3QRNn74rphz2G
        Zf3xU0cFELdJDz8mjQrmR8baQqepgEg1GEXyL6UgnxajZzS6degYAkr8lcn+Qyp+YoK4OazdgXs8Q
        TpQEL8LUjg/7qgqPxYRBnDaX5SfPxE8Qkq9yacYzzMy+sEFRwRhAK6Fwbx60NlXsJdCSMPbdE199L
        XHGgpoAeA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFyr8-0005pY-No; Thu, 03 Oct 2019 11:01:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 64802301A79;
        Thu,  3 Oct 2019 13:00:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8B067201DF203; Thu,  3 Oct 2019 13:01:06 +0200 (CEST)
Date:   Thu, 3 Oct 2019 13:01:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 1/3] x86/alternatives: Teach text_poke_bp() to emulate
 instructions
Message-ID: <20191003110106.GI4581@hirez.programming.kicks-ass.net>
References: <20190827180622.159326993@infradead.org>
 <20190827181147.053490768@infradead.org>
 <20191003140050.1d4cf59d3de8b5396d36c269@kernel.org>
 <20191003082751.GQ4536@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003082751.GQ4536@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 10:27:51AM +0200, Peter Zijlstra wrote:
> On Thu, Oct 03, 2019 at 02:00:50PM +0900, Masami Hiramatsu wrote:
> 
> > > This fits almost all text_poke_bp() users, except
> > > arch_unoptimize_kprobe() which restores random text, and for that site
> > > we have to build an explicit emulate instruction.
> > 
> > OK, and in this case, I would like to change RELATIVEJUMP_OPCODE
> > to JMP32_INSN_OPCODE for readability. (or at least
> > making RELATIVEJUMP_OPCODE as an alias of JMP32_INSN_OPCODE)
> 
> > > @@ -448,12 +447,18 @@ void arch_optimize_kprobes(struct list_h
> > >  void arch_unoptimize_kprobe(struct optimized_kprobe *op)
> > >  {
> > >  	u8 insn_buff[RELATIVEJUMP_SIZE];
> > > +	u8 emulate_buff[RELATIVEJUMP_SIZE];
> > >  
> > >  	/* Set int3 to first byte for kprobes */
> > >  	insn_buff[0] = BREAKPOINT_INSTRUCTION;
> > >  	memcpy(insn_buff + 1, op->optinsn.copied_insn, RELATIVE_ADDR_SIZE);
> > > +
> > > +	emulate_buff[0] = RELATIVEJUMP_OPCODE;
> > > +	*(s32 *)(&emulate_buff[1]) = (s32)((long)op->optinsn.insn -
> > > +			((long)op->kp.addr + RELATIVEJUMP_SIZE));
> 
> I'm halfway through a patch introducing:
> 
>   union text_poke_insn {
> 	u8 code[POKE_MAX_OPCODE_SUZE];
> 	struct {
> 		u8 opcode;
> 		s32 disp;
> 	} __attribute__((packed));
>   };
> 
> to text-patching.h to unify all such custom unions we have all over the
> place. I'll mob up the above in that.
> 
> > > +
> > >  	text_poke_bp(op->kp.addr, insn_buff, RELATIVEJUMP_SIZE,
> > > -		     op->optinsn.insn);
> > > +		     emulate_buff);
> > >  }
> 
> As argued in a previous thread, text_poke_bp() is broken when it changes
> more than a single instruction at a time.
> 
> Now, ISTR optimized kprobes does something like:
> 
> 	poke INT3

Hmm, it does this using text_poke(), but lacks a
on_each_cpu(do_sync_core, NULL, 1), which I suppose is OK-ish IFF you do
that synchronize_rcu_tasks() after it, but less so if you don't.

That is, without either, you can't really tell if the kprobe is in
effect or not.

Also, I think text_poke_bp(INT3) is broken, although I don't think
anybody actually does that. Still, let me fix that.

> 	synchronize_rcu_tasks() /* waits for all tasks to schedule
> 				   guarantees instructions after INT3
> 				   are unused */
> 	install optimized probe /* overwrites multiple instrctions with
> 				   JMP.d32 */
> 
> And the above then undoes that by:
> 
> 	poke INT3 on top of the optimzed probe
> 
> 	poke tail instructions back /* guaranteed safe because the
> 				       above INT3 poke ensures the
> 				       JMP.d32 instruction is unused */
> 
> 	poke head byte back
> 
> Is this correct? If so, we should probably put a comment in there
> explaining how all this is unusual but safe.
