Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 059D3BD7F1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 07:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411821AbfIYFvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 01:51:49 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:60666 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404696AbfIYFvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 01:51:48 -0400
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x8P5pigA015756;
        Wed, 25 Sep 2019 14:51:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x8P5pigA015756
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1569390705;
        bh=DZd0prVsm5iXFJeF/5wUAhscNazal1cY2qNS6eLIwHE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1BIgxrPubN3fH2k9tHL33FE8pDukVug8D+UBixq6bujgh/3ttFqCOMBggZ3tPdIin
         J9F0J2Gvx1wYOi3rwdpxQAekIzxu41wGl6Xbsw06bqu0X2PqzMOrWnigDHPt8o6IeA
         bOw77zLpcn9GGnxHKGsTmfQ7vkY8ZxNyF2WD2zOOUCjKjTbbEfkL53JZCE5ZUOVy+M
         Cr/Kx6YgpgJZIvWCGq1UEp58x2u7wJtE45zKtIZjnizLNiH5r4QIFNGHiwug7HQ4TK
         +Lbo+hZkvaVQx84KH0lPZZXNMxZob9FPOIFv/7wyokYc9V7MsbA8AZQs7P2Gkc+WWo
         Kf2me0bF+QKOg==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id v10so2995661vsc.7;
        Tue, 24 Sep 2019 22:51:45 -0700 (PDT)
X-Gm-Message-State: APjAAAWYLSFfRyn69Dzq2a98Qlk/X4i70PdWOCNKnJIY0FsFbqTxxTRG
        4xhD2W6fRXq3FmfQgFa8okWBRnGo30wXi4JlAbc=
X-Google-Smtp-Source: APXvYqyJukBpMN0q4q5ZmP6lYw2kfEPwLuOa13kelNZQNAX+KRRTQcCQrXDpb2xl6oP68fvkoZuCrZbEAOmCM4LHns0=
X-Received: by 2002:a67:1e87:: with SMTP id e129mr3884818vse.179.1569390704125;
 Tue, 24 Sep 2019 22:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <CADxRZqwizJ2HXdiU7aSH9t=ecBEHnxdVVsQ4wUpTYRpCgdXf=w@mail.gmail.com>
 <CADxRZqzx=8jNQuvi8WN=7U_G5a0f+v_GODHH8q3QJVYmg=n1LA@mail.gmail.com>
 <CAK7LNAR3szhzH89ujCPq5Xz8rm0xvSjJdx0TebsaU8yiroXXVg@mail.gmail.com> <CADxRZqy-muFfpfCj6ZMPboSMEKXukTDg0oUZc6udvNreoJ6pgA@mail.gmail.com>
In-Reply-To: <CADxRZqy-muFfpfCj6ZMPboSMEKXukTDg0oUZc6udvNreoJ6pgA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 25 Sep 2019 14:51:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQd4_jWstNUkXSTayoa6+VHgdoN7Y4EhWakAsigmt1Smw@mail.gmail.com>
Message-ID: <CAK7LNAQd4_jWstNUkXSTayoa6+VHgdoN7Y4EhWakAsigmt1Smw@mail.gmail.com>
Subject: Re: latest git kernel (v5.3-11506-gf7c3bf8fa7e5) does not compile
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anatoly,


On Sun, Sep 22, 2019 at 9:14 PM Anatoly Pugachev <matorola@gmail.com> wrote:

> > Thanks for the report, and apology for the breakage.
> >
> > Please check this patch.
> > https://lore.kernel.org/patchwork/patch/1130469/
> >
> > I hope it will fix the build error.
>
>
> It does. Thanks Masahiro!

Thanks for testing!

Could you please give your Tested-by in the reply to my patch?

With Tested-by from the reporter,
I think the maintainer will be able to pick up the patch
more confidently.

Thanks.



-- 
Best Regards
Masahiro Yamada
