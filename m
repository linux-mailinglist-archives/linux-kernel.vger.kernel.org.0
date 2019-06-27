Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4AC579A1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 04:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfF0CrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 22:47:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48016 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfF0CrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 22:47:06 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A1A1159468;
        Thu, 27 Jun 2019 02:47:05 +0000 (UTC)
Received: from treble (ovpn-126-66.rdu2.redhat.com [10.10.126.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 430FC1001B11;
        Thu, 27 Jun 2019 02:47:03 +0000 (UTC)
Date:   Wed, 26 Jun 2019 21:47:00 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Kairui Song <kasong@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 2/4] objtool: Add support for C jump tables
Message-ID: <20190627024700.q4rkcbhmrna6ev4y@treble>
References: <cover.1561595111.git.jpoimboe@redhat.com>
 <426541f62dad525078ee732c09bc206289e994aa.1561595111.git.jpoimboe@redhat.com>
 <CAADnVQ+veayfD70Xsu8UnNrLdRW6rh9jxPb=OGoiYT-O=_zW=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQ+veayfD70Xsu8UnNrLdRW6rh9jxPb=OGoiYT-O=_zW=A@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 27 Jun 2019 02:47:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 06:42:40PM -0700, Alexei Starovoitov wrote:
> > @@ -1035,9 +1038,18 @@ static struct rela *find_switch_table(struct objtool_file *file,
> >
> >                 /*
> >                  * Make sure the .rodata address isn't associated with a
> > -                * symbol.  gcc jump tables are anonymous data.
> > +                * symbol.  GCC jump tables are anonymous data.
> > +                *
> > +                * Also support C jump tables which are in the same format as
> > +                * switch jump tables.  Each jump table should be a static
> > +                * local const array named "jump_table" for objtool to
> > +                * recognize it.
> 
> Nacked-by: Alexei Starovoitov <ast@kernel.org>
> 
> It's not acceptable for objtool to dictate kernel naming convention.

Abrasive nack notwithstanding, I agree it's not ideal.

How about the following approach instead?  This is the only other way I
can think of to annotate a jump table so that objtool can distinguish
it:

#define __annotate_jump_table __section(".jump_table.rodata")

Then bpf would just need the following:

-	static const void *jumptable[256] = {
+	static const void __annotate_jump_table *jumptable[256] = {

This would be less magical and fragile than my original approach.

I think the jump table would still be placed with all the other rodata,
like before, because the vmlinux linker script recognizes the section
".rodata" suffix and bundles them all together.

-- 
Josh
