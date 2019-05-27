Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 534252B5FA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 15:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfE0ND5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 09:03:57 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55166 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfE0ND5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:03:57 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 92D4C804DE; Mon, 27 May 2019 15:03:45 +0200 (CEST)
Date:   Mon, 27 May 2019 15:03:55 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org
Subject: Re: 5.1.0-next-20190520 -- emacs segfaults on 32-bit machine Re:
 5.2-rc0.8: emacs segfaults?! x220, with 32-bit userland
Message-ID: <20190527130355.GD19795@amd>
References: <20190519221700.GA7154@amd>
 <20190520160636.z6fpjiidc2d5ko5g@linutronix.de>
 <20190520231342.GA20835@amd>
 <20190521073240.mikv2ufwyriy4q7r@linutronix.de>
 <20190522183329.GB10003@amd>
 <20190523083724.GA21185@amd>
 <20190523145035.wncfmwem57z2oxb7@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uCPdOCrL+PnN2Vxy"
Content-Disposition: inline
In-Reply-To: <20190523145035.wncfmwem57z2oxb7@linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uCPdOCrL+PnN2Vxy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-05-23 16:50:36, Sebastian Andrzej Siewior wrote:
> On 2019-05-23 10:37:24 [+0200], Pavel Machek wrote:
> > Hi!
> Hi,
>=20
> > > I did not notice any new crashes.
> >=20
> > New crash now; different machine, way -next kernel... and I even have
> > a backtrace.
>=20
> could you please send me (offlist) your .config? Also, what kind of
> userland do you run? Something like Debian stable?

You have configs in your inbox.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--uCPdOCrL+PnN2Vxy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzr4DsACgkQMOfwapXb+vLWPwCePd1bBtjdMfmWSAWkkpcBVuym
UZQAoI3misUfpn58FwY/1kUf1Bi8HSo1
=Ulg1
-----END PGP SIGNATURE-----

--uCPdOCrL+PnN2Vxy--
