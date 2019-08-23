Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8859AD1E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 12:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387970AbfHWK3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 06:29:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:53940 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726142AbfHWK3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:29:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 49845ACB4;
        Fri, 23 Aug 2019 10:29:03 +0000 (UTC)
Date:   Fri, 23 Aug 2019 12:29:02 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: comments style: Re: [RFC PATCH v4 1/9] printk-rb: add a new
 printk ringbuffer implementation
Message-ID: <20190823102902.c2l2h3qinykrcmep@pathway.suse.cz>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-2-john.ogness@linutronix.de>
 <20190820085554.deuejmxn4kbqnq7n@pathway.suse.cz>
 <20190820092731.GA14137@jagdpanzerIV>
 <87a7c3f4uj.fsf@linutronix.de>
 <20190823055445.GA7195@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823055445.GA7195@jagdpanzerIV>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-08-23 14:54:45, Sergey Senozhatsky wrote:
> On (08/21/19 07:46), John Ogness wrote:
> [..]
> > The labels are necessary for the technical documentation of the
> > barriers. And, after spending much time in this, I find them very
> > useful. But I agree that there needs to be a better way to assign label
> > names.
> [..]
> > > Where dp stands for descriptor push. For dataring we can add a 'dr'
> > > prefix, to avoid confusion with desc barriers, which have 'd' prefix.
> > > And so on. Dunno.
> > 
> > Yeah, I spent a lot of time going in circles on this one.
> [..]
> > I hope that we can agree that the labels are important. And that a
> > formal documentation of the barriers is also important. Yes, they are a
> > lot of work, but I find it makes it a lot easier to go back to the code
> > after I've been away for a while. Even now, as I go through your
> > feedback on code that I wrote over a month ago, I find the formal
> > comments critical to quickly understand _exactly_ why the memory
> > barriers exist.
> 
> Yeah. I like those tagsi/labels, and appreciate your efforts.
> 
> Speaking about it in general, not necessarily related to printk patch set.
> With or without labels/tags we still have to grep. But grep-ing is much
> easier when we have labels/tags. Otherwise it's sometimes hard to understand
> what to grep for - _acquire, _relaxed, smp barrier, write_once, or
> anything else.

Grepping is not needed when function names are used in the comment
and cscope might be used. Each function should be short
and easy enough so that any nested label can be found by eyes.

A custom script is an alternative but it would be better to use
existing tools.

In each case, two letter labels would get redundant sooner or later
when the semantic gets used widely. And I hope that we use a semantic
that is going to be used widely.

> > Perhaps we should choose labels that are more clear, like:
> > 
> >     dataring_push:A
> >     dataring_push:B
> > 
> > Then we would see comments like:
> > 
> >     Memory barrier involvement:
> > 
> >     If _dataring_pop:B reads from dataring_datablock_setid:A, then
> >     _dataring_pop:C reads from dataring_push:G.
> [..]
> >     RELEASE from dataring_push:E to dataring_datablock_setid:A
> >        matching
> >     ACQUIRE from _dataring_pop:B to _dataring_pop:E
> 
> I thought about it. That's very informative, albeit pretty hard to maintain.
> The same applies to drA or prA and any other context dependent prefix.

The maintenance is my concern as well. The labels should be primary
for an automatized consistency checker. They make sense only when
they are in sync with the code.

Best Regards,
Petr
