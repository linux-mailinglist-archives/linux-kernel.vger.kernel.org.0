Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9122BE21F8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 19:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbfJWRmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 13:42:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731112AbfJWRmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 13:42:22 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E592721872;
        Wed, 23 Oct 2019 17:42:20 +0000 (UTC)
Date:   Wed, 23 Oct 2019 13:42:19 -0400
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
Message-ID: <20191023134219.33e41458@gandalf.local.home>
In-Reply-To: <20191023122307.756b4978@gandalf.local.home>
References: <CAADnVQLn+Fh-UgSRD9SZCT7WYOez5De04iCZucYbA9mYxPm2AQ@mail.gmail.com>
        <20191021231630.49805757@oasis.local.home>
        <20191021231904.4b968dc1@oasis.local.home>
        <20191022040532.fvpxcs74i4mn4rc6@ast-mbp.dhcp.thefacebook.com>
        <20191022071956.07e21543@gandalf.local.home>
        <20191022094455.6a0a1a27@gandalf.local.home>
        <20191022175052.frjzlnjjfwwfov64@ast-mbp.dhcp.thefacebook.com>
        <20191022141021.2c4496c2@gandalf.local.home>
        <20191022204620.jp535nfvfubjngzd@ast-mbp.dhcp.thefacebook.com>
        <20191022170430.6af3b360@gandalf.local.home>
        <20191022215841.2qsmhd6vxi4mwade@ast-mbp.dhcp.thefacebook.com>
        <20191023122307.756b4978@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2019 12:23:06 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> All you need to do is:
> 
> 	register_ftrace_direct((unsigned long)func_you_want_to_trace,
> 			       (unsigned long)your_trampoline);
> 


> 
> Alexei,
> 
> Would this work for you?

I just pushed a test branch up to:

 git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git

 branch: ftrace/direct

Again, it's mostly development code, and may be buggy. (don't try
tracing when a direct function is added yet).

If this is something that you can use, then I'll work to clean it up
and sort out all the bugs.

Thanks!

-- Steve
