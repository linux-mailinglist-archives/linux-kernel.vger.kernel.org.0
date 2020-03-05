Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEA3D17AE26
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 19:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgCESfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 13:35:22 -0500
Received: from hermes.aosc.io ([199.195.250.187]:36187 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgCESfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:35:22 -0500
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 182D04B2E3;
        Thu,  5 Mar 2020 18:35:17 +0000 (UTC)
Date:   Fri, 06 Mar 2020 02:35:12 +0800
In-Reply-To: <CA+E=qVcyRW4LNC5db27d-8x-T_Nk9QAhkBPwu5rwthTc6ewbYA@mail.gmail.com>
References: <20200213145416.890080-1-enric.balletbo@collabora.com> <20200213145416.890080-2-enric.balletbo@collabora.com> <CA+E=qVffVzZwRTk9K7=xhWn-AOKExkew0aPcyL_W1nokx-mDdg@mail.gmail.com> <CAFqH_53crnC6hLExNgQRjMgtO+TLJjT6uzA4g8WXvy7NkwHcJg@mail.gmail.com> <CA+E=qVfGiQseZZVBvmmK6u2Mu=-91ViwLuhNegu96KRZNAHr_w@mail.gmail.com> <CAFqH_505eWt9UU7Wj6tCQpQCMZFMfy9e1ETSkiqi7i5Zx6KULQ@mail.gmail.com> <CA+E=qVff5_hdPFdaG4Lrg7Uzorea=JbEdPoy+sQd7rUGNTTZ5g@mail.gmail.com> <5245a8e4-2320-46bd-04fd-f86ce6b17ce7@collabora.com> <CA+E=qVcyRW4LNC5db27d-8x-T_Nk9QAhkBPwu5rwthTc6ewbYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] drm/bridge: anx7688: Add anx7688 bridge driver support
To:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>
CC:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>, Torsten Duwe <duwe@suse.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Collabora Kernel ML <kernel@collabora.com>
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <1E10190D-265F-4287-9717-AD1457E7044A@aosc.io>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aosc.io; s=dkim;
        t=1583433319;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
        bh=//QrWlD/P+HB+nkieh4hRmpzn2XAHQWWWeCW88czZjU=;
        b=FWIm1DWulIexbYtpxgnXp718ykKfXTtxpwAKWiUdWiZll5BA+EA6nziXFm2SFHaxnqj/K4
        S82mGdox2p+i8EZPcPyNFP8Y2+uc+s+kJJ7uTnEJnsLEheDu7qamp+gDQWTDbn0M5+/KCs
        sfEk9RJhwNQVTrm8MG4PpiYlbfIx2+k=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E4=BA=8E 2020=E5=B9=B43=E6=9C=886=E6=97=A5 GMT+08:00 =E4=B8=8A=E5=8D=882:=
29:33, Vasily Khoruzhick <anarsoul@gmail=2Ecom> =E5=86=99=E5=88=B0:
>On Thu, Mar 5, 2020 at 7:28 AM Enric Balletbo i Serra
><enric=2Eballetbo@collabora=2Ecom> wrote:
>>
>> Hi Vasily,
>
>CC: Icenowy and Ondrej
>>
>> Would you mind to check which firmware version is running the anx7688
>in
>> PinePhone, I think should be easy to check with i2c-tools=2E
>
>Icenowy, Ondrej, can you guys please check anx7688 firmware version?

At 0x2c, 0x80 is 0x01, 0x81 is 0x25

01=2E25, right?

>
>> Thanks in advance,
>>  Enric
>>
>> [snip]

--=20
=E4=BD=BF=E7=94=A8 K-9 Mail =E5=8F=91=E9=80=81=E8=87=AA=E6=88=91=E7=9A=84A=
ndroid=E8=AE=BE=E5=A4=87=E3=80=82
