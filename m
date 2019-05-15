Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B53251FCC8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 01:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfEOXad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 19:30:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35343 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfEOX2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 19:28:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id h1so567295pgs.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 16:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VP1NFQHy4JKVhFQCt2SvEPh1FtfBgQTCzFt7PPPiHN0=;
        b=r19YdC+4jFPF4C6oNXLtZiD/yJ01hydYRuZk1MseAZx+4lHCzKKfKNBqPCMiQNgjjw
         y+XUOAL2LYXIoPZ2sDD87sMC4hU7uwfIsW+GbDN3Lxx25GfJYmgqSEwk8laVGuzLl4vX
         0hCVm86fR4TNkcInpQp1gG0DWLrZ0uMAV5XWLtpdvU3qYpnRYRyDd7Fh8z3B5vI8EJtQ
         pXVbEsVbyX6IMqN9PY5FbeJoBScWxUxMuaKgtBq3XMAr17PSL1OzQgkOyr6KfM4rP8BI
         RtKHJFbfs0eeqWp+thjyfqgO9ssQPHOhxUH8I9XKAsaxTsqvDudU6xuThvMRoR4HXqP9
         bu+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VP1NFQHy4JKVhFQCt2SvEPh1FtfBgQTCzFt7PPPiHN0=;
        b=rYvJJLqGg/VW3P/o+DPjiXZembK+pIoloUui5D7e2BcbQPbw1GKHQXz1ihmCY+4qZf
         s05NoouF3Qu15gZ9nVl88YoBXYe4FT3cWqnfuReRM9DTB9h9Fv46zB3cCgQKX59KsEbV
         epbc+RuZDqpt3HdBQj88AjIgkHEPtqVqXWU5hNrYn45UEpS6rxzGhuRqq8q/6IlIlpXT
         2e5khkM1/uFhuMJo8irpFlOWJYj5BxLpyR2+D3F9/qoIR+FI9OX2zZGYuUUQaNe9mWxN
         rZVqTH+M7JKCDT0XpYWVfvGT8xOOa97H5BC6ejlZDH77yLrFZYKbcMdkqEPUqXrTgpGX
         w0Qg==
X-Gm-Message-State: APjAAAVlbsRcKuYfjQBog047w9s6gODUGKM2WgjSNa61sTi3Wl6Gw0+U
        d9Wf5DA/INzAvhb9oe5PPWNL3w==
X-Google-Smtp-Source: APXvYqyfISGJkEneRhKoTrm95W3GwtHgtb8DnEpPiMopvw65z/c6R+ndccT+6r5I+RscVIxx1q1EjQ==
X-Received: by 2002:a62:f247:: with SMTP id y7mr49632055pfl.18.1557962368601;
        Wed, 15 May 2019 16:19:28 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:2:d714:29b4:a56b:b23b])
        by smtp.gmail.com with ESMTPSA id j19sm4304797pfr.155.2019.05.15.16.19.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 15 May 2019 16:19:27 -0700 (PDT)
Date:   Wed, 15 May 2019 16:19:23 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah <shuah@kernel.org>
Cc:     Dhaval Giani <dhaval.giani@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Carpenter,Dan" <dan.carpenter@oracle.com>, willy@infradead.org,
        gustavo.padovan@collabora.co.uk,
        Dmitry Vyukov <dvyukov@google.com>, knut.omang@oracle.com
Subject: Re: Linux Testing Microconference at LPC
Message-ID: <20190515231923.GA193527@google.com>
References: <CAPhKKr_uVTFAzne0QkZFUGfb8RxQdVFx41G9kXRY7sFN-=pZ6w@mail.gmail.com>
 <3c6c9405-7e90-fb03-aa1c-0ada13203980@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c6c9405-7e90-fb03-aa1c-0ada13203980@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 04:44:19PM -0600, shuah wrote:
> Hi Sasha and Dhaval,
> 
> On 4/11/19 11:37 AM, Dhaval Giani wrote:
> > Hi Folks,
> > 
> > This is a call for participation for the Linux Testing microconference
> > at LPC this year.
> > 
> > For those who were at LPC last year, as the closing panel mentioned,
> > testing is probably the next big push needed to improve quality. From
> > getting more selftests in, to regression testing to ensure we don't
> > break realtime as more of PREEMPT_RT comes in, to more stable distros,
> > we need more testing around the kernel.
> > 
> > We have talked about different efforts around testing, such as fuzzing
> > (using syzkaller and trinity), automating fuzzing with syzbot, 0day
> > testing, test frameworks such as ktests, smatch to find bugs in the
> > past. We want to push this discussion further this year and are
> > interested in hearing from you what you want to talk about, and where
> > kernel testing needs to go next.
> > 
> > Please let us know what topics you believe should be a part of the
> > micro conference this year.
> > 
> > Thanks!
> > Sasha and Dhaval
> > 
> 
> A talk on KUnit from Brendan Higgins will be good addition to this
> Micro-conference. I am cc'ing Brendan on this thread.
> 
> Please consider adding it.

Thanks Shuah!

Presumably I should still submit the talk on the website (however, it
looks like the Testing Microconference isn't available as a track option
yet...)? Or is it okay if I just post the proposal here?

Also, for the framing of the talk (assuming people are indeed
interested). I figure people will want an intro along with some
background context, and a discussion of future work. Nevertheless, would
people like more of a demo talk or more of an audience driven discussion
on where we should go and what we should do? Or something else? Really,
I am open to talk about whatever everyone else wants.

For context on KUnit, you can read the LWN article about it here[1], or
you can see the current version of the patchset here[2].

Thanks!

[1] https://lwn.net/Articles/780985/
[2] https://lkml.org/lkml/2019/5/14/834
