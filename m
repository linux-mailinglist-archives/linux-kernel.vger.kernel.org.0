Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9533C1668DB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 21:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgBTUsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 15:48:37 -0500
Received: from foss.arm.com ([217.140.110.172]:51318 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728936AbgBTUsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 15:48:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6072E30E;
        Thu, 20 Feb 2020 12:48:36 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9A3C3F68F;
        Thu, 20 Feb 2020 12:48:35 -0800 (PST)
Date:   Thu, 20 Feb 2020 20:48:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ASoC: tlv320adcx140: Add the tlv320adcx140 codec
 driver family
Message-ID: <20200220204834.GA20618@sirena.org.uk>
References: <20200219125942.22013-1-dmurphy@ti.com>
 <20200219125942.22013-3-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <20200219125942.22013-3-dmurphy@ti.com>
X-Cookie: I'll be Grateful when they're Dead.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2020 at 06:59:42AM -0600, Dan Murphy wrote:
> Add the tlv320adcx140 codec driver family.
>=20
> The TLV320ADCx140 is a Burr-Brown=E2=84=A2 highperformance, audio analog-=
to-digital
> converter (ADC) that supports simultaneous sampling of up to four analog
> channels or eight digital channels for the pulse density modulation (PDM)

This doesn't apply against current code, please check and resend.

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5O8KEACgkQJNaLcl1U
h9Bt2Qf+NPWxuWjvFJykGdOsQaUJzxyvmW97nFWbcYWGFf6iFFmEHq4uXC0zbBWI
oC7YOTUca78ofsuv7fU9sWAdVMPSB9znSXs+tArD+7e/yUaIhLvSDGEQ7RxwQQ6e
42A18z1q1pI5zuEWlg99RISaeC/yqcpFOT9GevJ6DgP+6k1FGqQwzQ8UChGnggtt
L4q0lG/lEUAEyCCNyhdIKHJkr9Ba++dN9tQptfjofqFgZzAhYb7YdsFln/9xWF69
VXSdPEF0Mz4f36lMCBi7UUvzq+2qFGyc6qTCLq0I5YeDj7j0y4/1o/KofgLH2XFM
wwcuIR1f5tsq+mBxv3jKsG3kFFSRjw==
=X0sz
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
