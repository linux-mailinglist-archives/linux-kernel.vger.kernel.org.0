Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07E4316364B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 23:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgBRWl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 17:41:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:60010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbgBRWl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 17:41:26 -0500
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FAE12173E;
        Tue, 18 Feb 2020 22:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582065686;
        bh=fr+Sb3VDOv2X+vL7GEwYooziLBNmezLRth4YeApzMp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wAB6hjeEGnf2RV7nt4qfw/cO9gc8ZhyADYkt6MyKR4jok+XraDYagNgrTvEPylDje
         OzaVf16wNKG8gUWGbi1gp9ly0qlZo1gpI66ULB9zb7znCi0qUMAYMcLPcZI3RORk5V
         whHknD9md+U6DAiOGg438050JJpzt5e0mxjuQGEc=
Date:   Tue, 18 Feb 2020 23:41:23 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, paulmck@kernel.org
Subject: Re: [RFC] #MC mess
Message-ID: <20200218224123.GB13978@lenoir>
References: <20200218173150.GK14449@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F57B937@ORSMSX115.amr.corp.intel.com>
 <20200218200200.GE11457@worktop.programming.kicks-ass.net>
 <3908561D78D1C84285E8C5FCA982C28F7F57BDFB@ORSMSX115.amr.corp.intel.com>
 <20200218203404.GI11457@worktop.programming.kicks-ass.net>
 <20200218214904.GD11802@worktop.programming.kicks-ass.net>
 <20200218215325.GE11802@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218215325.GE11802@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 10:53:25PM +0100, Peter Zijlstra wrote:
> On Tue, Feb 18, 2020 at 10:49:04PM +0100, Peter Zijlstra wrote:
> > diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
> > index da0af631ded5..146332764673 100644
> > --- a/include/linux/hardirq.h
> > +++ b/include/linux/hardirq.h
> > @@ -71,7 +71,7 @@ extern void irq_exit(void);
> >  		printk_nmi_enter();				\
> >  		lockdep_off();					\
> >  		ftrace_nmi_enter();				\
> > -		BUG_ON(in_nmi());				\
> > +		BUG_ON(in_nmi() == 0xf);			\
> 
> That wants to be:
> 
> 		BUG_ON(in_nmi() == NMI_MASK);			\

Ah that's the email I didn't read...
Sorry for the noise.
