Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0C3E9E5FC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 12:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbfH0KoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 06:44:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48334 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfH0KoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 06:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UWpP6ASANjGbwqBx1gdjtA+jZ6LbnLc6oEyLnl6i6zA=; b=jEwtKJ1Y2lIRNkHGplE6Ps3ZH
        0JGFaedxuxOerP9ta8l3ibZ4633GzaanL+q2VhxSGuait022o7wFIUr9b1zdoh0GXJOG0hBrbXokg
        WB4IbMiMo9efixMQ6kj9pR/dzrY83khLeOo/TXZRbPC/nWk6RoOTnNoKL2xTxie/dtXb4=;
Received: from [92.54.175.117] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i2Yx6-0007sZ-Tm; Tue, 27 Aug 2019 10:43:52 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 6A743D02CE6; Tue, 27 Aug 2019 11:43:52 +0100 (BST)
Date:   Tue, 27 Aug 2019 11:43:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        codekipper@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Revert "ASoC: sun4i-i2s: Remove duplicated quirks
 structure"
Message-ID: <20190827104352.GY23391@sirena.co.uk>
References: <20190827093206.17919-1-mripard@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="15k5Fuw+yLfT1d9X"
Content-Disposition: inline
In-Reply-To: <20190827093206.17919-1-mripard@kernel.org>
X-Cookie: Don't SANFORIZE me!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--15k5Fuw+yLfT1d9X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2019 at 11:32:05AM +0200, Maxime Ripard wrote:
> From: Maxime Ripard <maxime.ripard@bootlin.com>
>=20
> This reverts commit 3e9acd7ac6933cdc20c441bbf9a38ed9e42e1490.
>=20
> It turns out that while one I2S controller is described in the A83t
> datasheet, the driver supports another, undocumented, one that has been
> inherited from the older SoCs, while the documented one uses the new
> design.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--15k5Fuw+yLfT1d9X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1lCWUACgkQJNaLcl1U
h9BE5wf/e1I8LfUK6KLnXqxYzxIjCX6f4JtBiqFI99GurXQD/tNK1q7Ldszv3Cwc
diESenhKUbt+tMgtus6JWeI71/T2BN6A1fewE6n5rhLl/tny4kmlcIlBsZIPV2z6
WFmdU15AGyRSRBIRkQwGYBxA5ViTMQqeWKXtCenIkxypv06TsBqQr047rvlgFdEf
anti8BIGziPLJtyCkpU/iCV151N9K5priltDgw0FKN0nogcyUAUWXcaAjbQi0kQe
FYtUKi/Rl3XQKqGkL4h4Z80VTlXbq60QH1npUmR8Y0WpecEci92PJ3iOmqciwfe9
sbKc1Q/++txkY4XUgNv+RDvt9Q4/zg==
=bQV/
-----END PGP SIGNATURE-----

--15k5Fuw+yLfT1d9X--
