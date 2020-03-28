Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83B571966D5
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Mar 2020 16:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgC1PG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Mar 2020 11:06:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36074 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgC1PG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 11:06:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id g62so15964094wme.1;
        Sat, 28 Mar 2020 08:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mVgDlbMGn4jDqjs9njtSrU27RzsFbT7yecFsuKk/EMo=;
        b=pAerVg/BGNM5T+nr0f/WwdO9Sh/P7G2ATAgE4lNBidp3VyZgVp8LxhD/XwzK89hnOg
         usJIzU/qodT0h2/Ns64sdH7qoMADJVl1greGt5bNdBrkcwZNycbXnMB/r6C6JVPHpXYW
         iqrRSrSaKFt5OnMOScfOa1ul6/G4lV9C7GNgn7942i6w3uiUEKLh94YFaYDItSpPvIXq
         IM1KSp/5JglcqNsNCNMGy/rrO8yDQ52qTNFUDuzNTulArfyjtbDQRavO1TgYHyyFOWbe
         8OochIAY/vIUTK3+Vk47IkLWBpTG9nemLY0y5+ewYu/PRwOACY6Rnomm2wmlQvwvQA3d
         zIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mVgDlbMGn4jDqjs9njtSrU27RzsFbT7yecFsuKk/EMo=;
        b=ZiK/pDqHN6xwYLxztHhgYY8CEP2EGRcYSj8dGzF+Zjks2qmBLRNN0jL7vqUgSyqdVo
         9Xm6IiuH2Ef2XAtyGF7AJAuPN2JRR3cWr66xVB8ADYqwNAdu4G4p4mj89PdZiQdJNTBS
         p1lB9ueu8PNUgRbLSMboRGlRGaDifMum3KyuGh2Rytz8TVBpxhJsU/YHllwtXQ4sSNZ7
         D4no0WK0cXhrmQUCedb8co/SP10dqq9mdHEX3z5AqJgzeE11BZDI7mLSOl2C0LPOPCsH
         83kyy8VOk0BXvLD6ycNe1g7pocRgxvBtjLv/XdrMkW+fyuqfX5QgdlZSwGM/AB59hlt7
         5U7g==
X-Gm-Message-State: ANhLgQ2aZdmXNVVDr5toiltBH8gj0YTwmzBkZ76J2jCFR3qo4aJQ568n
        1bygwxcJwC1X+0+MJ/cLcHM=
X-Google-Smtp-Source: ADFU+vteJ7u8UrlhBBVMg4JqNC0kDksrUoieeVxPUbKA/6mGuyk6Ju6nrOnD4bcgifgNuy3cdqORtg==
X-Received: by 2002:a1c:790e:: with SMTP id l14mr3968340wme.146.1585408016017;
        Sat, 28 Mar 2020 08:06:56 -0700 (PDT)
Received: from debian64.daheim (p5B0D73FB.dip0.t-ipconnect.de. [91.13.115.251])
        by smtp.gmail.com with ESMTPSA id y11sm4695479wmi.13.2020.03.28.08.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 08:06:55 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1] helo=debian64.localnet)
        by debian64.daheim with esmtp (Exim 4.93)
        (envelope-from <chunkeey@gmail.com>)
        id 1jID30-0006Y1-43; Sat, 28 Mar 2020 16:06:54 +0100
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Enrico Weigelt <info@metux.net>,
        Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matt Porter <mporter@kernel.crashing.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Mackerras <paulus@samba.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        DTML <devicetree@vger.kernel.org>, ewald_comhaire@hotmail.com
Subject: Re: [PATCH 0/2] powerpc: Remove support for ppc405/440 Xilinx platforms
Date:   Sat, 28 Mar 2020 16:06:54 +0100
Message-ID: <2194609.nAEUQZTCmX@debian64>
In-Reply-To: <b5adcc7a-9d10-d75f-50e3-9c150a7b4989@c-s.fr>
References: <cover.1585311091.git.michal.simek@xilinx.com> <20200327141434.GA1922688@smile.fi.intel.com> <b5adcc7a-9d10-d75f-50e3-9c150a7b4989@c-s.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry for the bounces, yes my smarthost mail setup breaks from time to time
and I had to cut the CC since it complained about the length.)

On Saturday, 28 March 2020 12:17:58 CET Christophe Leroy wrote:
>=20
> Le 27/03/2020 =E0 15:14, Andy Shevchenko a =E9crit :
>> On Fri, Mar 27, 2020 at 02:22:55PM +0100, Arnd Bergmann wrote:
>>> On Fri, Mar 27, 2020 at 2:15 PM Andy Shevchenko
>>> <andriy.shevchenko@linux.intel.com> wrote:
>>>> On Fri, Mar 27, 2020 at 03:10:26PM +0200, Andy Shevchenko wrote:
>>>>> On Fri, Mar 27, 2020 at 01:54:33PM +0100, Arnd Bergmann wrote:
>>>>>> On Fri, Mar 27, 2020 at 1:12 PM Michal Simek=20
>>>>>> <michal.simek@xilinx.com> wrote:
>>>>>> It does raise a follow-up question about ppc40x though: is it time to
>>>>>> retire all of it?
>>>>>
>>>>> Who knows?
>>>>>
>>>>> I have in possession nice WD My Book Live, based on this=20
>>>>> architecture, and I won't it gone from modern kernel support.
>>>>> OTOH I understand that amount of real users not too big.
Hm, can't add much to Xilinx ppc405/440 removal patch debate.=20

But as for the APM82181 with it's PPC464:

The last time I checked was with 5.6-rc4, it worked fine on the APM82181
(a MyBook Live) device. I've made a "build your own powerpc debian sid"
image thing that takes the latest kernel git and up-to-date packages
from debian ports (they still make powerpc packages!):=20
<https://github.com/chunkeey/mbl-debian> .

Though, this is small potatoes. There exists a much more popular project
by Ewald Comhaire (CCed): <https://github.com/ewaldc/My-Book-Live>
that serves the largest userbase:
<https://community.wd.com/c/wd-legacy-products>

I guess we should think about upstreaming the MyBook Live DTS. Problem here
is that we deviated a bit from the canyonlands.dts/bluestone.dts structure
by having a skeleton apm82181.dtsi with most of the SoC defintition and a
wd-mybooklive.dts for the device.

<https://github.com/chunkeey/mbl-debian/blob/master/dts/apm82181.dtsi>=20
<https://github.com/chunkeey/mbl-debian/blob/master/dts/wd-mybooklive.dts>

Cheers,
Christian



