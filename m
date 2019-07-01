Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB514C06E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 20:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfFSSBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 14:01:49 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36394 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfFSSBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 14:01:49 -0400
Received: by mail-qt1-f195.google.com with SMTP id p15so91460qtl.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 11:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=czuVT35co/UKsceghDoTiQ4oToGLTSbKhMCQO4t0nUE=;
        b=t0FlsK0r8Bx/f9E7kd+SWF3OofIkorm0DUUph6+DeKYxZhH1U3WrRKGKsUCk/Pyopt
         ZCT4v3iUv9Slj1G3/LFS8XXYQScHawo96l+KvR62BUI+LZW4DW0mmeWApJs9FDNP++8I
         hFpVtgUjorb6GvON/zvOaNk274fAgQ610pRPN2d8a4ZKqk8kp+mg4CWTC6mpLM86PjQ8
         XQAQR8lUeFq+t9e937A5exioDrUzLZyGlsUA3MmCnYYQGGAAR8l4OPQOKfPU5Y4qSyMC
         eK0t9B/HM1zZyai4w8BO0Uovj73EoB72CeT5TBW4CNjFngXdTBAOLDwWPhtfkUyXyZmW
         reXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=czuVT35co/UKsceghDoTiQ4oToGLTSbKhMCQO4t0nUE=;
        b=l+QIlCo8o3Haw055+4wZrAW65Ae4sFf9VwD7P1swqHG9hw4dBTDw1rKO8ZvD+DGP0c
         xcIN6CFwjsjuWWa/0NE31bFYCbEW/nCSwdz5XI9Er5Rg252FxoJ1FEIDOXv1Z7VNjqs8
         vKTuawCXAqZFNj9kJutqTEvCS6amCv/JjSzQobFKFli1hAp/tGZCqJWa2tEl9/r4xEnG
         s14thX/0DnMWrfwhnnsYK+1B856EeMbh3T8p9x102QZpyya9Ftl2+KY9Dz1RdDMVw7Vb
         d43cUbNFzdtp6Q+mhE7l46pZdfU1jzdB7Zmix0U0YhkFQ+tihjlkgNfWrSHeTSp/K5YZ
         Gntw==
X-Gm-Message-State: APjAAAW23p+KWiaXjdyFWqrBxdDqpjSWA1cUHHhuZ+o7n/EQ0EDmhRsE
        pGFpLK8+ExGXlhtKdCqwLTM2e+/CIucmZwtRd2MwVg==
X-Google-Smtp-Source: APXvYqxeZ4O/kaqZoo3nciU9wlzuTKsySBSeoLaF/GcKUrg0k12S8Nc/w6joJpYVh9NOpJ72bTjl+T69A/gi1ERuRUk=
X-Received: by 2002:ac8:1ba9:: with SMTP id z38mr18306346qtj.176.1560967308199;
 Wed, 19 Jun 2019 11:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <CANA+-vCThdRivg7nrMK5QoFu8SGUzEVSvSyp0H2CPyy9==Tqog@mail.gmail.com>
 <CANA+-vARQ9Ao=W1oEArrAQ0sqh757orq=-=kytdVPhstm-3E9w@mail.gmail.com>
 <20190618182502.GC203031@google.com> <4587569.x9DSL43cXO@kreacher>
 <CANA+-vCMK6u1n9gXf2+v5dFn_tGfr1PT8d7W4d2BCzw+B-HvYw@mail.gmail.com>
 <CAJWu+oo7kwmEyMXQN0yfswV2=J-Fa9QybhAUx-SOGG_ipsBErQ@mail.gmail.com>
 <CAJZ5v0gvzCx-7qS9qkxB=sGKjQJKMR7yCc21f=_vqrbZxMSWNg@mail.gmail.com>
 <CAJWu+oqSgcBVhDY7CjWpNQrK=XiKAb5S-YSp=6-UM--UFmKvGQ@mail.gmail.com> <20190619170750.GB10107@kroah.com>
In-Reply-To: <20190619170750.GB10107@kroah.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Wed, 19 Jun 2019 14:01:36 -0400
Message-ID: <CAJWu+ookFTYGfSvJ3otpFQixG2kbkJGOqf7HHUeYNQAQv2Cskw@mail.gmail.com>
Subject: Re: Alternatives to /sys/kernel/debug/wakeup_sources
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Tri Vo <trong@android.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sandeep Patil <sspatil@android.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 1:07 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jun 19, 2019 at 12:53:12PM -0400, Joel Fernandes wrote:
> > > It is conceivable to have a "wakeup_sources" directory under
> > > /sys/power/ and sysfs nodes for all wakeup sources in there.
> >
> > One of the "issues" with this is, now if you have say 100 wake up
> > sources, with 10 entries each, then we're talking about a 1000 sysfs
> > files. Each one has to be opened, and read individually. This adds
> > overhead and it is more convenient to read from a single file. The
> > problem is this single file is not ABI. So the question I guess is,
> > how do we solve this in both an ABI friendly way while keeping the
> > overhead low.
>
> How much overhead?  Have you measured it, reading from virtual files is
> fast :)

I measured, and it is definitely not free. If you create and read a
1000 files and just return a string back, it can take up to 11-13
milliseconds (did not lock CPU frequencies, was just looking for
average ball park). This is assuming that the counter reading is just
doing that, and nothing else is being done to return the sysfs data
which is probably not always true in practice.

Our display pipeline deadline is around 16ms at 60Hz. Conceivably, any
CPU scheduling competion reading sysfs can hurt the deadline. There's
also the question of power - we definitely have spent time in the past
optimizing other virtual files such as /proc/pid/smaps for this reason
where it spent lots of CPU time.

> And how often does this happen?  Does it _need_ to happen?

These are good questions and we should find out. I am not saying that
sysfs will not work, I am just saying we need to consider all the
things. I will let Tri look into this since he is working on it, I
don't know off the top.

> Parsing files is also hard, and not for sysfs files, you can't have it
> both ways.

I don't think we are concerned with a parsing issue here, or are
discussing it in this thread.

> So try it this way, and if there really is a performance issue, we can
> then talk about it...

Sure that sounds good to me, again I am not saying we should do sysfs.
But we should consider all the issues and chose the right solution.

thanks!

 - Joel
