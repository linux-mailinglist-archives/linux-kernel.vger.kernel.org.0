Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72A8683507
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 17:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733123AbfHFPUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 11:20:23 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:57677 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732024AbfHFPUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:20:23 -0400
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x76FKDh8015073
        for <linux-kernel@vger.kernel.org>; Wed, 7 Aug 2019 00:20:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x76FKDh8015073
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1565104814;
        bh=i+FEvR/efuw3Idz+I3UfAGgy5H3JLZbboBPNDDtTNz8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VmNYw1JaZizdi0/b6wyZ7iD4a55YXg5c4iAN6s9qyizPMhYawqp136BXm5hrd9RyG
         VDOwwlT/SVXU+I4I/WaJo2bBi1EgLeB3ZJI7q3rjmI7v6ZUZ0b6V9lvXh9CoqgjjY2
         kGvJlL16JuuXTvDzmb1B8xOG176561vcOSQjQHbfBdV0PhiiEWlUlBJk97V1nv0L55
         3p+FpluqY/WvV5+rG8YqxHx/Jhh/LBvRAlKsFqXFMNWhAQAp8FnYSUJptwtWlHFxBI
         1OFmbgQ9tCeh1asL5v+EAuDb2W8EzaY76wKp6OQIJlQZLdsdkLjQiKVkKofhMV9KQQ
         AiwhZnTZPiM/A==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id 190so58542377vsf.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 08:20:13 -0700 (PDT)
X-Gm-Message-State: APjAAAXQhIaaMQ1yJIuUUWos+Bg2ybxRtXPkLply+UN/bMTCh+GwTwMe
        GNzoZ/SMletPGtdDzuq9qKblbJYXxfIMnz0XGzg=
X-Google-Smtp-Source: APXvYqw8NAl1Oqazt55RhaYIuzXlPleRxF2o7rmwlLXmz1SSSwLnIlZnXz8/6do7KFel5de8AmoxZnU7NgsPAS/5oek=
X-Received: by 2002:a67:f495:: with SMTP id o21mr2670793vsn.54.1565104812592;
 Tue, 06 Aug 2019 08:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190731190309.19909-1-rikard.falkeborn@gmail.com>
 <47d29791addc075431737aff4b64531a668d4c1b.camel@perches.com>
 <CAK7LNAQdgUOsjWtWFnXm66DPnYFRp=i69DMyr+q4+NT+SPCQxA@mail.gmail.com>
 <2b782cf609330f53b6ecc5b75a8a4b49898483eb.camel@perches.com>
 <CAK7LNASw+Fraio3t=bZw-FzJihScTuDR=p2EktFVOmdLH4GTGA@mail.gmail.com>
 <20190802181853.GA809@rikard> <CAK7LNAT+cNxna4SER04MdkBsq_LDg4TwYR_U1ioNNxYOZWXigA@mail.gmail.com>
 <CAK7LNAQv-5epL8DYDaUdHsQEQ=Va676t_6TgsaSYC30Eix=iyw@mail.gmail.com>
 <20190803183637.GA831@rikard> <CAK7LNASBndh4yJKVdeMb7RQGopUzEUSNXPQcUgQdB8PiJetMuQ@mail.gmail.com>
 <20190805195526.GA869@rikard>
In-Reply-To: <20190805195526.GA869@rikard>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 7 Aug 2019 00:19:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNATpQDWoMv+hnPrb1DTu4HravUhuhANnQkayxaJw99_ajQ@mail.gmail.com>
Message-ID: <CAK7LNATpQDWoMv+hnPrb1DTu4HravUhuhANnQkayxaJw99_ajQ@mail.gmail.com>
Subject: Re: [PATCH] linux/bits.h: Add compile time sanity check of GENMASK inputs
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rikard,


On Tue, Aug 6, 2019 at 4:55 AM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
>
> On Sun, Aug 04, 2019 at 03:45:16PM +0900, Masahiro Yamada wrote:
> > On Sun, Aug 4, 2019 at 3:36 AM Rikard Falkeborn
> > <rikard.falkeborn@gmail.com> wrote:
> > >
> > > On Sat, Aug 03, 2019 at 12:12:46PM +0900, Masahiro Yamada wrote:
> > > > On Sat, Aug 3, 2019 at 12:03 PM Masahiro Yamada
> > > > <yamada.masahiro@socionext.com> wrote:
> > > >
> > > > >
> > > > > BTW, v2 is already inconsistent.
> > > > > If you wanted GENMASK_INPUT_CHECK() to return 'unsigned long',,
> > > > > you would have to cast (low) > (high) as well:
> > > > >
> > > > >                (unsigned long)((low) > (high)), UL(0))))
> > > > >
> > > > > This is totally redundant, and weird.
> > > >
> > > > I take back this comment.
> > > > You added (unsigned long) to the beginning of this macro.
> > > > So, the type is consistent, but I believe all casts should be removed.
> > >
> > > Maybe you're right. BUILD_BUG_ON_ZERO returns size_t regardless of
> > > inputs. I was worried that on some platform, size_t would be larger than
> > > unsigned long (as far as I could see, the standard does not give any
> > > guarantees), and thus all of a sudden GENMASK would be 8 bytes instead
> > > of 4, but perhaps that is not a problem?
> >
> >
> > How about adding (int) cast to BUILD_BUG_ON_ZERO() ?
>
> I'll have a look.



I found a more important problem in this patch.

You used __is_constexpr(), which is defined in <linux/kernel.h>.

This header does not include <linux/kernel.h>,
so this header is not self-contained anymore.

The following test code fails to build:

#include <linux/bits.h>
unsigned long foo(unsigned long in_bits)
{
        return in_bits & GENMASK(5, 3);
}



However, you cannot include <linux/kernel.h> from <linux/bits.h>.
See the log of 8bd9cb51daac89337295b6f037b0486911e1b408

This header was split out to not pull in <linux/bitops.h>
Including <linux/kernel.h> pulls in <linux/bitops.h> again.


In summary, please use __builtin_constant_p()
instead of __is_constexpr().


You can shorten __builtin_constant_p(high) && __builtin_constant_p(low)
into __builtin_constant_p((low) > (high)).


How about this?


#define GENMASK_INPUT_CHECK(high, low) \
       BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
              __builtin_constant_p((low) > (high)), (low) > (high), 0))


-- 
Best Regards
Masahiro Yamada
