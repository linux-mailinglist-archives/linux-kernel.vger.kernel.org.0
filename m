Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5A039A564
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 04:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390029AbfHWCPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 22:15:05 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]:42669 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731791AbfHWCPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 22:15:04 -0400
Received: by mail-qk1-f181.google.com with SMTP id 201so6980740qkm.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 19:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5JDnUX2p/PYVFfGAlYUAEO7MmFncIXWfixTOdAI96CY=;
        b=KIVULHtDCre3NJuR+/Jq4ru+EOOErEmV0P5Y8yFReeHMnlPMgFYaPUmVHaK1LKsrZs
         m2S5a5OOvQZ8HOmbqU0Ryr+gIonya/DKuviyEhCUXkBJWUzzMyPzZAscF0r8uWqi7XFe
         UxbS0TPvHI9vRT2noaqA9CEXJnfQlGf5sjrriQ8y7eGuAxTeFTZuq2yiy8UnSCloUb8c
         YwaC1/QL9IRdBAoCay6GKSHM7Dy6e5vvJaMEacmVb1WgpS5rgch0mpd+4ghVhgt1v2qf
         FCI/dXNTvB5mZNdlofByXn0D9SlQXadfeoWyXnxZ1BUutyOCL2C3iHCg995Cicf5+1jc
         gq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5JDnUX2p/PYVFfGAlYUAEO7MmFncIXWfixTOdAI96CY=;
        b=dm0btUAiSLA2wJ9CleKoq0atBGPxgwTeUNx1oWp0fWMUU4NnGQ/2I9ZzTIFKPdCD7E
         c8FknMKS1jlGQPidv0r9H7z3DZQfoVbddcloIHHtwAkqbv7hw8WRHpjKE1gUXPYHpzSp
         tUZkO4OFzeeIuWwjGmU0huRDZLxwWbv2f20M3dXZIl5GvOBxEv94Wd7zxCUIemQFh4Z5
         RJ7aGEUtHif5RqcHY2spwuvyL4tSsJ6kV3nRhBSc37BtmZo/3NSBDqmzr9stjuA51k93
         qw1YrHZiqtOaB6kC3p0iVH0NJVzK4hHiX74z114dBlDYI2802i8KM2MsTq7xU1dyPx5V
         wysw==
X-Gm-Message-State: APjAAAUS6IUvqb3pJySEo/4lVAvaKAZak7qdYwep4NB0GBjr5SCJL5Aa
        YoWVj8eZoj0fvYc2cagI6fK+l0s1/mzSX0RoqQRHKhgs
X-Google-Smtp-Source: APXvYqx3kfr2RKFh/xq3vFc4cUkLDjwWJ5Tb8Qa1I+jhr64cUINKi33ptx5kOl05L5X65LkPaVbRER94UyItepCEP9o=
X-Received: by 2002:ae9:c206:: with SMTP id j6mr2041507qkg.14.1566526503668;
 Thu, 22 Aug 2019 19:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <d9802b6a-949b-b327-c4a6-3dbca485ec20@gmx.com> <20190820064620.5119-1-drake@endlessm.com>
 <4d998874-d02b-395f-1b81-7034db1a8fcd@redhazel.co.uk>
In-Reply-To: <4d998874-d02b-395f-1b81-7034db1a8fcd@redhazel.co.uk>
From:   Daniel Drake <drake@endlessm.com>
Date:   Fri, 23 Aug 2019 10:14:52 +0800
Message-ID: <CAD8Lp46jYbdtFW2i_HnR8f3GY6Ombne6ouYm2UAnmF9BmeVAFw@mail.gmail.com>
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's
 inability to gracefully handle low memory pressure
To:     ndrw <ndrw.xf@redhazel.co.uk>
Cc:     aros@gmx.com, Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Bastien Nocera <hadess@hadess.net>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 9:54 AM ndrw <ndrw.xf@redhazel.co.uk> wrote:
> That's obviously a lot better than hard freezes but I wouldn't call such
> system lock-ups an excellent result. PSI-triggered OOM killer would have
> indeed been very useful as an emergency brake, and IMHO such mechanism
> should be built in the kernel and enabled by default. But in my
> experience it does a very poor job at detecting imminent freezes on
> systems without swap or with very fast swap (zram).

Perhaps you could share your precise test environment and the PSI
condition you are expecting to hit (that is not being hit). Except for
the single failure report mentioned, it's been working fine here in
all setups, including with zram which is shipped out of the box.

The nice thing about psi is that it's based on how much real-world
time the kernel is spending doing memory management. So it's very well
poised to handle differences in swap speed etc. You effectively just
set the threshold for how much time you view as excessive for the
kernel to be busy doing MM, and psi tells you when that's hit.

> > There's just one issue we've seen so far: a single report of psi reporting
> > memory pressure on a desktop system with 4GB RAM which is only running
> > the normal desktop components plus a single gmail tab in the web browser.
> > psi occasionally reports high memory pressure, so then psi-monitor steps in and
> > kills the browser tab, which seems erroneous.
>
> Is it Chrome/Chromium? If so, that's a known bug
> (https://bugs.chromium.org/p/chromium/issues/detail?id=333617)

The issue does not concern which process is being killed. The issue is
that in the single report we have of this, psi is apparently reporting
high memory pressure even though the system has plenty of free memory.

Daniel
