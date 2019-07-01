Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 783B04C116
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 20:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbfFSSz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 14:55:29 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:46821 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfFSSz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 14:55:29 -0400
Received: by mail-qt1-f176.google.com with SMTP id h21so224498qtn.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 11:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VB4BzkBmAfnn9smG4QdujxZEKSCe7ZFO081CDJvGHOs=;
        b=UBkEObavWJUPzYWqrX4PkO/rtS4osV2M2qFRIsoTfseYCV36DPH/UIBpKLZIMe2iw4
         yNQQLyfbGIzSwMus48MynBPRVNPcq5dCS6HyB+CDOJPwpvfi1Q1AMnWVHx99ohYV2alN
         tsZNZPSNqb0A9uU9djzwqkjOO/ZX1genqYCUsk28nZWO5UmaF86MRtlsXO1f/zxwdU9S
         LX7J5xrcA2ORQBpqlIS4uKsxn8HXexnyDiNnnaG0/Ist0tZe72mJR/OmRkoFk8fANuMo
         /gkCW0eJyjkpMRDDXIRmiuIVryJoC0KOzlDg9KsXSj2DUsGBURY4X4haTbg9VF17+BvG
         dpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VB4BzkBmAfnn9smG4QdujxZEKSCe7ZFO081CDJvGHOs=;
        b=uXSphELjFDon75HNiT7lln1AAjBiBwPp+yuPRsbG7bp+CzVpqFC4b+CsFD0Yv3rV22
         79BxM7Y212jzmU8enYDDE/HUzbI4X1QjxnpifivZeCms55jq+AI/fo/KoEpxvqny2KKN
         Veu/U7Fgk+E3sINSCbgM4d+ju8QMlWNFOgQx8ehQN4vYqwlbJq7vqRWNqgG1ezEtJevx
         M/lP+95Q5Xuutl/PaiedouXh39YJgQ8SCszs+sVprXBYwHkjy3Nv3Lv4OwO8Z97pe6dY
         NHg0RK3/d7MPTAJyIFFqt4kPfJyP/F3/ra13+CgNZGz6YIxv6A7Mntk3uY7pK2ciocPf
         NxIw==
X-Gm-Message-State: APjAAAUoI6XanCA6YlSEDP5lmHftAF2qk14/Fp1gQOHNM3BvBsvEk05I
        Mk1uv/4Bz9YeaFXuvg4AeQd2zawW28VT34GY0yCAuA==
X-Google-Smtp-Source: APXvYqzI72YXA5i3v4S/pD3+OnXPb177CrNmWqsRGDJ8mXeyyj5HcEGb9STWniYmYDfsjLVQoaFs8+vVn+k77sHoPCY=
X-Received: by 2002:aed:2389:: with SMTP id j9mr81727583qtc.244.1560970527825;
 Wed, 19 Jun 2019 11:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <CANA+-vCThdRivg7nrMK5QoFu8SGUzEVSvSyp0H2CPyy9==Tqog@mail.gmail.com>
 <CANA+-vARQ9Ao=W1oEArrAQ0sqh757orq=-=kytdVPhstm-3E9w@mail.gmail.com>
 <20190618182502.GC203031@google.com> <4587569.x9DSL43cXO@kreacher>
 <CANA+-vCMK6u1n9gXf2+v5dFn_tGfr1PT8d7W4d2BCzw+B-HvYw@mail.gmail.com>
 <CAJWu+oo7kwmEyMXQN0yfswV2=J-Fa9QybhAUx-SOGG_ipsBErQ@mail.gmail.com>
 <CAJZ5v0gvzCx-7qS9qkxB=sGKjQJKMR7yCc21f=_vqrbZxMSWNg@mail.gmail.com>
 <CAJWu+oqSgcBVhDY7CjWpNQrK=XiKAb5S-YSp=6-UM--UFmKvGQ@mail.gmail.com>
 <20190619170750.GB10107@kroah.com> <CAJWu+ookFTYGfSvJ3otpFQixG2kbkJGOqf7HHUeYNQAQv2Cskw@mail.gmail.com>
 <20190619183523.GA7018@kroah.com>
In-Reply-To: <20190619183523.GA7018@kroah.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Wed, 19 Jun 2019 14:55:16 -0400
Message-ID: <CAJWu+opk+9j8=AtBFggbBn+nYZnCv2jS+mD=Vri9foN2rjvo8A@mail.gmail.com>
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

On Wed, Jun 19, 2019 at 2:35 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jun 19, 2019 at 02:01:36PM -0400, Joel Fernandes wrote:
> > On Wed, Jun 19, 2019 at 1:07 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Jun 19, 2019 at 12:53:12PM -0400, Joel Fernandes wrote:
> > > > > It is conceivable to have a "wakeup_sources" directory under
> > > > > /sys/power/ and sysfs nodes for all wakeup sources in there.
> > > >
> > > > One of the "issues" with this is, now if you have say 100 wake up
> > > > sources, with 10 entries each, then we're talking about a 1000 sysfs
> > > > files. Each one has to be opened, and read individually. This adds
> > > > overhead and it is more convenient to read from a single file. The
> > > > problem is this single file is not ABI. So the question I guess is,
> > > > how do we solve this in both an ABI friendly way while keeping the
> > > > overhead low.
> > >
> > > How much overhead?  Have you measured it, reading from virtual files is
> > > fast :)
> >
> > I measured, and it is definitely not free. If you create and read a
> > 1000 files and just return a string back, it can take up to 11-13
> > milliseconds (did not lock CPU frequencies, was just looking for
> > average ball park). This is assuming that the counter reading is just
> > doing that, and nothing else is being done to return the sysfs data
> > which is probably not always true in practice.
> >
> > Our display pipeline deadline is around 16ms at 60Hz. Conceivably, any
> > CPU scheduling competion reading sysfs can hurt the deadline. There's
> > also the question of power - we definitely have spent time in the past
> > optimizing other virtual files such as /proc/pid/smaps for this reason
> > where it spent lots of CPU time.
>
> smaps was "odd", but that was done after measurements were actually made
> to prove it was needed.  That hasn't happened yet :)
>
> And is there a reason you have to do this every 16ms?

Not every, I was just saying whenever it happens and a frame delivery
deadline is missed, then a frame drop can occur which can result in a
poor user experience.
