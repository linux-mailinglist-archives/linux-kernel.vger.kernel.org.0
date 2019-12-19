Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D19F41260A9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 12:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfLSLS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 06:18:56 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41784 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfLSLS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 06:18:56 -0500
Received: by mail-qt1-f194.google.com with SMTP id k40so4717511qtk.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 03:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bK8n6wbBN5dxvdBb/dRS2eU8CTYt3wfHaaqEvwHYw6w=;
        b=olyhCioZcG5C9/pkpgg3SRcVKM1mjVPirLaD8+/gENMPM7eQ2zSKqiOJeYRQm1ZS2N
         MBAjeWSVWXLCW/0XHOfuYk6+l3Y2a4ouPlj+xYIze8Zq2gwwnpMgkMVgGhlCCeThCa/Y
         XsGXTsOANc5AYvFWqGJZsdBKnl2b0qaZ4X1nhqLXJUl8KKQz12UOteEp2tF3/zITeYo3
         BjfV765xJXGnxESMb/kgvzN/kBojhLDXBYftnJeoXkXahh85ocPFRP9GjLN7GWz5HS5C
         RTn1oW3LZ5MVet8dhgYMDimSHhW5nwLbDlwF4gKrjzy+mURsVIoIIuU+cx9uyhLHfv7Z
         nKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bK8n6wbBN5dxvdBb/dRS2eU8CTYt3wfHaaqEvwHYw6w=;
        b=auVkpUchH2+m4ER5Skn91nAC+A9RwdC3quX/w1nFPmVa3gyBD25tDkW9S6I7M90/HD
         /fBICqrlpfGh713pv5r/dPkvxZvpdPEqNiSHI0s+xDgvoFonf2iLG6Eo586PATA9gNuJ
         fCFvF/WEWhVP7ZG4ZYQHhItvUNBlCUpmIcnrE8b0WrcFe08NRhe3dDIxgplmheQ+HzwL
         JY3z4xXjwh5/nGcZXC6UQ7OCC22oxYrfmuD1N15B8Grc+82PLKywqMQE0XfqeFFyaZ/U
         uCriA0ee/Gk71Z+SLdsx/7AtMOYOTOjMq98szDJlomPgChzqxliH/xskqGzGVv18ofIz
         zD9w==
X-Gm-Message-State: APjAAAU3R2cdRempkED1wfb+vKlVXgsTadv0ZfTjHrEhJbu21jK+4ahI
        c1LLhMmnmCadFpRzl3mhgteZ40tA3T8QgmFswVBaKpxTTEA=
X-Google-Smtp-Source: APXvYqy/7xDxs6Oprnqj7Qdps0fLNiZZ7dbmhMXERokFGiFOSRdb1HLo5cgmVsADQJGBhgEF04TYosIhqL1Bwf/bX54=
X-Received: by 2002:ac8:24c1:: with SMTP id t1mr6443012qtt.257.1576754334788;
 Thu, 19 Dec 2019 03:18:54 -0800 (PST)
MIME-Version: 1.0
References: <20191208232734.225161-1-Jason@zx2c4.com> <CACT4Y+bsJVmgbD-WogwU=LfWiPN1JgjBrwx4s8Y14hDd7vqqhQ@mail.gmail.com>
 <CAHmME9o0AparjaaOSoZD14RAW8_AJTfKfcx3Y2ndDAPFNC-MeQ@mail.gmail.com>
 <CACT4Y+Zssd6OZ2-U4kjw18mNthQyzPWZV_gkH3uATnSv1SVDfA@mail.gmail.com>
 <CAHmME9oM=YHMZyg23WEzmZAof=7iv-A01VazB3ihhR99f6X1cg@mail.gmail.com>
 <CACT4Y+aCEZm_BA5mmVTnK2cR8CQUky5w1qvmb2KpSR4-Pzp4Ow@mail.gmail.com>
 <CAHmME9rYstVLCBOgdMLqMeVDrX1V-f92vRKDqWsREROWdPbb6g@mail.gmail.com>
 <CAHmME9qUWr69o0r+Mtm8tRSeQq3P780DhWAhpJkNWBfZ+J5OYA@mail.gmail.com>
 <CACT4Y+YfBDvQHdK24ybyyy5p07MXNMnLA7+gq9axq-EizN6jhA@mail.gmail.com> <CAHmME9qcv5izLz-_Z2fQefhgxDKwgVU=MkkJmAkAn3O_dXs5fA@mail.gmail.com>
