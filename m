Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C40E80572
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2019 10:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387900AbfHCI62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Aug 2019 04:58:28 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45269 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387730AbfHCI61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 04:58:27 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A89F38031B; Sat,  3 Aug 2019 10:58:13 +0200 (CEST)
Date:   Sat, 3 Aug 2019 10:58:24 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Olof Johansson <olof@lixom.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] ARM: dts: mmp2: add OLPC XO 1.75 machine
Message-ID: <20190803085824.GB8224@amd>
References: <20190802103326.531250-1-lkundrak@v3.sk>
 <20190802103326.531250-7-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
In-Reply-To: <20190802103326.531250-7-lkundrak@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-08-02 12:33:26, Lubomir Rintel wrote:
> This is a fairly complete description of an OLPC XO 1.75 laptop.
> What's missing for now is the GPU, LCD controller, DCON, the panel and
> audio.

Ok, but I need GPU/LCD/panel... that's my only output. Is video
expected to work in 5.2? Does the firmware pass right device tree,
including the GPU/LCD/DCON?

Is there config somewhere I could use?

Thanks a lot,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1FTLAACgkQMOfwapXb+vKvhwCfRiwZa8E3fNBqMi6b0KGpOPIQ
EL0AnjUujlV3bPaUb0uSNTtgJ13k53kC
=DqjA
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
