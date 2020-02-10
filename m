Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41FEF15808F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 18:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgBJRHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 12:07:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:47318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbgBJRH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:07:29 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 912D32080C;
        Mon, 10 Feb 2020 17:07:28 +0000 (UTC)
Date:   Mon, 10 Feb 2020 12:07:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tools/bootconfig: Fix wrong __VA_ARGS__ usage
Message-ID: <20200210120726.55c060f1@gandalf.local.home>
In-Reply-To: <87y2tazs7h.fsf@mpe.ellerman.id.au>
References: <87o8ua1rg3.fsf@mpe.ellerman.id.au>
        <158108370130.2758.10893830923800978011.stgit@devnote2>
        <87y2tazs7h.fsf@mpe.ellerman.id.au>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2020 20:50:42 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> > diff --git a/tools/bootconfig/include/linux/printk.h b/tools/bootconfig/include/linux/printk.h
> > index 017bcd6912a5..e978a63d3222 100644
> > --- a/tools/bootconfig/include/linux/printk.h
> > +++ b/tools/bootconfig/include/linux/printk.h
> > @@ -7,7 +7,7 @@
> >  /* controllable printf */
> >  extern int pr_output;
> >  #define printk(fmt, ...)	\
> > -	(pr_output ? printf(fmt, __VA_ARGS__) : 0)
> > +	(pr_output ? printf(fmt, ##__VA_ARGS__) : 0)
> >  
> >  #define pr_err printk
> >  #define pr_warn	printk  
> 
> Tested-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks! I'll rebase my branch with this.

-- Steve