In-Reply-To: <CAHmME9qcv5izLz-_Z2fQefhgxDKwgVU=MkkJmAkAn3O_dXs5fA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 19 Dec 2019 12:18:43 +0100
Message-ID: <CACT4Y+arVNCYpJZsY7vMhBEKQsaig_o6j7E=ib4tF5d25c-cjw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: WireGuard secure network tunnel
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 11:53 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Thu, Dec 19, 2019 at 11:49 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Thu, Dec 19, 2019 at 11:11 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > >
> > > On Thu, Dec 19, 2019 at 11:07 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > >
> > > > On Thu, Dec 19, 2019 at 10:35 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > That's exciting about syzcaller having at it with WireGuard. Is there
> > > > some place where I can "see" it fuzzing WireGuard, or do I just wait
> > > > for the bug reports to come rolling in?
> > >
> > > Ahh, found it: https://storage.googleapis.com/syzkaller/cover/ci-upstream-net-kasan-gce.html
> > > Looks like we're at 1% and counting. :)
> >
> > Yes, that's it. But that's mostly stray coverage.
> > wg_netdevice_notification I guess mostly because it tested _other_ device types.
> > And a bit of netlink because it sends random garbage into netlink.
> >
> > For netlink part it would require something along these lines:
> > https://github.com/google/syzkaller/blob/master/sys/linux/socket_netlink_generic_devlink.txt
> > https://github.com/google/syzkaller/blob/master/sys/linux/socket_netlink_crypto.txt
> > https://github.com/google/syzkaller/blob/master/sys/linux/socket_netlink_generic_fou.txt
> > https://github.com/google/syzkaller/blob/master/sys/linux/socket_netlink_generic_seg6.txt
> >
> > And for device setup, harder to say. Either pre-create one here:
> > https://github.com/google/syzkaller/blob/79b211f74b08737aeb4934c6ff69a263b3c38013/executor/common_linux.h#L668
> > or teach it how to create them on the fly or both or something else.
> >
> > Probably some wire packet formats here:
> > https://github.com/google/syzkaller/blob/79b211f74b08737aeb4934c6ff69a263b3c38013/sys/linux/vnet.txt
>
> Ahh, cool, okay. Netlink, device creation, and basic packet structure
> is a good start. What about the crypto, though?

It depends. What exactly we need there?
syzkaller uses comparison operand interception which allows it e.g. to
guess signatures/checksums in some cases.
We also have this special checksum type in descriptions:
https://github.com/google/syzkaller/blob/79b211f74b08737aeb4934c6ff69a263b3c38013/sys/linux/vnet.txt#L462
which means "fill in other data, then calculate the checksum and put
in that location".
Other things can be done in a similar way, e.g. some crypto. But that
requires more effort and leads to a tradeoff between effort/gain.
Generally we like smaller set of more generic constructs in
descriptions that can help with a set of different kernel interfaces.
But if it's lots of custom support for a single very special case,
then it becomes somewhat questionable.
But we have some ugly hack for such cases as well, e.g. for netfilter
we just say "screw it, so many special one-off cases, so we will just
write one-off procedural code":
https://github.com/google/syzkaller/blob/79b211f74b08737aeb4934c6ff69a263b3c38013/sys/linux/init_iptables.go
But generally we try to avoid that (and/or later replace ugly custom
code with generic constructs).
