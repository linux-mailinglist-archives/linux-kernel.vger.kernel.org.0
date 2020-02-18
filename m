Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46C5D16370C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 00:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgBRXRh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Feb 2020 18:17:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:39324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727635AbgBRXRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 18:17:36 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4A1C206F4;
        Tue, 18 Feb 2020 23:17:35 +0000 (UTC)
Date:   Tue, 18 Feb 2020 18:17:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] #MC mess
Message-ID: <20200218181734.703038e1@gandalf.local.home>
In-Reply-To: <3CF4895A-5BCF-4E5C-B8D9-F9019DD02A12@amacapital.net>
References: <3908561D78D1C84285E8C5FCA982C28F7F57B937@ORSMSX115.amr.corp.intel.com>
        <3CF4895A-5BCF-4E5C-B8D9-F9019DD02A12@amacapital.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 15:10:17 -0800
Andy Lutomirski <luto@amacapital.net> wrote:

> > On Feb 18, 2020, at 10:20 AM, Luck, Tony <tony.luck@intel.com> wrote:
> > 
> > ﻿  
> >> 
> >> Anything else I'm missing? It is likely...  
> > 
> > +    hw_breakpoint_disable();
> > +    static_key_disable(&__tracepoint_read_msr.key);
> > +    tracing_off();
> > +
> >    ist_enter(regs);
> > 
> > How about some code to turn all those back on for a recoverable (where we actually recovered) #MC?
> > 
> >   
> 
> 
> At the very least, in the user_mode(regs) case, tracing is fine.

Also, I don't think "tracing_off()" is what is wanted here. That just
disables writing to the ring buffer, which can be called in pretty much
any context (if it's before in_nmi() get's set, the worse thing that
happens is that events will get dropped due to the recursion protection
that checks to make sure there's no re-entrant events at the same level
of context).

The only issue with having function tracing enabled, is that it may add
a breakpoint when it gets turned on or off. And that tracing_off()
doesn't prevent that.

tracepoints still use RCU of some kind, and the protection there has
nothing to do with whether a trace point does recording or not.

-- Steve
