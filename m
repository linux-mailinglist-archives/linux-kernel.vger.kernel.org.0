Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A54FAA343
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 14:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732994AbfIEMdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 08:33:13 -0400
Received: from mout.web.de ([217.72.192.78]:57205 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731438AbfIEMdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567686777;
        bh=XfQXB2vIZe2JukTJVFUwHi4vpiAorDqzVl4iR6s4MU8=;
        h=X-UI-Sender-Class:Cc:References:Subject:From:To:Date:In-Reply-To;
        b=e99iYp1PbHtyxwKkP1vcOOeJMfVbmpSk9zTCP3MqIF9mxIGuTPyI5C1aF7tdJhUof
         gF5f/dHMI0Zhj4iDKnpy69ytMpmJlJ0/rOEcKdIEnUrJnvu/WhU+udDyYWkk8JjWwf
         hUpyfYxssvM/8e4CBa3dqELJRtAGRKKvQLjNp1/M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.131.221]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M5x3d-1iLD60023N-00xovn; Thu, 05
 Sep 2019 14:32:57 +0200
Cc:     linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <20190904221223.5281-1-efremov@linux.com>
Subject: Re: [RFC PATCH] coccinelle: check for integer overflow in binary
 search
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org
Message-ID: <8f454c56-735c-0620-ead4-b59e328b0283@web.de>
Date:   Thu, 5 Sep 2019 14:32:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190904221223.5281-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZXkurD9h48YNUpH2sA9zXRQ7s8GTYYE8Wv1K0E1TnIYYk7loz1a
 eb9BGhjNIRwZVsqYEgXUKmhGxxBYAITOtev0+g6zR9a5VBLM9ofY9SAGCSeL+tr8ytvGdtR
 aDkHqgvR6Z16WXFR91LoTQNvHfHkkZhkiobhwYYGHvSUaGNIe1ju2NWm7/vGLUWjPNlB30Q
 bo97IAYqVs+LM2RxjF9fw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UAQlLQyjxKU=:00X0gjPswzSxNVfINMEUe/
 xGHfGxJ9+mKqN9BXiNLmZ4RHTIza8BTZsig2AbNuVLp2z6lD+n8hT/iNTXHwOIYjsPkF9258c
 FKUwKUyCgi4PHgnfjy7aDC1Kgs9AkUyFZdhvL2w5nXd+2P4kCCq6gBsm+E1mHYmc+vYm+ep5L
 gDyv77K0+DYybDX582sUV7qsBOLCE5sv8ixW+6Ht2H7TzCNvaMhfUUkUv7r4woGT3pNNcer7d
 bP2NcTXSSKRHjahqOlS5dfk0lXhPC05s4SMnREU+/c3TDH/+1mG4B1xhuAIu59tG5TGE00ru3
 4ryS0y38aXTfzUyvPXkrlYZ8D68CObPW8XQixRpihmTmzaKQQFPMJ2Jj54M0G91Le+d040upq
 38yhupY1G32D9MI9wBbBx/xJNkcdylcuFSh7OoiF90nRgzB7tVoYHGhi/Oq9yDGcJMFonAbeY
 G/lPVGB63I9NwBH7Wzj7mnqBdeTqQICNCj/ZtzUSEFtxhtGhouvDqfhMHScj8kD8LQcpy7kBZ
 egXWORYq8q/QgiZKLHCduePGcAqUtXwsHf+wolj6YBRMlYLkrJSNvYV/V2c1vuyn3qG5mH/HN
 BylPvUHiDY95TGwMc7iaUa7NQWVk8ZwX1vRF9u9y2MFeM0ZZ4dkIolflgRegTMO9aipYOaDWP
 /JpL+NueMgWHoBr3dYbwOu2m+RyGCmqiKevEfoY41aM+iqqKYXlz3on2LrgTVdFg2bYkv5KOm
 I5/RHfdLtLpS6dxndYyuVii3X0VArRoeQkwWSm/aK5jqu7mV0wnyNwg9E/vlYaAmN/3ckZeTm
 SRmnCdqEQmpKGLWG3A+uh8dOw5gHOxoRkrIusIxBV+37dF8fU4NcfxaBHkQSZYITNewW/TMci
 lR7xkmVSFUbChtAjvhaUNT/LUf6Hnv0Ki6MZpg0FylkMqEAVDGOmsp7sxlued+DDNYXyPWL3M
 8ln8oBfN91yQZukEhbcRvnaZLdH0Y2RyvtIECYIEteaKzkfA7ssDhBk6dY2rPnB1N6o85aUYv
 STlQJQHB0G3d4ZDKU0bF172mkig96yplMM1n5p9qUlYOl3ABn2CSn2VOX1+3811kqFbRH5uWk
 V3Ptcef/M66Q04w35xhFrjz7ezavlG+dBUaSaRA9hRlRbDwdjiNXCMQdKn0UDJq+xaJl9qyQK
 Zs5LgTPvLeuGsK4NRxT5DkPyhl3qXuVeaPUXciM673lwTeVpma0c7Ou5/ymOs4S9wiAOa53qt
 NvdkDqmDT52h+Y0kk
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +identifier l, h, m;

Can expressions make sense for these metavariables?


> +@@
> +(
> + while (\(l < h\|l <=3D h\|(h - l) > 1\|(l + 1) < h\|l < (h - 1)\)) {
> +  ...
> +(
> +  ((l + h)@p / c)
> +|
> +  ((l + h)@p >> c)
> +)
> +  ...
> + }

* I suggest again to look at further possibilities to reduce undesirable
  code duplication also together with the usage of SmPL disjunctions.

* The condition specification might be easier to read with a few
  additional spaces (or the following variant).

* The SmPL ellipses will probably need further considerations.


+@@
+(
+ while (
+(       l \( < \| <=3D \) h
+|       (h - l) > 1
+|       (h - 1) > l
+|       (l + 1) < h
+)      )
+ {
+ <+...
+ ((l + h)@p \( / \| >> \) c)
+ ...+>
+ }


> +@script:python depends on report@
> +p << r.p;
> +@@
> +
> +msg=3D"WARNING: custom implementation of bsearch is error-prone. "
> +msg+=3D"Consider using lib/bsearch.c or fix the midpoint calculation "
> +msg+=3D"as 'm =3D l + (h - l) / 2;' to prevent the arithmetic overflow.=
"
> +coccilib.report.print_report(p[0], msg)

The Linux coding style supports to put a long string literal also into a s=
ingle line.
Thus I find such a message construction nicer without the extra variable =
=E2=80=9Cmsg=E2=80=9D.

Regards,
Markus
