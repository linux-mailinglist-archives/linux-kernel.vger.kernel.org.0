Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1E24C0CD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 20:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbfFSScH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 14:32:07 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37637 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfFSScG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 14:32:06 -0400
Received: by mail-ot1-f66.google.com with SMTP id s20so32824otp.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 11:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wO9u4EvDoBIegIfL8MLoH5Q9wxbjVMWquYjqBDeWjN4=;
        b=E8/O5TlhA1d+ayZUTgQslx4ZiA+Q027+bw2+Xp9uCtbeVn264NHS8BdKeYVAXlPEW2
         SNzA3SwsMvflcnUPUChz0KfpziO4Sevl6hSzELWVLn/k/NwLWBLxz0vuVtLjYdiRtj6N
         A2Pp/YUBu2ZZk2btgrD9dJY8Ag4lLkcohkieR+T5f8qDvyyvG9VL4iuocMjuZRea/MSV
         /2A90dLrRuM6MT7iYt6+EUsXgzDw0HkDRdsSTsArePyqjfOTEuxn9gdRx1lFSh7+HXC9
         vbC3NQGEgAEv4mrM1d6AH/k2s3oqULwuG3anvWRDkWt1uLBuqbroTXWHG3Atwzto6QfG
         hzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wO9u4EvDoBIegIfL8MLoH5Q9wxbjVMWquYjqBDeWjN4=;
        b=JKNEMb9RcWqgomdWRuo3pT4hK4fdqANXJnGjmHaF8+HtZwb0iRWTH3y5oFSWLGGmFI
         KsI53iPnf+p4psf3X4R6G5YlEFp9Eego6iAMsHhOTNgugSMNp1bj2lfoF+KZQ0/+BVXa
         45q2t33C2wUV/jCJLC0VUAzCI4I1iK9haebLyNyEvSEXitOYFFUCgB5zi/AmRIWoAB13
         0yAUx3p8mUOYljnTlEfUbh8HwmdIIJ7Ts0emBn3+sf7mP1FOLXPMXUgVf/LB7twDVnry
         BEuR3/Lo8ZH2oPjJYbTiJ3BOceSY/0LsJwLgytBeEs7idLMOy/zNJmyXwX2QmekI9H2t
         ECYA==
X-Gm-Message-State: APjAAAWRewyrMUQKm8vnYRvPpL5bBg22fD+qeeIL98Cgv8ksyynD5KqO
        roiPmlCxoqth5Iyr6zGtL4AqmzEisJtvggN1jB+83w==
X-Google-Smtp-Source: APXvYqyOklUba5DnE7uTOw3xbq3z/vy6a1VPKHBI9C95LnZnP/utPhUOBZGGZR5pP8ostOSRSSNgeJah2UNFySrz31A=
X-Received: by 2002:a9d:7a45:: with SMTP id z5mr1589758otm.197.1560969125109;
 Wed, 19 Jun 2019 11:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <CANA+-vCThdRivg7nrMK5QoFu8SGUzEVSvSyp0H2CPyy9==Tqog@mail.gmail.com>
 <CANA+-vARQ9Ao=W1oEArrAQ0sqh757orq=-=kytdVPhstm-3E9w@mail.gmail.com>
 <20190618182502.GC203031@google.com> <4587569.x9DSL43cXO@kreacher>
 <CANA+-vCMK6u1n9gXf2+v5dFn_tGfr1PT8d7W4d2BCzw+B-HvYw@mail.gmail.com>
 <CAJWu+oo7kwmEyMXQN0yfswV2=J-Fa9QybhAUx-SOGG_ipsBErQ@mail.gmail.com>
 <CAJZ5v0gvzCx-7qS9qkxB=sGKjQJKMR7yCc21f=_vqrbZxMSWNg@mail.gmail.com>
 <CAJWu+oqSgcBVhDY7CjWpNQrK=XiKAb5S-YSp=6-UM--UFmKvGQ@mail.gmail.com>
 <20190619170750.GB10107@kroah.com> <CAJWu+ookFTYGfSvJ3otpFQixG2kbkJGOqf7HHUeYNQAQv2Cskw@mail.gmail.com>
In-Reply-To: <CAJWu+ookFTYGfSvJ3otpFQixG2kbkJGOqf7HHUeYNQAQv2Cskw@mail.gmail.com>
From:   Tri Vo <trong@android.com>
Date:   Wed, 19 Jun 2019 11:31:54 -0700
Message-ID: <CANA+-vDvepXj_+6eLKD06J5ezP2jKZ5uTntST-kM3=ZLDMCWCg@mail.gmail.com>
Subject: Re: Alternatives to /sys/kernel/debug/wakeup_sources
To:     Joel Fernandes <joelaf@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Wed, Jun 19, 2019 at 11:01 AM Joel Fernandes <joelaf@google.com> wrote:
>
> On Wed, Jun 19, 2019 at 1:07 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jun 19, 2019 at 12:53:12PM -0400, Joel Fernandes wrote:
> > > > It is conceivable to have a "wakeup_sources" directory under
> > > > /sys/power/ and sysfs nodes for all wakeup sources in there.
> > >
> > > One of the "issues" with this is, now if you have say 100 wake up
> > > sources, with 10 entries each, then we're talking about a 1000 sysfs
> > > files. Each one has to be opened, and read individually. This adds
> > > overhead and it is more convenient to read from a single file. The
> > > problem is this single file is not ABI. So the question I guess is,
> > > how do we solve this in both an ABI friendly way while keeping the
> > > overhead low.
> >
> > How much overhead?  Have you measured it, reading from virtual files is
> > fast :)
>
> I measured, and it is definitely not free. If you create and read a
> 1000 files and just return a string back, it can take up to 11-13
> milliseconds (did not lock CPU frequencies, was just looking for
> average ball park). This is assuming that the counter reading is just
> doing that, and nothing else is being done to return the sysfs data
> which is probably not always true in practice.
>
> Our display pipeline deadline is around 16ms at 60Hz. Conceivably, any
> CPU scheduling competion reading sysfs can hurt the deadline. There's
> also the question of power - we definitely have spent time in the past
> optimizing other virtual files such as /proc/pid/smaps for this reason
> where it spent lots of CPU time.
>
> > And how often does this happen?  Does it _need_ to happen?
>
> These are good questions and we should find out. I am not saying that
> sysfs will not work, I am just saying we need to consider all the
> things. I will let Tri look into this since he is working on it, I
> don't know off the top.

There are really two use cases for wakeup_sources in Android:
(1) As Sandeep pointed out, it's used to plot history of wakeup
sources. This use case might actually be performance sensitive. I'll
check with our internal Android teams and loop back here.
(2) wakeup_sources information is included in bugreports.
Reading/parsing wakeup_sources in this case only happens when
generating a bugreport, so not particularly sensitive to overhead.
