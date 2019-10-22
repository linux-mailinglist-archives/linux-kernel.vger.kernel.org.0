Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14BDADFC24
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 05:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbfJVDQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 23:16:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:55688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730156AbfJVDQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 23:16:33 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04F7E20882;
        Tue, 22 Oct 2019 03:16:31 +0000 (UTC)
Date:   Mon, 21 Oct 2019 23:16:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 3/3] x86/ftrace: Use text_poke()
Message-ID: <20191021231630.49805757@oasis.local.home>
In-Reply-To: <CAADnVQLn+Fh-UgSRD9SZCT7WYOez5De04iCZucYbA9mYxPm2AQ@mail.gmail.com>
References: <20190827180622.159326993@infradead.org>
        <20190827181147.166658077@infradead.org>
        <aaffb32f-6ca9-f9e3-9b1a-627125c563ed@redhat.com>
        <20191002182106.GC4643@worktop.programming.kicks-ass.net>
        <20191003181045.7fb1a5b3@gandalf.local.home>
        <20191004112237.GA19463@hirez.programming.kicks-ass.net>
        <20191004094228.5a5774fe@gandalf.local.home>
        <CAADnVQJ0cWYPY-+FhZoqUZ8p1k1FiDsO5jhXiQdcCPmd1UeCyQ@mail.gmail.com>
        <20191021204310.3c26f730@oasis.local.home>
        <CAADnVQLn+Fh-UgSRD9SZCT7WYOez5De04iCZucYbA9mYxPm2AQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 20:10:09 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Mon, Oct 21, 2019 at 5:43 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Mon, 21 Oct 2019 17:36:54 -0700
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >
> >  
> > > What is the status of this set ?
> > > Steven, did you apply it ?  
> >
> > There's still bugs to figure out.  
> 
> what bugs you're seeing?
> The IPI frequency that was mentioned in this thread or something else?
> I'm hacking ftrace+bpf stuff in the same spot and would like to
> base my work on the latest and greatest.

There's real bugs (crashes), talked about in later versions of the
patch set:

 https://lore.kernel.org/r/20191009224135.2dcf7767@oasis.local.home

And there was another crash on Peter's latest I just reported:

 https://lore.kernel.org/r/20191021222110.49044eb5@oasis.local.home

-- Steve
