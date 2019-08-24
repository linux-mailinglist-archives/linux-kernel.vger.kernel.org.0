Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4885C9BA03
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2019 03:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfHXBQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 21:16:41 -0400
Received: from shelob.surriel.com ([96.67.55.147]:47894 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfHXBQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 21:16:40 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1i1KfP-0006eX-Nu; Fri, 23 Aug 2019 21:16:31 -0400
Message-ID: <fc8cf5880617794db442c6b0e879f3130ccb06c9.camel@surriel.com>
Subject: Re: [PATCH 11/15] sched,fair: flatten hierarchical runqueues
From:   Rik van Riel <riel@surriel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, peterz@infradead.org,
        mingo@redhat.com, morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.net, vincent.guittot@linaro.org
Date:   Fri, 23 Aug 2019 21:16:31 -0400
In-Reply-To: <967114b2-15a7-b445-3133-074732b20e34@arm.com>
References: <20190822021740.15554-1-riel@surriel.com>
         <20190822021740.15554-12-riel@surriel.com>
         <967114b2-15a7-b445-3133-074732b20e34@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-w1bMIaOqu9g87QXE4qNV"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-w1bMIaOqu9g87QXE4qNV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-08-23 at 20:14 +0200, Dietmar Eggemann wrote:
>=20
> Looks like with the se->depth related code gone here in
> pick_next_task_fair() and the call to find_matching_se() in
> check_preempt_wakeup() you could remove se->depth entirely.
>=20
> [...]

I've just done that in a separate patch in my series,
in case we need it again.  If we don't, diffstat tells
us we're getting this:

 include/linux/sched.h |  1 -
 kernel/sched/fair.c   | 50 ++-----------------------------------------
-------
 2 files changed, 2 insertions(+), 49 deletions(-)

Thank you!

--=20
All Rights Reversed.

--=-w1bMIaOqu9g87QXE4qNV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl1gj+8ACgkQznnekoTE
3oPqngf9GYkPsqw0Zwi+zHirHX0hPKIimI2a8Cu7cmRcVDogGxwuQgke/AomGZcR
52hcdThUNcC64eazKkFS5cPElhRx3S/8NFcDrtRj/rnY+pGmAlq8diHzRWmuzMio
pn/Wct1eeNTT9X1uSAuvno7YK/nRcZtz7skRZ2D/N4JKUbV6Chv560vySaxQJ4Ue
Eoa7B91YrzoC2nbLVe01zc+XhWlAjsVQl2s2OymB5ZQ/OCj+S+SCitFL75b6QVXn
VBMFFSVEZ7FJxVsobAG+IYkEGcxfTtpFBHxyp+s+6MPLr1nCOzn1faF0SEd5L+BJ
Slj0ePzrCqiTswG8tmoFO8xGBTC4aw==
=gT+/
-----END PGP SIGNATURE-----

--=-w1bMIaOqu9g87QXE4qNV--

