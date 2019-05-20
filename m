Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD05E243F2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 01:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfETXNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 19:13:45 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44282 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfETXNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 19:13:45 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9F9AB8030E; Tue, 21 May 2019 01:13:32 +0200 (CEST)
Date:   Tue, 21 May 2019 01:13:42 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org
Subject: Re: 5.2-rc0.8: emacs segfaults?! x220, with 32-bit userland
Message-ID: <20190520231342.GA20835@amd>
References: <20190519221700.GA7154@amd>
 <20190520160636.z6fpjiidc2d5ko5g@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <20190520160636.z6fpjiidc2d5ko5g@linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > emacs segfaults... when I attempt to exit it. And that did not use to
> > be the case. Nothing suspect in the dmesg. Rest of the machine seems
> > to work ok.
> =E2=80=A6
> > Ideas welcome...
>=20
> I assume that this happens with -rc1, too. Could you please check if
> emacs still segfaults with commit
>=20
>   d9c9ce34ed5c8 ("x86/fpu: Fault-in user stack if copy_fpstate_to_sigfram=
e() fails")
>=20
> and commit
>=20
>   89833fab15d60 ("x86/fpu: Fix __user annotations")
>=20
> ?

I don't have reproducible test case :-(. I had two or three failures
so far.

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzjNKYACgkQMOfwapXb+vIbQgCdGpLb+RiI8xUDh9JkMjagiEYK
MZYAnia/9SFoppzCNtLy3IGeCfzdKtvU
=ZjfV
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
