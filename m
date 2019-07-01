Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 447251E880
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 08:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfEOGsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 02:48:47 -0400
Received: from mout.web.de ([217.72.192.78]:52071 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbfEOGsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 02:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557902897;
        bh=0emlYhO8SllnssBdf65BYJeAb+8XEqHtDjbbN6cl5Lw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VMrmMPuQv/X9iH4N4f5lNWgoRoFnNyUR8FX9VthmxnMZS5W2R+klatRalA2DyJf5J
         WSbdhIzdYPAZPUZL/FC5zYOcPNN5wFSnE2h11eAGSbHvtpGnAg5nOWAIib3Wet5b65
         f0D+6YT+MweIyZsdxuiEwNByvSd92y+GGc0pucOc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.244.73.153]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MWjAd-1hAbMZ3djH-00XtsD; Wed, 15
 May 2019 08:48:17 +0200
Subject: Re: [3/3] Coccinelle: pci_free_consistent: Extend when constraints
 for two SmPL ellipses
To:     Wen Yang <wen.yang99@zte.com.cn>,
        Julia Lawall <julia.lawall@lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Ma Jiang <ma.jiang@zte.com.cn>,
        Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>
References: <201905151043340243098@zte.com.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 mQINBFg2+xABEADBJW2hoUoFXVFWTeKbqqif8VjszdMkriilx90WB5c0ddWQX14h6w5bT/A8
 +v43YoGpDNyhgA0w9CEhuwfZrE91GocMtjLO67TAc2i2nxMc/FJRDI0OemO4VJ9RwID6ltwt
 mpVJgXGKkNJ1ey+QOXouzlErVvE2fRh+KXXN1Q7fSmTJlAW9XJYHS3BDHb0uRpymRSX3O+E2
 lA87C7R8qAigPDZi6Z7UmwIA83ZMKXQ5stA0lhPyYgQcM7fh7V4ZYhnR0I5/qkUoxKpqaYLp
 YHBczVP+Zx/zHOM0KQphOMbU7X3c1pmMruoe6ti9uZzqZSLsF+NKXFEPBS665tQr66HJvZvY
 GMDlntZFAZ6xQvCC1r3MGoxEC1tuEa24vPCC9RZ9wk2sY5Csbva0WwYv3WKRZZBv8eIhGMxs
 rcpeGShRFyZ/0BYO53wZAPV1pEhGLLxd8eLN/nEWjJE0ejakPC1H/mt5F+yQBJAzz9JzbToU
 5jKLu0SugNI18MspJut8AiA1M44CIWrNHXvWsQ+nnBKHDHHYZu7MoXlOmB32ndsfPthR3GSv
 jN7YD4Ad724H8fhRijmC1+RpuSce7w2JLj5cYj4MlccmNb8YUxsE8brY2WkXQYS8Ivse39MX
 BE66MQN0r5DQ6oqgoJ4gHIVBUv/ZwgcmUNS5gQkNCFA0dWXznQARAQABtCZNYXJrdXMgRWxm
 cmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPokCVAQTAQgAPhYhBHDP0hzibeXjwQ/ITuU9
 Figxg9azBQJYNvsQAhsjBQkJZgGABQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEOU9Figx
 g9azcyMP/iVihZkZ4VyH3/wlV3nRiXvSreqg+pGPI3c8J6DjP9zvz7QHN35zWM++1yNek7Ar
 OVXwuKBo18ASlYzZPTFJZwQQdkZSV+atwIzG3US50ZZ4p7VyUuDuQQVVqFlaf6qZOkwHSnk+
 CeGxlDz1POSHY17VbJG2CzPuqMfgBtqIU1dODFLpFq4oIAwEOG6fxRa59qbsTLXxyw+PzRaR
 LIjVOit28raM83Efk07JKow8URb4u1n7k9RGAcnsM5/WMLRbDYjWTx0lJ2WO9zYwPgRykhn2
 sOyJVXk9xVESGTwEPbTtfHM+4x0n0gC6GzfTMvwvZ9G6xoM0S4/+lgbaaa9t5tT/PrsvJiob
 kfqDrPbmSwr2G5mHnSM9M7B+w8odjmQFOwAjfcxoVIHxC4Cl/GAAKsX3KNKTspCHR0Yag78w
 i8duH/eEd4tB8twcqCi3aCgWoIrhjNS0myusmuA89kAWFFW5z26qNCOefovCx8drdMXQfMYv
 g5lRk821ZCNBosfRUvcMXoY6lTwHLIDrEfkJQtjxfdTlWQdwr0mM5ye7vd83AManSQwutgpI
 q+wE8CNY2VN9xAlE7OhcmWXlnAw3MJLW863SXdGlnkA3N+U4BoKQSIToGuXARQ14IMNvfeKX
 NphLPpUUnUNdfxAHu/S3tPTc/E/oePbHo794dnEm57LuuQINBFg2+xABEADZg/T+4o5qj4cw
 nd0G5pFy7ACxk28mSrLuva9tyzqPgRZ2bdPiwNXJUvBg1es2u81urekeUvGvnERB/TKekp25
 4wU3I2lEhIXj5NVdLc6eU5czZQs4YEZbu1U5iqhhZmKhlLrhLlZv2whLOXRlLwi4jAzXIZAu
 76mT813jbczl2dwxFxcT8XRzk9+dwzNTdOg75683uinMgskiiul+dzd6sumdOhRZR7YBT+xC
 wzfykOgBKnzfFscMwKR0iuHNB+VdEnZw80XGZi4N1ku81DHxmo2HG3icg7CwO1ih2jx8ik0r
 riIyMhJrTXgR1hF6kQnX7p2mXe6K0s8tQFK0ZZmYpZuGYYsV05OvU8yqrRVL/GYvy4Xgplm3
 DuMuC7/A9/BfmxZVEPAS1gW6QQ8vSO4zf60zREKoSNYeiv+tURM2KOEj8tCMZN3k3sNASfoG
 fMvTvOjT0yzMbJsI1jwLwy5uA2JVdSLoWzBD8awZ2X/eCU9YDZeGuWmxzIHvkuMj8FfX8cK/
 2m437UA877eqmcgiEy/3B7XeHUipOL83gjfq4ETzVmxVswkVvZvR6j2blQVr+MhCZPq83Ota
 xNB7QptPxJuNRZ49gtT6uQkyGI+2daXqkj/Mot5tKxNKtM1Vbr/3b+AEMA7qLz7QjhgGJcie
 qp4b0gELjY1Oe9dBAXMiDwARAQABiQI8BBgBCAAmFiEEcM/SHOJt5ePBD8hO5T0WKDGD1rMF
 Alg2+xACGwwFCQlmAYAACgkQ5T0WKDGD1rOYSw/+P6fYSZjTJDAl9XNfXRjRRyJSfaw6N1pA
 Ahuu0MIa3djFRuFCrAHUaaFZf5V2iW5xhGnrhDwE1Ksf7tlstSne/G0a+Ef7vhUyeTn6U/0m
 +/BrsCsBUXhqeNuraGUtaleatQijXfuemUwgB+mE3B0SobE601XLo6MYIhPh8MG32MKO5kOY
 hB5jzyor7WoN3ETVNQoGgMzPVWIRElwpcXr+yGoTLAOpG7nkAUBBj9n9TPpSdt/npfok9ZfL
 /Q+ranrxb2Cy4tvOPxeVfR58XveX85ICrW9VHPVq9sJf/a24bMm6+qEg1V/G7u/AM3fM8U2m
 tdrTqOrfxklZ7beppGKzC1/WLrcr072vrdiN0icyOHQlfWmaPv0pUnW3AwtiMYngT96BevfA
 qlwaymjPTvH+cTXScnbydfOQW8220JQwykUe+sHRZfAF5TS2YCkQvsyf7vIpSqo/ttDk4+xc
 Z/wsLiWTgKlih2QYULvW61XU+mWsK8+ZlYUrRMpkauN4CJ5yTpvp+Orcz5KixHQmc5tbkLWf
 x0n1QFc1xxJhbzN+r9djSGGN/5IBDfUqSANC8cWzHpWaHmSuU3JSAMB/N+yQjIad2ztTckZY
 pwT6oxng29LzZspTYUEzMz3wK2jQHw+U66qBFk8whA7B2uAU1QdGyPgahLYSOa4XAEGb6wbI FEE=
