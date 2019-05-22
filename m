Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B90A269E3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 20:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbfEVSdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 14:33:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59990 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbfEVSda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 14:33:30 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 939A980477; Wed, 22 May 2019 20:33:19 +0200 (CEST)
Date:   Wed, 22 May 2019 20:33:29 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org
Subject: Re: 5.2-rc0.8: emacs segfaults?! x220, with 32-bit userland
Message-ID: <20190522183329.GB10003@amd>
References: <20190519221700.GA7154@amd>
 <20190520160636.z6fpjiidc2d5ko5g@linutronix.de>
 <20190520231342.GA20835@amd>
 <20190521073240.mikv2ufwyriy4q7r@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
Content-Disposition: inline
In-Reply-To: <20190521073240.mikv2ufwyriy4q7r@linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I did not notice any new crashes.

> > I don't have reproducible test case :-(. I had two or three failures
> > so far.
>=20
> oki. Could you please send me the output of
> 	dmesg | grep fpu

Here you go:

Using method `randr'.
pavel@duo:~$ uname -a
Linux duo 5.2.0-rc1+ #32 SMP Mon May 20 12:51:17 CEST 2019 x86_64
GNU/Linux
pavel@duo:~$ dmesg | grep fpu
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating
point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE
registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX
registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is
832 bytes, using 'standard' format.
pavel@duo:~$
model name	: Intel(R) Core(TM) i5-2520M CPU @ 2.50GHz

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzllfkACgkQMOfwapXb+vIclACgtZ6OgSaXeEXhXCbOHNQGUpk7
hMAAnROrvOmR736ERRk5MWEyDogg1PIl
=782N
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--
