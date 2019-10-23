Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D89CE1387
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 10:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390099AbfJWIAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 04:00:46 -0400
Received: from mout.web.de ([212.227.17.12]:42675 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732328AbfJWIAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1571817626;
        bh=zXQECy0cqr175PWY8oJwBGRomnEC4rcuFjHy6KY29NI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hR23qBeeFDwbHSjrYuUd6lU22i09oI4et1b9z/wRXUaq76Vh4yBF0UQWiKZkXWe6M
         88r9NkZnHjWIYYHk+UyNldFAjGEBbyoqSoXjlHWTNCU4VI9oq2qLCwnmgyBcoX3M//
         g8FTjAoiq5cblwX9Ylyn0bEYul6GRI9O1jDIqRBI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.140.249]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MSJKJ-1iZ6kk36ct-00TUvy; Wed, 23
 Oct 2019 10:00:25 +0200
Subject: Re: [PATCH v2] clocksource/drivers: Fix memory leak in
 ttc_setup_clockevent
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <2a6cdb63-397b-280a-7379-740e8f43ddf6@xilinx.com>
 <20191023043139.31183-1-navid.emamdoost@gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
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
Message-ID: <3785f6cf-e8ea-9cd8-80b3-e88b2c4d085f@web.de>
Date:   Wed, 23 Oct 2019 10:00:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191023043139.31183-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZwerJEF5fdwavfNHN7miW3T66Gyo/LoKvX/R+eV0vTMGSbt94nI
 9d8fFadakbGcAV02nuJLvo5tUt1Vw1gIpodcLPaUGV4F/EZnTerEjFBzMPWm5kWwUPeII1R
 SgErAIePGhu8uqSP/j61I/y9sPqvHQU9cSHY3o1pWtPiB6MosXw7hu7cgTZ6LqMwBCSlQv4
 yg9Z0gezFhaQ+1Ew/RKEw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/aHY+2Rxzm8=:JWBqbgiD/urYdDE5XI3aGT
 FOostkgS7BmjqbtGTAbskQyweSLyKYVqu2PSbaSOG4D8jf5O1Z2lmzyFFNB/WUGzskAdNA3c7
 pUXlj3jeb8GOYKbadQktWrT6BPardOhAcapyxwhdoA2aBGFHe5UQ0zMajHrpcXC2Du1fxmabq
 FHoAFSonSZe3Lw0JKttFItffrw1b6nAk/qcZky6CdZmehMCucMZ3aK1K4FtboC+N5nVFXauWC
 MrWw3blW4pKgT7wSo2xNG1HAqKxlBAlVBbq3ctvMo01+RZ2qqBqrNkPaKvBJCU9IrwxprVnKa
 toLSJQFP3deibMt1l7ckLchVQL1KY1KdYvep0pTOAJhj9/3SLQBX31ohLa4xGfsBv0KD520UP
 z4fcrU6757g0VFucDr2X8maHS7ffZHlCgKT6cexQD7xFrAVRN+rT1K+Cc2IM5008RWejVlGb5
 /sDp7qyPOye9Grk5r8ezLyNxwYPLNlhj/nfu1VYiX8vqFACzMMjwM1vr4kHjHd2i8tvdl4rWA
 f1s0CdjlPRMX4ng2GcqWCj1SRui86U9/UPE4FxFRaEURM0z7IBox++4B3U7nSkezCgHPwDCTl
 Chw1KCmDaGl/+vA8uEfSQH9LqyhHteC2Fgd2PABFNWLO+bQLbS2LiiyXTpE5cx816ztRkipXw
 BnGcxsIc9ChcvN8Xl0HXemLQW/5yLcrhXQx3MoFYyVndeGVe1rPzm7g7HzkLINQB34A5QG1M1
 G6YOXeSnxapa9AY34cVe+Xzei9btQsMJ7PfbwYeANSwjfB2lAFWbU+OMfEIMq3ZBUZE4NvVGo
 /ixiVbkxcjhObta6c+Pl9Oc4b05vEVidMkWWbBqx3mj/oONchea9AUbCKZau446fLY1IJoWeS
 HILtMJ/ycs8pJ68A6AzU1VAK2crqMbWQaZWpy2V5SFMThWOF+WmKSkIeSRbdeRzHkSdz7EeTX
 IfVYud3omC9Yb23qCa5vAt4EbzGGoBgzWb+XaceEW3MDiDLZxOSdgmDfpjUth2AchZOm9bKZr
 5oQGEsY4tr4vnfdDLZSeM1Pn1+MWbH4fI2J7bMNs9nM8GoHa+dKl8Na8R6UED/ZYrilGAyTfG
 qcwctgwqK2A+bX6fwOTQ92echEHVpLZ7DEdPSvKUbds1yRZeAW6Aa0g2Iho63zWqudDd57cU3
 OQxI6SOk2/+/wroWf8QOjvJ4+ea6+YDnbHHmuKlG/r5FUIz2wCeGpwF50PjS3dZ3RReeDA2G1
 6hE+q7GPzOaYdcTptIA4h7xww9Pf29Q8UF6x7FrV6OceE3elNOCPXeUDRLCg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In the implementation of ttc_setup_clockevent() release the allocated
> memory for ttcce if clk_notifier_register() fails.

I got other wording preferences. Thus I imagine that such a change
description can still be improved another bit.
Would you like to express the addition of a jump target (according to
the Linux coding style) for the completion of desired exception handling
in a different way?


=E2=80=A6
> +++ b/drivers/clocksource/timer-cadence-ttc.c
=E2=80=A6
> @@ -453,15 +451,18 @@ static int __init ttc_setup_clockevent(struct clk =
*clk,
=E2=80=A6
> +release_ttcce:
> +
> +	kfree(ttcce);
=E2=80=A6

I would prefer that a blank line will not be added directly after such a l=
abel.

Regards,
Markus
