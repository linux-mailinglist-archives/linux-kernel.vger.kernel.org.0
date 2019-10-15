Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F361D7A7B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 17:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387777AbfJOPvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 11:51:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbfJOPvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:51:14 -0400
Received: from linux-8ccs (ip5f5adbbb.dynamic.kabel-deutschland.de [95.90.219.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 043D620854;
        Tue, 15 Oct 2019 15:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571154674;
        bh=oNJsaWqTTiEO+jrzQ0YGR9CkjPFJklmFoSsQwdLi2+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WOMDyxZLo9W2uzuyH25uKqiF8u36yRYv4ix3s/HW1/X4T9/Guj3RDNsd9y8DL8VSb
         Owge+/Ep92XmU1E9smw/9xilvz188maVO6CSD1SLOoQZubkUcGJHb6wMTWOfIDKQOn
         J1yOzGzVmdnCik8o+AbXqfvCNuyrKTDgwZ89m0N4=
Date:   Tue, 15 Oct 2019 17:51:07 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [PATCH v3 5/6] x86/ftrace: Use text_poke()
Message-ID: <20191015155107.GA21110@linux-8ccs>
References: <20191008104335.6fcd78c9@gandalf.local.home>
 <20191009224135.2dcf7767@oasis.local.home>
 <20191010092054.GR2311@hirez.programming.kicks-ass.net>
 <20191010091956.48fbcf42@gandalf.local.home>
 <20191010140513.GT2311@hirez.programming.kicks-ass.net>
 <20191010115449.22044b53@gandalf.local.home>
 <20191010172819.GS2328@hirez.programming.kicks-ass.net>
 <20191011125903.GN2359@hirez.programming.kicks-ass.net>
 <20191015130739.GA23565@linux-8ccs>
 <20191015135634.GK2328@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191015135634.GK2328@hirez.programming.kicks-ass.net>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Peter Zijlstra [15/10/19 15:56 +0200]:
>On Tue, Oct 15, 2019 at 03:07:40PM +0200, Jessica Yu wrote:
>> I'm having trouble visualizing what changes you're planning on making.
>
>I want all the text poking (jump_label, ftrace, klp whatever) to happen
>_before_ we do the protection changes.
>
>I also want to avoid flipping the protection state around unnecessarily,
>because that clearly is just wasted work.

OK, that makes sense, thanks for clarifying. 

>> I get that you want to squash ftrace_module_enable() into
>> ftrace_module_init(), before module_enable_ro(). I'm fine with that as
>> long as the races Steven described are addressed for affected arches.
>
>Right, the problem is set_all_modules_text_*(), that relies on COMING
>having made the protection changes.
>
>After the x86 changes, there's only 2 more architectures that use that
>function. I'll work on getting those converted and then we can delete
>that function and worry no more about it.
>
>> And livepatch should be OK as long as klp_module_coming() is always
>> called *after* ftrace_module_enable(). But are you moving
>> klp_module_coming() before the module_enable_* calls as well?  And if
>> so, why?
>
>I wanted to move the COMING notifier callback before the protection
>changes, because that is the easiest way to convert jump_label and
>static_call and AFAICT nothing really cared aside from ftrace.

I think I would be fine with this as long as no notifiers/users rely
on the assumption that COMING == module enabled protections already.
I've yet to audit all the module notifiers (but I trust you've done
this already), and I think ftrace was the only user that relied on
this. For livepatch it's probably not immediately fixable without some
serious overhaul.

>The alternative is introducing additional module states, which just adds
>complexity we don't really need if we can just flip things around a
>little.

Yeah, I would prefer not adding more states if possible :-)

>> > The fact that it is executable; also the fact that you do it right after
>> > we mark it ro. Flipping the memory protections back and forth is just
>> > really poor everything.
>> >
>> > Once this ftrace thing is sorted, we'll change x86 to _refuse_ to make
>> > executable (kernel) memory writable.
>>
>> Not sure if relevant, but just thought I'd clarify: IIRC,
>> klp_module_coming() is not poking the coming module, but it calls
>> module_enable_ro() on itself (the livepatch module) so it can apply
>> relocations and such on the new code, which lives inside the livepatch
>> module, and it needs to possibly do this numerous times over the
>> lifetime of the patch module for any coming module it is responsible
>> for patching (i.e., call module_enable_ro() on the patch module, not
>> necessarily the coming module). So I am not be sure why
>> klp_module_coming() should be moved before complete_formation(). I
>> hope I'm remembering the details correctly, livepatch folks feel free
>> to chime in if I'm incorrect here.
>
>You mean it does module_disable_ro() ? That would be broken and it needs
>to be fixed. Can some livepatch person explain what it does and why?

Gah, sorry, yes I meant module_disable_ro().
