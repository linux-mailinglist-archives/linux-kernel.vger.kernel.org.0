Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC7E1187BE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 13:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfLJMMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 07:12:30 -0500
Received: from foss.arm.com ([217.140.110.172]:41976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727224AbfLJMMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 07:12:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAF9B1FB;
        Tue, 10 Dec 2019 04:12:29 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B3073F6CF;
        Tue, 10 Dec 2019 04:12:29 -0800 (PST)
Date:   Tue, 10 Dec 2019 12:12:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH] regulator: max77650: add of_match table
Message-ID: <20191210121227.GB6110@sirena.org.uk>
References: <20191210100725.11005-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline
In-Reply-To: <20191210100725.11005-1-brgl@bgdev.pl>
X-Cookie: We have ears, earther...FOUR OF THEM!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2019 at 11:07:25AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>=20
> We need the of_match table if we want to use the compatible string in
> the pmic's child node and get the regulator driver loaded automatically.

Why would we need to use a compatible string in a child node to load the
regulator driver, surely we can just register a platform device in the
MFD?

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3vi6sACgkQJNaLcl1U
h9AxEgf/TvX4dvYvOdsMIU+gw9Fz158LM8Zk7qaTQYSFPbhVYTocSHCpdHDt9xNj
ysK6EPgDiizujqpFnkFLS8Ut8mS4uhfHvIHuqtEMXkq4W7NbnOr+0ITwETWbb0qd
2sS0LyHuSo4ADTeMv/WM9IUtCQkcLPL5JubAWiGw7IDVnI+AmPg/iCJR8/whQjvw
v8UgBN7cdnrwjO/jtCQqqoTIqUywQ4uRTrhpVpXAXTgRa7BQh0ORcoZQX+iZ50ci
DFQFME8cdM4/mpwKGS2AxXoKOarEr42x22ajrZskbW8IYhJ+DwVZjWWZdKUn+l9S
dS3Pu9UaAdQ3alqs/h3XqNJvqQxqqg==
=o1SK
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
