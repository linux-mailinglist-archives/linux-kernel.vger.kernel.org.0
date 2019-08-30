Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA835A358F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 13:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfH3LS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 07:18:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53478 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfH3LS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 07:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0Ag+0BOmBywnIFIz+nrRSrUI5T5t6J5drhYhi0EPdvc=; b=YV5bsu78PtYYon0Hved5dBaQz
        4DSi+cXKEYAburcA+avOKbLa/ntN5tkrCOXUuLlp1e20SOkqgX9Mkmg39dyDyoqQOi+fnignMJM+z
        NeHOOGYff+Ynu0VKlTKcet5oFAbcITTr+L0H02kgsk7QtrPvzhoY8DajjAOUDTa58HUdc=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i3ev4-0006Dq-OB; Fri, 30 Aug 2019 11:18:18 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 539872742B61; Fri, 30 Aug 2019 12:18:17 +0100 (BST)
Date:   Fri, 30 Aug 2019 12:18:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     David Yang <yangxiaohua@everest-semi.com>,
        Daniel Drake <drake@endlessm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ASoC: es8316: Add clock control of MCLK
Message-ID: <20190830111817.GA5182@sirena.co.uk>
References: <20190829173205.11805-1-katsuhiro@katsuster.net>
 <20190829173205.11805-2-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <20190829173205.11805-2-katsuhiro@katsuster.net>
X-Cookie: Send some filthy mail.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 30, 2019 at 02:32:04AM +0900, Katsuhiro Suzuki wrote:

> +	es8316->mclk = devm_clk_get(component->dev, "mclk");
> +	if (PTR_ERR(es8316->mclk) == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;

If we don't get a clock it'd be nice to at least log that in case
there's something wrong with the clock driver so that people have more
of a hint as to why things might be breaking.

> +
> +	if (es8316->mclk) {
> +		ret = clk_prepare_enable(es8316->mclk);
> +		if (ret)
> +			return ret;
> +	}
> +

There's nothing that disables the clock on remove.

Otherwise this looks good.

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1pBfYACgkQJNaLcl1U
h9Cfdgf/QHjLqKONAE1J+gdjS0oEehwivLJxEfiY5Bz+LQ/xr+cbRBqLot2+aWM7
b0nZOgOiyKEj6nHSsFnd5ss9GJPvxePyhpwrYifIwRk9UyD6Z16cDP7V1Rz4ad0z
SFmyAE1XHhvbO5MrQvfmKpO9NfiyiuieFf3HQNDgDfPzLKBHgBXZEv4uHuAp7Id6
DeggzMHMb4buK21+AWzcMUh8i8Uygh93qvvpWp6crjUkiIx11kmGuJSp7bYSTx28
1DAHiGVBssJ/RVRk/DJUDuHamDOg+zdDzsy2Br+67WLM8o7azI/4zV3q80HdMz3P
KnY0fDkDGYNvaRG9WZfo7UR6sCQNdQ==
=QHgV
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
