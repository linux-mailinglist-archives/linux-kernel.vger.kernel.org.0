Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55F6D49A86
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 09:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbfFRH1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 03:27:03 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45953 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfFRH1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:27:02 -0400
Received: by mail-ot1-f67.google.com with SMTP id x21so12875037otq.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 00:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WXMMpkWgHtvIKrWn0u/ts00b6Lb6kQODjgea6xZRVcw=;
        b=n5jTttpSsnSSG7S26mLiVp5ec3nC7Bt+bhUQyYdTmCUjLaZwGPWLz7fyZBNw7zeOaQ
         sMo0qvQTegsDTriJ1ICI+19PLMnxshzOyaDNyBvTwO8HpR/iesnD8KX2n4TjyDdSY69I
         i+u0yI5cdtXzXLRFxt8aVcgUsiPmCb2zC9yxTxRhVsEkApQEh2KBwj+HPYRfCnItBGAx
         pBVOn/TkD5PicrxHK6a5ME1ldYsk2lWufUmKR6lfzoRh8jAQ9J8Mrl8+LKPap1nCE7us
         ugBYqCm3en1TOprMdhILg93HVxQHnQRohrAgWnNy4oREGYqWZ62gEIkT53sJva9KnXow
         dglQ==
X-Gm-Message-State: APjAAAXnQYT+Q10dRen+EebSjMOw7aL+GNvPbNWMiTVmzTNYgbm7WvqI
        1G7J5YZwlFIRdEHt63wjO8oo8P6XPcnixP1N05h9jg==
X-Google-Smtp-Source: APXvYqwke2xjjx1AZHLnrRefbJOHRCLETEFTG3lTZNDnnJFIbMW80Fxo4vmtR84qlwuTR8+IB88zKsZ1Ila9DGVQJ4g=
X-Received: by 2002:a9d:61c7:: with SMTP id h7mr5305782otk.357.1560842821877;
 Tue, 18 Jun 2019 00:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <b477ac75a2b163048bdaeb37f57b4c3f04f75a31.1559631700.git.viresh.kumar@linaro.org>
 <20190605091644.w3g7hc7r3eiscz4f@queper01-lin> <20190606025204.qe5v7j6fysjkgxc6@vireshk-i7>
 <20190617150204.GG3436@hirez.programming.kicks-ass.net> <20190618031217.63md32da5pzydqia@vireshk-i7>
In-Reply-To: <20190618031217.63md32da5pzydqia@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Jun 2019 09:26:49 +0200
Message-ID: <CAJZ5v0g4shiz+Hq+0fS1GQjQX7tK5EyLiX-SOpDoTm4xswV8bg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Introduce fits_capacity()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 5:12 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> +Rafael
>
> On 17-06-19, 17:02, Peter Zijlstra wrote:
> > On Thu, Jun 06, 2019 at 08:22:04AM +0530, Viresh Kumar wrote:
> > > Hmm, even if the values are same currently I am not sure if we want
> > > the same for ever. I will write a patch for it though, if Peter/Rafael
> > > feel the same as you.
> >
> > Is it really the same variable or just two numbers that happen to be the
> > same?
>
> In both cases we are trying to keep the load under 80% of what can be supported.
> But I am not sure of the answer to your question.
>
> Maybe Rafael knows :)

Which variable?
