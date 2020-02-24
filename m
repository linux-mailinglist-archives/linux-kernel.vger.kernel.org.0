Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5D5516A5B0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 13:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbgBXMFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 07:05:15 -0500
Received: from foss.arm.com ([217.140.110.172]:36098 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbgBXMFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 07:05:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F2D630E;
        Mon, 24 Feb 2020 04:05:14 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8D533F534;
        Mon, 24 Feb 2020 04:05:13 -0800 (PST)
Date:   Mon, 24 Feb 2020 12:05:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     hns@goldelico.com, j.neuschaefer@gmx.net, contact@paulk.fr,
        GNUtoo@cyberdimension.org, josua.mayer@jm0.eu, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] regulator: core: fix handling negative voltages e.g.
 in EPD PMICs
Message-ID: <20200224120512.GG6215@sirena.org.uk>
References: <20200223153502.15306-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V32M1hWVjliPHW+c"
Content-Disposition: inline
In-Reply-To: <20200223153502.15306-1-andreas@kemnade.info>
X-Cookie: How you look depends on where you go.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V32M1hWVjliPHW+c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 23, 2020 at 04:35:01PM +0100, Andreas Kemnade wrote:

> An alternative would be to handle voltages as absolute values.
> There are probably no regulators with support both negative
> and positive output.

This is what'd be needed, your approach here is a bit of a hack and
leaves some values unrepresentable if they overlap with errnos which
obviously has issues if someone has a need for those values.  Ground is
to a large extent somewhat arbatrary anyway and some systems do just
redefine it as part of their normal operation (eg, VMID based audio
systems) so this wouldn't be a huge departure.

--V32M1hWVjliPHW+c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5Tu/cACgkQJNaLcl1U
h9BL5Af/WPTDV2LiQ0EfvbEoe69ncxjQzpbExi/NqE3yTTUvNpsBOcy2Ydt6UKpG
VH1g+nGRFmHX4lBVbjgR22QZNPyd385zViCuO0Rj9XWMYEvqt7lFwEVdTObPbF2s
AlW9CrwEJ5kUGYeTF2MXejPyDricVcrTke8YNK7RyZr/UWa9OuG7z9bOi298Pspr
859CJgZCeCPlu4LYuW2U7dtHEZiDxsmU2GNFkR8MwROUuApvz6x968a/r8E7lHD6
Ds9HBFcJ8UJk28gIMSi8oYMZ6/AvEKskc2vipKVcuG1Go4dDVxT/4lgTwfRNbCmU
Sa7dUBnOnMpA+CqR0PaUsQdowrW8wQ==
=Eqzw
-----END PGP SIGNATURE-----

--V32M1hWVjliPHW+c--
