Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3D31FC833
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 14:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfKNN4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 08:56:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:55858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbfKNN4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:56:33 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47D1A2075E;
        Thu, 14 Nov 2019 13:56:31 +0000 (UTC)
Date:   Thu, 14 Nov 2019 08:56:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH -v5 05/17] x86/ftrace: Use text_poke()
Message-ID: <20191114085628.16a942a2@gandalf.local.home>
In-Reply-To: <20191114131827.GV4131@hirez.programming.kicks-ass.net>
References: <20191111131252.921588318@infradead.org>
        <20191111132457.761255803@infradead.org>
        <20191112132536.28ac1b32@gandalf.local.home>
        <20191112222413.GB4131@hirez.programming.kicks-ass.net>
        <20191112174816.7fb95948@gandalf.local.home>
        <20191113090104.GF4131@hirez.programming.kicks-ass.net>
        <20191113092741.18abd63b@gandalf.local.home>
        <20191114131827.GV4131@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2019 14:18:27 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Nov 13, 2019 at 09:27:41AM -0500, Steven Rostedt wrote:
> 
> > Yeah, let's keep it this way, but still needs a comment.  
> 
> The function now reads:
> 
> int ftrace_arch_code_modify_post_process(void)
>     __releases(&text_mutex)
> {
> 	/*
> 	 * ftrace_module_enable()
> 	 *   ftrace_arch_code_modify_prepare()
> 	 *   do_for_each_ftrace_rec()
> 	 *     __ftrace_replace_code()
> 	 *       ftrace_make_{call,nop}()
> 	 *         ftrace_modify_code_direct()
> 	 *           text_poke_queue()
> 	 *   ftrace_arch_code_modify_post_process()
> 	 *     text_poke_finish()

Perhaps just:

	/*
	 * ftrace_make_{call,nop}() may be called during
	 * module load, and we need to finish the text_poke_queue()
	 * that they do, here.
> 	 */


> 	text_poke_finish();
> 	ftrace_poke_late = 0;
> 	mutex_unlock(&text_mutex);
> 	return 0;
> }
> 
> Patch is otherwise unchanged.

Other than that:

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

