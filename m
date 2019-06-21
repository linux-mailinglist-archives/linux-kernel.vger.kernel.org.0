Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA5C4E69C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 13:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfFULBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 07:01:11 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51994 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfFULBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:01:10 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 7C7F28057B; Fri, 21 Jun 2019 13:00:58 +0200 (CEST)
Date:   Fri, 21 Jun 2019 13:00:55 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH 1/2] f2fs: use generic EFSBADCRC/EFSCORRUPTED
Message-ID: <20190621110055.GC24145@amd>
References: <20190620033615.32284-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="XMCwj5IQnwKtuyBG"
Content-Disposition: inline
In-Reply-To: <20190620033615.32284-1-yuchao0@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XMCwj5IQnwKtuyBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-06-20 11:36:14, Chao Yu wrote:
> f2fs uses EFAULT as error number to indicate filesystem is corrupted
> all the time, but generic filesystems use EUCLEAN for such condition,
> we need to change to follow others.
>=20
> This patch adds two new macros as below to wrap more generic error
> code macros, and spread them in code.
>=20
> EFSBADCRC	EBADMSG		/* Bad CRC detected */
> EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
>=20
> Reported-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--XMCwj5IQnwKtuyBG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0MuOcACgkQMOfwapXb+vJkywCgvirSevUuEB2LNBfOcjGRh0UC
8SoAoK/GfYo7jR5ee7+epqSdXILguN0w
=l+QU
-----END PGP SIGNATURE-----

--XMCwj5IQnwKtuyBG--