Message-ID: <39c4150c-b238-a0b4-19b4-6215012bb497@web.de>
Date:   Wed, 15 May 2019 08:48:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <201905151043340243098@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xzURLSqG+7U4MauJlZvgeN7etaHtK88Z441il8v+AE2R1FWi1Bs
 C9TCa3JRE6eRlxuqF3TD89EEDEsmIEJHp/1x3hb/3avEWI0flApLY/rVHeEU2//EukgZPNT
 abBd3+EPD4ubB+W9RLMNxT/aWjJW6HblI8y/VMfaxnzPHV4RceyImfv819ofjZqs8szbXyi
 XGSY1oNhDYTeZFc24xtPQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ysM+/KxubjY=:O2bH0NF60X6TTx8meAD5io
 OwZt7TcREvMe8HCG1wsc9+9l559hGF8Y70NSWs7i2smDjsgHoEXYxpwpJtc1hIwqeuRtPdjAY
 rTmeM0Vpywl71YL4M05VGlazsF6woGMXRgDZBvarA6mI2h7okSw0dr0sQLqW/+1aQiZkHCIPx
 MfoLFAnCIHcOpGlcpLQrK7BcjiwTdHMR2KU1MC7tOVczjvGiXtr6LJ9iD+sP0Uijx357xgtu6
 rrLKXtp3Zf4s1LIPqWnlpGuaLcRP6eD7WydpJVcOcWNFeJDhv/lq961DUAIXAZ+k8aqVMLJNV
 W+Nuvi5bLF/gvkq8eaNphrhcd1uWvSS7MyDVn0F7WMGVcuYt6P4ZAw68InDi5oOOrEpEyWLux
 lyJ1i/ZYTwpE/slusQG8bjfr6Fw4AejPtXL0AZTKjcZTEaOaA80jPDb8jzPiQMqZXfSFTERY4
 4ZVDRuRtVzTaUY9il998j31Zazqzi4UsrSNUWhLtDKt2NQNkObscIGZDx3LWPUOKb5HWnBiYS
 9gGjoKt/e2MJYuVODioA26ZIRyMLSARCPxoWlPy93Xl4lbd8TttfnXh5HvLAg9s+qEoR6THqE
 cNFoNH/I75sXP9NtmVv0XofiLBtpm8AlfOiVerN4c1SDLdQia06OYOtV5xZ5xDSUoIVlgFOt4
 nA5KNoPrANlhq0iFtjnei08fHxdOdyXJjk6xlfhNCAvlK9ViWw0whonuyRzOHJPmYZxJ+3hga
 JrlMUCAVtPQyZSf0T2PhvWmGAeYANDlkt7Z67muDj3tQQzLrmyrP/jUjPygu9wrMrgcNwdB4u
 vVf4hcac2GadhSePD3p6Pxaf2fkm89n0jk5VJpjlTYN+KRTJHo0XCZyOpKrUozY99YoaMe1z2
 ZllNfTiKqfIULSihIzhyP1I5Xv8Y4U9vKHBW0SEXF/SC7aR0ZMtS2RkVrXsW3XmatUxMXb3Oe
 eQhNOsPFkMw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 1, "id =3D (T2)(e)" is rare.

I can follow this view for such a filter.


> It may be a minor detail that will have no impact in practice.

I suggest to reconsider this view once more.

Should such exclusion specifications take also =E2=80=9Cunexpected=E2=80=
=9D source code
into account so that analysis results will be presented with a low
false positive rate?


> We've tested it, and this SmPL may only need to fix the following two fa=
lse positives:

Thanks for your acknowledgement that my proposal can give us
another useful effect.


> 2,  If you really plan to add the two restrictions above,
> you may need to consider this further than simply adding a "when !=3D id=
 =3D (T2)(e)" statement.
> I constructed the flollowing code snippet as a test case:
=E2=80=A6
> Using the original SmPL, we can find a bug.

I observe on my system that I do not get a desired warning
by the software combination =E2=80=9CCoccinelle 1.0.7-00186-g99e081e9 (OCa=
ml 4.07.1)=E2=80=9D
(even from the unmodified SmPL script) for your test example.

Which version are you using for the spatch program?


> But with your modified SmPL, we can't find the bug.

I do not see a difference here. - I wonder also about this situation then.

But this gives us the opportunity to clarify the really desired
software behaviour in more detail.
How many developers would like to help with additional insights?

Regards,
Markus
