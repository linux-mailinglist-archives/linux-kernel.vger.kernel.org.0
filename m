Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B02F52425
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 09:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfFYHPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 03:15:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41127 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfFYHPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:15:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id m7so8313805pls.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 00:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XBAS77SnDEn6/c+72CpzDqgrxkR4+1Ojlvnum36Pcm4=;
        b=r5wwRks5owCCYgV9IqgesMk5m5D2G7oV1hr9gwnsZkjEpvgVBqbCzXVDtDqCEpX9tg
         i2+8ZY/3Hq6TE541qK8lUOfvd33WFhy8nLpzALQIZ6Vs2LlotDhIkwhXmvRCQNxOqi41
         lPAV/A02FjsSWrsuUEgHID2B3j4PvEIGrQY5a8DbwaiG/BBnFILNF4Ojv6a4cx/Pp2KX
         pUHyF7IcSI1C7EZy8BYWlQoOPQtWKgbECf+NVd6UXq6cshPYwUtuIchMMw4yIOHqbxmg
         jGLeHPaGHQIxuOAD5mNmgcM7Yy4DVEfpD1KgN2wgS+qc7ix4Pe1Qa4x15SQcumZR7WCd
         1F8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XBAS77SnDEn6/c+72CpzDqgrxkR4+1Ojlvnum36Pcm4=;
        b=S7YPZrmFgQBlC6KH3FP0POMdm8pTR2ciBrMh3EgaNBjIWomz9Fsro6Zx87uydfQbcd
         /fEB1DIc4dio9J4YmK+1mtvsWH7RMnNmTkILWxEgOhEroD31DRZSsRXQc25j0DsZYI5C
         vV/H3Gi1McaxtO51fMgOZsVd86QxwJtYpLRbXTWN6oNDXCKxoV8e8PYG1mdR9f+tE2Pv
         tclHTcvoQjT0yu+96PzIcaS72qVjaSveYzmWCjxhRoYY9Kt94UO5MVFTKObMomoPIjLB
         6ngANLTwe/+xje4AYxGMcAcdZDl16RCLmuQNiJofLsad7Yd3ilN/xVnFApjZsholsnom
         +w1A==
X-Gm-Message-State: APjAAAU0FIiy00+7XynPHsYfjmgbFovBXW0Dv2ku/SEHJdSQoQiJL5Ea
        7ZrZl85xBAZ30K6O46bhN8g=
X-Google-Smtp-Source: APXvYqzvUxAMbDAJxRBrVAd2z78xp10Xk6Jzo6FGYgc/TQfXESt7o3C741cRggPPAdZ7brtO4KARGQ==
X-Received: by 2002:a17:902:8205:: with SMTP id x5mr55000165pln.279.1561446905362;
        Tue, 25 Jun 2019 00:15:05 -0700 (PDT)
Received: from localhost ([175.223.22.38])
        by smtp.gmail.com with ESMTPSA id 131sm21076186pfx.57.2019.06.25.00.15.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 00:15:04 -0700 (PDT)
Date:   Tue, 25 Jun 2019 16:15:00 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer
 implementation
Message-ID: <20190625071500.GB19050@jagdpanzerIV>
References: <20190607162349.18199-1-john.ogness@linutronix.de>
 <20190607162349.18199-2-john.ogness@linutronix.de>
 <20190618045117.GA7419@jagdpanzerIV>
 <87imt2bl0k.fsf@linutronix.de>
 <20190625064543.GA19050@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625064543.GA19050@jagdpanzerIV>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/25/19 15:45), Sergey Senozhatsky wrote:
> On (06/19/19 00:12), John Ogness wrote:
> > On 2019-06-18, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> > >> +	struct prb_reserved_entry e;
> > >> +	char *s;
> > >> +
> > >> +	s = prb_reserve(&e, &rb, 32);
> > >> +	if (s) {
> > >> +		sprintf(s, "Hello, world!");
> > >> +		prb_commit(&e);
> > >> +	}
> > >
> > > A nit: snprintf().
> > >
> > > sprintf() is tricky, it may write "slightly more than was
> > > anticipated" bytes - all those string_nocheck(" disabled"),
> > > error_string("pK-error"), etc.
> > 
> > Agreed. Documentation should show good examples.
> 
> In vprintk_emit(), are we going to always reserve 1024-byte
> records, since we don't know the size in advance, e.g.
> 
> 	printk("%pS %s\n", regs->ip, current->name)
> 		prb_reserve(&e, &rb, ????);
> 
> or are we going to run vscnprintf() on a NULL buffer first,
> then reserve the exactly required number of bytes and afterwards
> vscnprintf(s) -> prb_commit(&e)?

I'm asking this because, well, if the most common usage
pattern (printk->prb_reserve) will always reserve fixed
size records (aka data blocks), then you _probably_ (??)
can drop the 'variable size records' requirement from prb
design and start looking at records (aka data blocks) as
fixed sized chunks of bytes, which are always located at
fixed offsets.

	-ss
