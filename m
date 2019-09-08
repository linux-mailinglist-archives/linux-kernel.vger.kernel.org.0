Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3648ACD71
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2019 14:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731576AbfIHMtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Sep 2019 08:49:36 -0400
Received: from mout.web.de ([212.227.15.14]:35579 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731526AbfIHMtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567946931;
        bh=64n2i/+x9VuLbn5y3oTsEsYv5qVvKCd8Jhx5xBFFssc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=II1LDTk9KldM1ji4hrCt6moQ9aNn5H5aQjeeYD2zwgtCZdYAxF3EUcs7s9jbx1oq1
         s4YzcF/6xit+VspAD/CfuaXyogByNk6+viqc/RwjX6Yd4lygNijBPkE9ei+Toaivp2
         PYU7/0Fpf63Obv12HC67b6f89i9mN/cau/8++JMg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.171.128]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MEqOg-1hwR9l2khe-00G2ED; Sun, 08
 Sep 2019 14:48:51 +0200
Subject: Re: Coccinelle: pci_free_consistent: Checking when constraints
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Petr Strnad <strnape1@fel.cvut.cz>,
        Wen Yang <wen.yang99@zte.com.cn>,
        LKML <linux-kernel@vger.kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <lkml@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yi Wang <wang.yi59@zte.com.cn>
References: <9666134d-0ff6-81eb-b088-f0086a0e61b1@web.de>
 <alpine.DEB.2.21.1909081019020.3340@hadrien>
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
Message-ID: <63e433b4-06cf-cecc-46e0-9f31226f71d0@web.de>
Date:   Sun, 8 Sep 2019 14:48:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909081019020.3340@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:cnUzcmv9Op0ghjjuTrlV117lBDIKYvwwuyfCVyH3UAvZKyJV6B5
 E47QIPoKZ/UWVUZTGQcnFXTv8TOV5/qPfSGyr/ixIqRZVRfBhX7rF4G4BFsECckIisl/htP
 2q6IgoAPBjJDgAaCdXVldWyvRIZ3WQ9WGvFWgZFTM+G9LbZUyEHWnq/VWAS0E7Qu4goTcul
 yHwYGZltV5+fytDtEpDqQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MeUWalmLQzg=:UNbC3T7JRvjkSf59YfVk/E
 ZQr/HDj63eah6c4aMB/C1Gv8wXYv8i3XC2zIY5zCy64lHsh4CAV8UZ1quJugXOBmEbNY0Wtmg
 aEAtKn9rtSmLHXEIOj0fmE1UfoeBca1jKCjtbmXLID07nIkD7SB9B2/2cv0WBy/zchcrxPAyH
 dac/2C6K1q5uchsWgYEvKNLh0Z5ZxM2cNB7+/HiTyQAQ63Rdj/eFkFHBqFOlrIMECpnJLqd9e
 77j8UMjGnDgJfC4Di0h5a5kfVgOFzOEr6pjP5wRYIpqLSTRXbfwekuJsBXiy/ahA9Gk3y65VE
 v8I4oXJYwPUGNMYQHLalLR57vqzB71Tae35RPzO93Y5LmSXiv2cLJ8R4/hWy7F4qopn4fE2dn
 4gyP+Ng8aEFg8haj9Mnf5upnqJwAqntflt9VfXlTBkjF5kT2aQYJCwoLTPqG5tGEqLZr4WScj
 oXqdOHlothqsI/wHFlgCLs+OE4Fqcf30fqxM2bkXREA/V/EoGfgCwmvakmudFNWY//yoIo5kK
 o8Hner3w1joABRlpBojB7OX9jBeugnok5NE0e4wnki/4S4noNZeTGCNsIH3/43xsEoVLDjav5
 9GQS0gaN8BKUl75i1dNaj04Vnmy4+litqC3pmZ7tdSiCYj5lXyM0is7t/vS746kI0k/vUQ77N
 GXFcizzPUTuoe5fLSOYdboOu32frZcy4wbhaq8AZ13hqPq8v9FY4LZ+psrRjHZQn8dtm3dy+y
 57qIxqL/itD+I+m00fv6Mv4Cy88UcokH7/QCsUewzWu7uzoMnnExjLqjsSgvaaaYmbQd3Ov33
 vVPbTjAcLFi7OaWjnckU8phMsvbfID18oPdnhXCr3LQ2pN2T4bmS3zu/pn0nC0hEczp9HcuiL
 f70otUGlxUWmLlJ3AulaawWS4O0Q0ss4gg/S1zFew1sccsdjBmNEEEAPphjI3R4WUYWrz8xqe
 TOpVXHtnPzOnh01U0XM//MXdOzMAfrxX5Tv2pnP38nSniMfpotbgOGut0m1erCRAIFW3Rk8MQ
 y+hAPy3K949o9hvaL4tugzMz3L+zdOf7/B/n+OxBnfJnEMHE8LU9a5ty0RoDjtYCcmfaZlsZc
 BE5GECy52qLgUn+BMH7GcgNNHqJc2pP4+CVgx3lla2KlXuDIUmEi9mvi0ZGrg77XX782rT/i0
 +rmNO590jqZ6oPNvMeFFFDr+xPJmjgoDrLsvOujabww0czc5OQr5w70nfgJggEIFZTyucgi+J
 RE4LJ50fOqg2DCbU2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The when exists below these lines has an impact.

This parameter should result in a desirable effect.


> I believe that the rule is ok as is.

I wonder about the relevance of the shown double if statement exclusion.


> A single path may have no call to pci_free_consistent,

We come along different views around the provided software functionality
once more.


> but if it has that call under one of the mentioned ifs,
> then the path is still ok,

I find that this information can need further clarification.


> and not something that an error should be reported about.

I do not expect an error message from the SmPL script execution here.

I just try again to clarify if the specification of a single function call
exclusion can (and should) be sufficient also at this place.

Regards,
Markus
