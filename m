Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A53071431C4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 19:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgATSoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 13:44:01 -0500
Received: from foss.arm.com ([217.140.110.172]:35706 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbgATSoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 13:44:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF7F531B;
        Mon, 20 Jan 2020 10:44:00 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E8013F68E;
        Mon, 20 Jan 2020 10:44:00 -0800 (PST)
Date:   Mon, 20 Jan 2020 18:43:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Wen Su <Wen.Su@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [RESEND 1/4] dt-bindings: regulator: Add document for MT6359
 regulator
Message-ID: <20200120184358.GN6852@sirena.org.uk>
References: <1579506450-21830-1-git-send-email-Wen.Su@mediatek.com>
 <1579506450-21830-2-git-send-email-Wen.Su@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oIlomvtVtXAVxSKT"
Content-Disposition: inline
In-Reply-To: <1579506450-21830-2-git-send-email-Wen.Su@mediatek.com>
X-Cookie: I invented skydiving in 1989!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oIlomvtVtXAVxSKT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 20, 2020 at 03:47:27PM +0800, Wen Su wrote:

> +- mt6359regulator: List of regulators provided by this controller. It is named

Any great reason for not just calling this regulators like most other
devices?

--oIlomvtVtXAVxSKT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4l9O0ACgkQJNaLcl1U
h9CJ3Qf9F1Lz97+TNbVFwl3OCaMrrmSbjc2psD1Lqb+aFCX9c1c2JwLmvwJK4jf/
YWvSq2TOjt8g/5poJO36dbSjBU7tlGGvIly8ZIMpZcb/GuN+P5TEj4HoLhDtTXLX
vWhIS8j6d29tnV2TzqrrbQCoj42uvNtaE2CJjUeXXt1Hsifhf2DKKh5HZNGXGxEo
IEfqgWrmb5NjwwjiZIkiIdgcXnbaWs4KxOe5dvTC9RjhMwlnWZve9t7ZazhoQCZk
j77N3//8c21A2Iljh3NR70mS/izQMedpXjFZ49vpXbIBzZjpHoCFzKy2C7I5MCHr
Nk4O2xvPd5ZU1NMffAGo4UEcXa4L0w==
=ZKXN
-----END PGP SIGNATURE-----

--oIlomvtVtXAVxSKT--
