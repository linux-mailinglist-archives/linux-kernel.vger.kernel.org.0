Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C63F147739
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 04:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbgAXDo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 22:44:29 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:16582 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgAXDo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 22:44:28 -0500
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 00O3iBKA009753
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 12:44:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 00O3iBKA009753
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1579837451;
        bh=ZciN3pdou+Uxxprysqmu7s1MHJ/ph/kv6GDPRv1quYk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nK61UGKbxmxCm8NTN73uU+ntDikTe3yu3tbJTwcN3htJvnam6Xz3XOfF+OvfHmjxT
         1F+dGEbbNZc/hV1+jq2PIuX6QDdfjq+wJh783MzOu9cp2TrtoGvMLolPT45Wh+WctO
         e90bSlaeTqDigkGGPY6ABFPEhSr5Pheak4wTuTrdRXAVE0e94Kuk5bKUNjjtVfAUjN
         sLDnoWcFK3ve8yK1wzzfuvYHvz7ZFwhAeHqPgGgnM2vGwMbfxnOY9qFDacCsWOufWR
         a4njBgGTbVZAIGelZDz04PrdJTdDb1QJiZHrgmTMhMSzCLsKkUzFnF7OD4m5ootccL
         UYjT8isEK4lAQ==
X-Nifty-SrcIP: [209.85.222.50]
Received: by mail-ua1-f50.google.com with SMTP id 73so322975uac.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 19:44:11 -0800 (PST)
X-Gm-Message-State: APjAAAVEFg6AiJhzK0+wvZy2UcrRUY3nsOt5yRhyU6+TAiUAY2pizqGx
        Wv/9FBB8WFc24UGmGoiAiMrNwmaB4ZoEevHk+BY=
X-Google-Smtp-Source: APXvYqyPABcHjkE7LphB8AFi82zW6lt8MeVEc6Mzrd111/JuQRIL1R1KIWXilIUSJZKLMiQpcGh2uuZp/WTYDvUMVUs=
X-Received: by 2002:ab0:6509:: with SMTP id w9mr709242uam.121.1579837450310;
 Thu, 23 Jan 2020 19:44:10 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNASEaiFia8NKZN8++-9RfGXOPKSFuCkdukBk9Jy7+nHecQ@mail.gmail.com>
 <CAK7LNAT721bVwVQif--UY1dXMhq8NSRpkPOYTN-=nxyBSBOn2Q@mail.gmail.com> <CAOesGMgyh2NmR_AbEzC2jQe070e_u3zozWi=v7RjMXszXgetZg@mail.gmail.com>
In-Reply-To: <CAOesGMgyh2NmR_AbEzC2jQe070e_u3zozWi=v7RjMXszXgetZg@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 24 Jan 2020 12:43:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNATj8EP_vSDSbknQsYp5V=7EfdQzTQbobhNjXS5Y8YOjqg@mail.gmail.com>
Message-ID: <CAK7LNATj8EP_vSDSbknQsYp5V=7EfdQzTQbobhNjXS5Y8YOjqg@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: dts: uniphier: UniPhier DT updates for v5.6
To:     Olof Johansson <olof@lixom.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof,


On Fri, Jan 24, 2020 at 12:22 PM Olof Johansson <olof@lixom.net> wrote:
>
> Hi,
>
> On Thu, Jan 23, 2020 at 6:49 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > Hi Arnd and Olof,
> >
> > I know it is already -rc7, but
> > it would be nice if you could pull this for the next MW.
> >
> > Thanks
> >
> > Masahiro
>
> If you don't email us at soc@kernel.org, we're unlikely to see your
> pull requests. :(

Oh, I just remembered this!

>
> In this case that's what happened. Please do so -- that way it gets
> caught in the patchtracker. I sort the patches to that alias in a
> special folder to make sure I see them too, since I get too much in my
> inbox and it easily gets lost.
>
> Mind resending the two pull requests to that alias?

Sure. Done.



> That way you get
> the notification email when it's merged -- if I bounce it here I don't
> think you'll get it.
>
>
> Thanks,
>
> -Olof



-- 
Best Regards
Masahiro Yamada
