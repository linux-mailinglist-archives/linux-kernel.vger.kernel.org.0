Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFC02120720
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 14:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfLPN12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 08:27:28 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:36408 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbfLPN11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:27:27 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 26AE31C25BD; Mon, 16 Dec 2019 14:27:25 +0100 (CET)
Date:   Mon, 16 Dec 2019 14:27:24 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Daniel Wagner <wagi@monom.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>, Pavel Machek <pavel@denx.de>
Subject: Re: [ANNOUNCE] 4.4.206-rt190
Message-ID: <20191216132724.GA22097@amd>
References: <20191206104701.CC686500518@mail.monom.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <20191206104701.CC686500518@mail.monom.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I'm pleased to announce the 4.4.206-rt190 stable release.
>=20
> This release is just an update to the new stable 4.4.206 version
> and no RT specific changes have been made.

Thanks!

I'm getting failures with one of our configs:

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/380509098
https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/103388506

This failure is not new, we have been working around it for a
while. It can be fixed using:

git cherry-pick 8409299

https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/103395886

(If you prefer, I can submit patch via email).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl33hjwACgkQMOfwapXb+vJFOQCfX+nPrUMzOKpgLU1yga1MOTLy
enIAnjegMxvmlrJAEziGfzPNGvwCN65J
=xu2V
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
