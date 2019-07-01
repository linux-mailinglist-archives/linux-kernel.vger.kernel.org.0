Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B36820338
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 12:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfEPKLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 06:11:55 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43950 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfEPKLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 06:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IzKP9HLNlXee2M6iLMR2LM7xnjvarDZVD2/6gMH+Tcg=; b=GNk6DCqF9bgIUJZ/MEMc9fegQ
        35Vx2DnTyiPqsu7Y6lI7IgL1vj/3eHS+pUx+lqDfCSVJMJqWIUXs3CB/BXWkuJM3p2TA9Zf/sbg/y
        ZkklGYCeOADwzVt0vwXha0hmy0KzYr8xO0b8VC31LoqzIqnmf2E2cJXTL3Yc7JW6Xu8r0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hRDMS-00061J-O3; Thu, 16 May 2019 10:11:40 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id AD4D11126D3F; Thu, 16 May 2019 11:11:36 +0100 (BST)
Date:   Thu, 16 May 2019 11:11:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "brian.austin@cirrus.com" <brian.austin@cirrus.com>,
        "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] ASoC: cs42xx8: Add reset gpio handling
Message-ID: <20190516101136.GC5598@sirena.org.uk>
References: <95eb314ef6d47ee6581094a406516a6069278d56.1557986457.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZwgA9U+XZDXt4+m+"
Content-Disposition: inline
In-Reply-To: <95eb314ef6d47ee6581094a406516a6069278d56.1557986457.git.shengjiu.wang@nxp.com>
X-Cookie: <ahzz_> i figured 17G oughta be enough.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 16, 2019 at 06:04:58AM +0000, S.j. Wang wrote:

> +	cs42xx8->gpiod_reset = devm_gpiod_get_optional(dev, "reset",
> +							GPIOD_OUT_HIGH);
> +	if (IS_ERR(cs42xx8->gpiod_reset))
> +		return PTR_ERR(cs42xx8->gpiod_reset);

You also need a binding document update for this.

--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzdN1cACgkQJNaLcl1U
h9B77wf6Am2asgXqw+nI5Ts2nEP5jHpq8r6uTGJ7oAsVZ/DvX7MFJgwRwYwmfaiI
DcGaR6tx0sMwGjHVhLVu4mMG7vAgjkkwNMi7OArvG9hF+c9A4CLy84gQMlxwScqQ
TR562sJfuDfzwI5sA0+FSuZAg3To/WGO9X+wKcH9IASntblmxesPPuMpxwNwb89M
xVNTgRrRWSzfjWptZFCbWrRsoFv8BCov9zXx3UfDbjFMT2CQ86l88QuQs1RwHOB9
/k7pwiObaEGOngMKkg+UIRo34myrsc/RtBNpSwdXX37KpMeXjQ0nIVOIPGbjyxrl
n9xbKAC+csBlahOJM6VzPQyXiCAQmA==
=gQpf
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--
