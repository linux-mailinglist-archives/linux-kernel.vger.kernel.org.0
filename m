Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD58ACB80
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2019 10:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfIHILW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Sep 2019 04:11:22 -0400
Received: from mout.web.de ([212.227.15.3]:55259 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbfIHILV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 04:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567930224;
        bh=Lx1GxmRq9Huqf01OD24uJ2Km7r3WbSeOQ2hZstNdjOk=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=qddiuAohYLhDIeRNepFLww3wkQPAUW8ct1fJClytZGVeJbOLj8nHebnyzskuskono
         MD9Cf7+8Q52pORTl8ESSPt/mYvkO88KfUa4c+f3uYSLFY5b9rnkQIpdtzD2rMLxwKh
         Uv+WE58z1ZM/WeyvhyeqXgmyWmy+E22r8gkGO414=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.171.128]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M2ZtN-1iNZgL21Fl-00sMK7; Sun, 08
 Sep 2019 10:10:24 +0200
To:     Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Petr Strnad <strnape1@fel.cvut.cz>,
        Wen Yang <wen.yang99@zte.com.cn>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <lkml@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yi Wang <wang.yi59@zte.com.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: Coccinelle: pci_free_consistent: Checking when constraints
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
Message-ID: <9666134d-0ff6-81eb-b088-f0086a0e61b1@web.de>
Date:   Sun, 8 Sep 2019 10:10:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cH0vvGjILvkt4l6UTMecRz7va909UY6S5baxIHWaNW0EcEl0aR5
 5jjwTiL++7Xmbv7mSlCj5Spd76bVerGnChHr3ioUY8Kzmjn/6zwyQ6fFwOHDlQzgE9JVws7
 uFlVXURTRIRowDD9PKmWxxOEqUpCCwXPUDYc88rsjgYEfpnxiPOsj2bSay4MB0zfCMOw/6O
 eYS0sYCFrpR4KP7qtfSNw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TOd55i0aTtw=:xGORjV2byrSGLHKN01/jxx
 v23mbSVurexxtjIOxGSTAC12TOeFSNQsxncJSBcMcqq5fATTOhh/lI83KecmLLuklNGThfW0x
 GyMPrEQWBbtQTSdUf7fY6CucnSkXRvcVacGRheqxXPSyPV9gG3jvyLCxJBFFUvOVGu7ZDbPKE
 hUsEaFzJdi5xGYMMSyfeD/RIaHC/mvteZyYIZmPzTUrYIee41FvSA5FaXizzmPDDVNpOkVKhZ
 C++w8QcXqol0DZviFejGoxvyc6GkdLZ6D/VyQYD/gGjxu21E1nUwf0QmtUNhn7wscdYqiI/h8
 u4L+XunzWxSQ6hgyPXhkg2vJ0iuQZNacUy6fMY44ICu7ga01gfunqeCzWznql7MxEQzS268Et
 WhRdtSusqiqLoRC3epU5MsAPCe19U2wc/IMqXQsUS3TroethziruIvolUmtHVmM9nmA7U4i1P
 WRE4q3x9zU2/p86qepfJ6i0S63+sG8TDGGQzOHqVGB6TfBDajg4g30BRarAQLbY2Owo6KTJfg
 VZrKVqZtawXOQEUdsfYgVg8MZC/iNzy7KcES2cS1duJHETxMz9zdOKO15D6WT/98D0fdEoXBK
 gX8vbjI97FLZcXPdnjiMbDMKJckYuMsWQzrCIKK6R4pZI1gB0QG93ZPjJ7ZAO2RVepELzxvYx
 uC19ThFJSgejRIyrLd0PV53vnXqIRVSO06LZpW9tCP67O9tnY5COoefAcVx5KeJ2rL5hOyOS3
 AKyX1yLMsWvrB5YUG/sDH4FN3z27VAwaSKvYzN9eivPtOwBlsFchzrjrGUoribJswssrBmSje
 NS/GWR5XPk2gag6YtmK3ZaSZXHoUCqW3pfVVmdrpngjMnrYVLIcT1WR4iynODrwHmwIVAiQmG
 baZqpo0IaXOVp8MezZHwp5rATc9hJCDqTgv09D+3zv8KvFr1/6MrPtDsUWqvDb3VWj6Rln7QM
 HhG5SH11doBdrrK3khWAbzZenKjevTMqQ9Q7UD0CZIO1M7zV1IfyxyOYZO40VFLPHXC0U9yPe
 JN1TldEbsECAx3hqh9aa3g7m1wOmk/rs9BTw9jbm+XjFfu1B29KMBuh1ghzwA5//VpYTU/Sxq
 z9ba6fODQhr1vvYWjSdeNo2y8k6mf95NWbKP/rCAF1NTnwDFkKiP0Ns1OKzdKzlA+qgKxuAZP
 /937+gDMFDi/yE/nsNGzMGEOPMIhfZLemZzp3+VMmxQVfREzwuUMzgAkpgSd+fn6sYD3RwN7s
 ffErPyDlweJN4EBmh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have taken another look at a known script for the semantic patch languag=
e.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sc=
ripts/coccinelle/free/pci_free_consistent.cocci?id=3D950b07c14e8c59444e235=
9f15fd70ed5112e11a0#n2

The following SmPL code is used there so far.

=E2=80=A6
... when !=3D pci_free_consistent(x,y,id,z)
    when !=3D if (id) { ... pci_free_consistent(x,y,id,z) ... }
    when !=3D if (y) { ... pci_free_consistent(x,y,id,z) ... }
=E2=80=A6


It is specified that a specific function call should be excluded
in a source code search.
I do not see a need to repeat the specification twice that such a call
could eventually happen also within a branch of another if statement.
How do you think about to omit possibly redundant SmPL code at this place?

Regards,
Markus
