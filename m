Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21F99CFF4B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 18:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfJHQwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 12:52:53 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59992 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbfJHQww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 12:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bxciPF2qPn6AVINPKLIOVCuywf0FCe9PPs/xWu6z0Tk=; b=LAN2pwMT0t97CtLQP2ucTpwAW
        UE2/K1a7mzPqprHmvlGXliUK2y+1MyChVWUn8Qgf9whpl4Y7SD89JyxScg+PFExLw3y62yrjY7+cZ
        URNkjYrQflcsIYtheCswHdyywCUfG5hGkx2DM+pmgY2oH04f2ZUO8dYMiNLLxK5+06Q5I=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHsit-0000Xu-O3; Tue, 08 Oct 2019 16:52:31 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id D4E342740D4A; Tue,  8 Oct 2019 17:52:30 +0100 (BST)
Date:   Tue, 8 Oct 2019 17:52:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ladislav Michl <ladis@linux-mips.org>
Cc:     YueHaibing <yuehaibing@huawei.com>, m.felsch@pengutronix.de,
        alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        piotrs@opensource.cirrus.com, andradanciu1997@gmail.com,
        lgirdwood@gmail.com, paul@crapouillou.net,
        Hulk Robot <hulkci@huawei.com>, shifu0704@thundersoft.com,
        enric.balletbo@collabora.com, srinivas.kandagatla@linaro.org,
        tiwai@suse.com, mirq-linux@rere.qmqm.pl,
        rf@opensource.wolfsonmicro.com
Subject: Re: [alsa-devel] Applied "ASoc: tas2770: Fix build error without
 GPIOLIB" to the asoc tree
Message-ID: <20191008165230.GR4382@sirena.co.uk>
References: <20191006104631.60608-1-yuehaibing@huawei.com>
 <20191007130309.EAEBE2741EF0@ypsilon.sirena.org.uk>
 <20191008163508.GA16283@lenoch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o99acAvKqrTZeiCU"
Content-Disposition: inline
In-Reply-To: <20191008163508.GA16283@lenoch>
X-Cookie: Do not disturb.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o99acAvKqrTZeiCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 08, 2019 at 06:35:08PM +0200, Ladislav Michl wrote:

> Hmm, too late it seems...
> Patch should actually remove <linux/gpio.h> as this is legacy one (see comment
> on the top and also Documentation/driver-api/gpio/consumer.rst)

Yes, leaving that is an oversight.

> And that brings a question. Given this is -next only is it actually possible
> to squash fixes into 1a476abc723e ("tas2770: add tas2770 smart PA kernel driver")
> just to make bisect a bit more happy?

No:

> > If any updates are required or you are submitting further changes they
> > should be sent as incremental updates against current git, existing
> > patches will not be replaced.

Apart from anything else I've merged up the fixes branch IIRC which
causes trouble.

--o99acAvKqrTZeiCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2cvs0ACgkQJNaLcl1U
h9AmBQf+LFk5zJqNRstdPMwgLOJGb5LX3O5w3BWeoMJNChq1Mdb1mJ+aaafn3HtA
lgfos+SLHeSz48AHvgTqZ7DvEyjx2abNyeWCc3LH0S0mIp6RQey9Vxtt5eVP3yav
5E6bRHBoX+Nv+0MqM73S31xLehzpo68qL9Iy2a5yh9TIRFjrVHZjIslo2CgNPkd4
EQDMuoYYooV3BBHGFIiCAOpS8RA5eSgIUN6Cg/M9/+BHGsLW4bako+iFjIbHgH4F
32VljVKllo5noLJsauG+ImjqHJGt11YCjp0AJL60CApDiLLFrUucBV3G/Hj5VHDt
taLaofFv9ONyk9UWxKcoCAqTYirgIw==
=rHvp
-----END PGP SIGNATURE-----

--o99acAvKqrTZeiCU--
