Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0D64E7E2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 14:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfFUMRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 08:17:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37184 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfFUMRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 08:17:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id v14so6378670wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 05:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VViufnhkk9Q+Cc+Ah/mrAoTSgBMhZKq9tL/vgWAqr+4=;
        b=huF4BV7qLSAFkVBBOF2Frok/B9JTFxFb7nftqk4k0XrbGdNVoIXs7S46mNudg7Zbc4
         hdXciGVrmr60AMFrbguv/KsVAatrblOSyFGL4UAPoq1d7+gIdy8hYH9vMfaDzxe1Oik6
         nS3Dhl1bFo3IKkQsKvwv33OR8PEYJGnT3kK0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VViufnhkk9Q+Cc+Ah/mrAoTSgBMhZKq9tL/vgWAqr+4=;
        b=Iyb+J//TDmAz/Geu6N5REfy7TAh37bUgw4uRocUgTANxjUL2t135ZthMhKUt5D/VWH
         luBfSWd4cdjAd9LhE0sgA0oEk99EkHAZiC28ipWpOUYM6J1W8qlrjv/w1PQhYPIE57ib
         Gy0+5AjqaA2JyZiB/z7ADiqbOt83+uxjEMO7vYWCbmLD4U09NbcmARmj90rJdc2rV5MI
         SEQpWrGoa2sQq4cHE3RC22FUhEBupgXpaSsgbT3mqo7nNDsivzJbRy6XEmh1wsGs9h3s
         RJCZkTfnF8alDw1moqt9f8HSLXVq/DGqXL/v3xVAkLbD2Pmc3OnSH9IwdkpVz9C4fDLK
         lqEQ==
X-Gm-Message-State: APjAAAU5DdPlT+Dt6252oG2JCAXZaolPzCiD57Rp0NDZLrF6B26oMjT0
        f8byaZsbFwwWZpOPUBRVYLYcfA==
X-Google-Smtp-Source: APXvYqxQ0SoCYUdHTDXwfXXXvlUzsiiPyA3rr+Pgk0f4sGCWXIupKy2ymoNynC0OD4471a+7phrrSQ==
X-Received: by 2002:adf:81c9:: with SMTP id 67mr25178358wra.62.1561119419744;
        Fri, 21 Jun 2019 05:16:59 -0700 (PDT)
Received: from andrea (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id l19sm1649602wmj.33.2019.06.21.05.16.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 05:16:59 -0700 (PDT)
Date:   Fri, 21 Jun 2019 14:16:53 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer
 implementation
Message-ID: <20190621121653.GA9473@andrea>
References: <20190607162349.18199-1-john.ogness@linutronix.de>
 <20190607162349.18199-2-john.ogness@linutronix.de>
 <20190618112237.GP3436@hirez.programming.kicks-ass.net>
 <87a7eebk71.fsf@linutronix.de>
 <20190619104655.GA6668@andrea>
 <87fto327ne.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fto327ne.fsf@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > FWIW (and as anticipated time ago in a private email), when I see code
> > like this I tend to look elsewhere...  ;-/
> 
> Do you really mean "code" or are you just referring to "code comments"?
> If you really mean code, then I'd appreciate some feedback about what
> should change.

I really just meant "uncommented code".  ;-)  I do plan to read your:

  https://lkml.kernel.org/r/87k1df28x4.fsf@linutronix.de

(and the code it's referring to) with due calm in the following days.
Thank you in advance for these remarks.

[Trying to address your question about herd7,]

A list of supported primitives is available from:

  tools/memory-model/linux-kernel.def	(left column)

This includes cmpxchg() (and its variants: _relaxed(), _acquire() and
_release()), however, herd7 can currently only parse statements like:

  loc_var = cmpxchg(addr, old, new);

(and it will complain loudly without that "loc_var = " part...); this
is something that could be improved, or at least it seems this way...

A similar consideration holds for all the value-returning primitives.

Thanks,
  Andrea
