Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4AB1325E0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 03:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfFCBEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jun 2019 21:04:08 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34833 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbfFCBEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 21:04:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45HGz84XVMz9s00;
        Mon,  3 Jun 2019 11:04:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559523846;
        bh=TPUMH0+wLPyFeMbCnZDcWd+CdbDwN49mLsSsJ+5Nsqc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ibPX6ToNA5xRBHs7E5Ee7kVh9KcxyznYQUbWROJ2FH1pcm9nMLXvGlAhMp1NDRVzM
         lPeUHqO6ts6DZ897NjnIC2Z+v7FUiOFMmtOjuTyOEnaDJrqGg7XzCxVnVamt5FWdg0
         auNUkeCTzT0KgsUfEXJ+smW3FqyG7lY5CQJjwicCkbHRk/8hhM90RmIn2ZGckbMTCE
         hOZPBkI34bx6ptVNzC87Ai7oM8E8f4qSZrNT+NWpTnhtyjOCFZD8bRQ3vd+hu0nO9q
         IitXF+objgZqs+u/7cepHWtmLKRe5xRHdU0nZm7k7T2EKyMHtNZ+3cYFlnIwyGDYby
         CmnJrzU1Xk8TA==
Date:   Mon, 3 Jun 2019 11:04:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: linux-next: unable to fetch the drm-intel-fixes tree
Message-ID: <20190603110403.0412ed22@canb.auug.org.au>
In-Reply-To: <20190603082051.273a014c@canb.auug.org.au>
References: <20190603082051.273a014c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5W7rw6vAer0=o7AaXUmcNmr"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5W7rw6vAer0=o7AaXUmcNmr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Mon, 3 Jun 2019 08:20:51 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Hi all,
>=20
> Trying to fetch the drm-intel-fixes tree today gives me this error:
>=20
> -----------------------------------------------------------------
> fatal: Could not read from remote repository.
>=20
> Please make sure you have the correct access rights
> and the repository exists.
> -----------------------------------------------------------------
>=20
> The same for drm-misc-fixes, drm-intel and drm-misc.  These are all
> hosted on git://anongit.freedesktop.org/ .

Also the drm-tegra tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/5W7rw6vAer0=o7AaXUmcNmr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz0cgMACgkQAVBC80lX
0GyutggAkt963tpYucPsS7tkFsqUNexKruuFUV3lneI2aaDDOXLIv0H1j9lR9Rze
SJADEGvKHTn4tKSScsBSo0R+h67eTpaTg7TEvKwX6Le1zHWPRWpScsYh1pXCQpSu
uf8OSZ48VRyFpxYR8+HGupbAEi6bXURdkxLfxpH3sqBrCzHxMHaKixBX4VxORsKX
JprO+cTlKokWFlRgKIo2UXvTOJjrFsT89uvcwC4zh26vBPcoAueAh23rrZdS79mA
wu0+TrGsgX31O2YMnDCfwvePWvV+LG7u7KTPyAoQ5etpt9plvc+HN3oRbDbTq+NF
jL5PqgH4emtjWvX/IbKbjgXEMWq58g==
=95C5
-----END PGP SIGNATURE-----

--Sig_/5W7rw6vAer0=o7AaXUmcNmr--
