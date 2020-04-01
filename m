Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E95FC19A776
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 10:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731680AbgDAIjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 04:39:23 -0400
Received: from foss.arm.com ([217.140.110.172]:45808 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgDAIjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:39:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 335D831B;
        Wed,  1 Apr 2020 01:39:22 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A77653F52E;
        Wed,  1 Apr 2020 01:39:21 -0700 (PDT)
Date:   Wed, 1 Apr 2020 09:39:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     oder_chiou@realtek.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ASoC: rt5682: Fix build error without CONFIG_I2C
Message-ID: <20200401083920.GB4943@sirena.org.uk>
References: <20200401082540.21876-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <20200401082540.21876-1-yuehaibing@huawei.com>
X-Cookie: The Ranger isn't gonna like it, Yogi.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2020 at 04:25:40PM +0800, YueHaibing wrote:

> -static const char *rt5682_supply_names[RT5682_NUM_SUPPLIES] =3D {
> -	"AVDD",
> -	"MICVDD",
> -	"VBAT",
> -};
> -

I imagine that the device is going to need power even when use with
slimbus, even if the regulator support isn't wired up at the minute.
For things like this __maybey_unused annotations tend to be better,=20
this stops warnings about things not being used but doesn't need ifdefs
or big code moves.

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6EUzcACgkQJNaLcl1U
h9ANrgf/f7gocQPtQBlwwICg0sIaoabV0i7a4QjmUQl+hyL/r1q0weR9P42brmMZ
EQwcm89LZOJJG8pLSonMGPeoIH0gePFlBqN4AbFl0h+uUBDfvuSZbuFnZS+AEVyd
pa2KTzaM3LAbzuwfAH0R8AkWn2WE9LmetNEGuWluP4yKYsRWLNmGsalDm/kw7ww7
zexY9Z9eOZZddfn2PBAWfqHcy7HFFXy0bB4rG2LR6KevIGp+8ZwJvs5BwllnpqiU
/O6tIY282GqwsuPFg1nktHVgUP35cQVkAF+mjddMvPI3pGMdYvAdd3YWcGmwOzJr
ZXnMzVEKsd1L8e4v9nty0/z7Fk7YUA==
=lx3U
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
