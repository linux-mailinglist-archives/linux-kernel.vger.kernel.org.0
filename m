Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67E2418C28D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 22:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgCSVsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 17:48:38 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:36072 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgCSVsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 17:48:38 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 11A621C032A; Thu, 19 Mar 2020 22:48:36 +0100 (CET)
Date:   Thu, 19 Mar 2020 22:48:35 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Steven Rostedt <rostedt@goodmis.org>,
        ben.hutchings@codethink.co.uk, Chris.Paterson2@renesas.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: [ANNOUNCE] 4.19.106-rt44
Message-ID: <20200319214835.GA29781@duo.ucw.cz>
References: <20200228170837.3fe8bb57@gandalf.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <20200228170837.3fe8bb57@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I'm pleased to announce the 4.19.106-rt44 stable release.
>=20
>=20
> This release is just an update to the new stable 4.19.106 version
> and no RT specific changes have been made.
>=20
>=20
> You can get this release via the git tree at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>=20
>   branch: v4.19-rt
>   Head SHA1: 0f2960c75dd68d339f0aff2935f51652b5625fbf

This brought some problems for me. de0-nano board now fails to boot in
cca 50% of cases if I move these patches on top of -cip tree.

This is example of failed job:

https://lava.ciplatform.org/scheduler/job/13037

de0-nano is 32-bit arm, should be based on Altera SoCFPGA if I understand
things correctly.

"fc9f4631a290 irqwork: push most work into softirq context" touches
area of the panic above. I tried to revert it on top of the full
series, and tests passed twice so far...

Best regards,
								=09
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXnPoswAKCRAw5/Bqldv6
8vuoAKC/ilemsFP8sD6l8Pde9X/EGm4YLwCfUn8TX1RIe2ZozX/4KwtFbGlI+Vc=
=EDGz
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
