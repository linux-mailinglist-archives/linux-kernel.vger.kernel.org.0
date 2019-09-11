Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C661BAF9C5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 12:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfIKKCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 06:02:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60552 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfIKKCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 06:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pTbpqrHj7aQmZyZnA/6i489QjPmL7UgQI7j5Sr5hjvQ=; b=Hd2nqClDILTCI/MWaR0/7sM/+
        ugLX3v7McP1kab0kWucD8KZSi9h9FbVkYjH8N+w/jIC/ffHB3DeftjnI8FZhwp/tQ73OPqVfrt2Q7
        az6kmcvxKZBXa0/xp9yxkq61L+Hl4fQIQ8AgNQjguafKvg79y2I0BBNKT23yG6IYToVnQ=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i7zRV-0007WE-3f; Wed, 11 Sep 2019 10:01:41 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 3F49DD02D76; Wed, 11 Sep 2019 11:01:40 +0100 (BST)
Date:   Wed, 11 Sep 2019 11:01:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     shifu0704@thundersoft.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, navada@ti.com
Subject: Re: [PATCH] tas2770: add tas2770 smart PA dt bindings
Message-ID: <20190911100140.GQ2036@sirena.org.uk>
References: <1567753564-13699-1-git-send-email-shifu0704@thundersoft.com>
 <76759c2c-3f5d-5cf6-fc2b-feb1dc8c0e6a@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="movZSYdJ761vCHaE"
Content-Disposition: inline
In-Reply-To: <76759c2c-3f5d-5cf6-fc2b-feb1dc8c0e6a@ti.com>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--movZSYdJ761vCHaE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2019 at 08:21:25AM -0500, Dan Murphy wrote:
> Shi
>=20
> On 9/6/19 2:06 AM, shifu0704@thundersoft.com wrote:
> > From: Frank Shi <shifu0704@thundersoft.com>
>=20
> Subject should be
>=20
> dt-bindings: ASoC: Add tas2770 smart PA dt bindings

I do find it easier to use "ASoC: dt-bindings:", helps avoid
things being missed.

--movZSYdJ761vCHaE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl14xgEACgkQJNaLcl1U
h9CXjgf+JQRRVLHQoSSpOsqlLKQrEf6L37/E55LewVtk40xn8v7aNXy2CaKD7rw5
G2s81qVCi40CLuqGdGJkJNa7Iu8g9e7mD22MsbYagjRcsSQF0P2KNk40/RucW/xl
GmrAMqd5U8JiDeqd63+YpnrsECWTITr/4Tqa+ou++ps0HpWt5XNdjY6RPn47eoLm
GJhwK0pPoM0FFCwuk/78UQ/Tx/P2jXVYkPUXlTSorXC7nZFLOJFiy9QsZIy54CJv
QnEjfeZmAc1Dzz0+ddxF9bD9F4SIA59ejyJP3LFeS2LADc4fGipubl1ZM9uRTbaw
mdLuyZtqvi4imhiDcd84wOV6tL/ULQ==
=9/FT
-----END PGP SIGNATURE-----

--movZSYdJ761vCHaE--
