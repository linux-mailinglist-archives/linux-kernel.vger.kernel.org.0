Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 143905279B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 11:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbfFYJJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 05:09:39 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35493 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731314AbfFYJJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:09:38 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so623567plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 02:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/xsE8Oljl3nRngapJ6cvpa9DKAM6pp9nHBYJlwN4zFA=;
        b=XsNPVD3TOLq6mbGnPcv7RM4b8uEx0q+XOo/ARsD4ynS5Qam8xoyEO25jzbENhvnfw3
         /stNkW+1n6ob32KKaz5DPDnHdj2nYvd8cKVLHB0EI1O6F8hsh1Yr/hhPqu2GRkQ8eH4e
         TvnaTzHpto5Lt3dFkdws2kkte3ZKGVzfkmy4m2M+DInCd6JuoZlSxR7qQloDJ1XNYncY
         RP2sCGJ+xw3HGgWdy9UnhVOhCq+voelz78es8FMsFzHvU7MI93ypd8eS/P2DAVrTOMXq
         kbokFHZu7V5whwwOOD42FMS/+ZU6qe526lOU1L1Ty3vqDNf1vj4YsBtvh6g9jbSVnv2j
         AlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/xsE8Oljl3nRngapJ6cvpa9DKAM6pp9nHBYJlwN4zFA=;
        b=AoXnSFf6+Qn5j6aJiVYmW5K1lub1I/a8NR6NaWQdiWm6iKHKspHpBJTVEsWSJQ04Vp
         WnkPbQsl4r10sCOWZYqWwgDXJhMe/VdWl1viKIk17XAo/3VDtJs8tinfiBn5+4lGq0XP
         uE4iktLRAJAimxt2GqXahwwMXIg1C9iaYchd8ERzzbbshs5UU31eSyKdlcq4+gpGZks+
         qt1ApnN75eBipdDW945vAHyNyRLnj5DXrhbfzur//rimQCqlB4zko9cBCfU7dQGEcRew
         w/Ffb/nnkfVMqHRGlh5TKg+ZJM6nsTWvCSNxdREmBg+ccaDAGsY3GlkpsDTuhMW6gbME
         7hkA==
X-Gm-Message-State: APjAAAURtVk2gVRaemZChikAA+1oNjvyhAv9paZDhBrye+j2ghWT+Q3B
        oxTwjutqpIyexK62FU+z664=
X-Google-Smtp-Source: APXvYqy2SXifW9Wh+TIZjJEBWxUvzzZzLLa3dxQOfAQm3G/mPhgXCx6lvNnUV8I20uwZlx3IYvcPZQ==
X-Received: by 2002:a17:902:a9cb:: with SMTP id b11mr15020053plr.69.1561453778061;
        Tue, 25 Jun 2019 02:09:38 -0700 (PDT)
Received: from localhost ([175.223.22.38])
        by smtp.gmail.com with ESMTPSA id f197sm13990109pfa.161.2019.06.25.02.09.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 02:09:37 -0700 (PDT)
Date:   Tue, 25 Jun 2019 18:09:34 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer
 implementation
Message-ID: <20190625090934.GC532@jagdpanzerIV>
References: <20190607162349.18199-1-john.ogness@linutronix.de>
 <20190607162349.18199-2-john.ogness@linutronix.de>
 <20190618045117.GA7419@jagdpanzerIV>
 <87imt2bl0k.fsf@linutronix.de>
 <20190625064543.GA19050@jagdpanzerIV>
 <20190625071500.GB19050@jagdpanzerIV>
 <875zoujbq4.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zoujbq4.fsf@linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/25/19 10:44), John Ogness wrote:
> > In vprintk_emit(), are we going to always reserve 1024-byte
> > records, since we don't know the size in advance, e.g.
> > 
> > 	printk("%pS %s\n", regs->ip, current->name)
> > 		prb_reserve(&e, &rb, ????);
> > 
> > or are we going to run vscnprintf() on a NULL buffer first,
> > then reserve the exactly required number of bytes and afterwards
> > vscnprintf(s) -> prb_commit(&e)?
> 
> (As suggested by Petr) I want to use vscnprintf() on a NULL
> buffer. However, a NULL buffer is not sufficient because things like the
> loglevel are sometimes added via %s (for example, in /dev/kmsg). So
> rather than a NULL buffer, I would use a small buffer on the stack
> (large enough to store loglevel/cont information). This way we can use
> vscnprintf() to get the exact size _and_ printk_get_level() will see
> enough of the formatted string to parse what it needs.

OK. I guess this should work except for the cases when we want to
printk that we are running out of stack :)

More seriously, tho, sometimes messages come with dictionaries of
key/value pairs. I don't think we impose any strict limits on the
number of key/value pair or on the overall size of the dictionary
each record can have (up to a single PAGE, I'd guess. I really need
to check printk code). Finding a sufficiently large buffer size
might be a bit of a task.

> > I'm asking this because, well, if the most common usage
> > pattern (printk->prb_reserve) will always reserve fixed
> > size records (aka data blocks), then you _probably_ (??)
> > can drop the 'variable size records' requirement from prb
> > design and start looking at records (aka data blocks) as
> > fixed sized chunks of bytes, which are always located at
> > fixed offsets.
>
> The average printk message size is well under 128 bytes.

Do you also count in dictionary of properties (key/value pairs) which
records can carry?

For printks from core kernel 128 bytes would be a good estimation,
for dev_printk() and so on - I'm not exactly sure.

cat /dev/kmsg

This one, for instance, is a single logbuf record

6,560,2470340,-;hid-generic 0003:093A:2510.0001: input,hidraw0: USB HID v1.11 Mouse [PixArt USB Optical Mouse] on usb-0000:00:14.0-3/input0
 SUBSYSTEM=hid
 DEVICE=+hid:0003:093A:2510.0001

I suspect that it's larger than 128 bytes.

> It would be quite wasteful to always reserve 1K blocks.

Agreed.

	-ss
