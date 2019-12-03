Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2B711002E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 15:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfLCOcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 09:32:18 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36220 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfLCOcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 09:32:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lHp+myS6pf4Jfc7A7zQQjP81X0wvMHMx0CwGmN1oWK0=; b=egqYvhOEsxCp5bOxO2pnJLKuL
        ftuVLFeE1d5MsyaRITrv3FZ+fkI3ZWV0QwMMVogTy6OGYULANmJ0rt3JYeBXul2zFPwlwwTAPxwKv
        FGu0H5HTmkIPyfOqt4xRQqFIB8MStA3U3DlyKGEhp1SKJUP+8NODfTKF7N+xlRQ7kuN90=;
Received: from fw-tnat-cam1.arm.com ([217.140.106.49] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ic9Df-0002kh-GP; Tue, 03 Dec 2019 14:32:03 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 36491D002FA; Tue,  3 Dec 2019 14:32:03 +0000 (GMT)
Date:   Tue, 3 Dec 2019 14:32:03 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     kernel@puri.sm, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sound: codecs: gtm601: add Broadmobi bm818 sound
 profile
Message-ID: <20191203143203.GK1998@sirena.org.uk>
Mail-Followup-To: "Angus Ainslie (Purism)" <angus@akkea.ca>, kernel@puri.sm,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191202174831.13638-1-angus@akkea.ca>
 <20191202174831.13638-2-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YZQs1kEQY307C4ut"
Content-Disposition: inline
In-Reply-To: <20191202174831.13638-2-angus@akkea.ca>
X-Cookie: Cleanliness is next to impossible.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YZQs1kEQY307C4ut
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 02, 2019 at 10:48:30AM -0700, Angus Ainslie (Purism) wrote:

> +	if (np && of_device_is_compatible(np, "broadmobi,bm818"))
> +		dai_driver = &bm818_dai;

Rather than having a tree of these it'd be better if...

>  #if defined(CONFIG_OF)
>  static const struct of_device_id gtm601_codec_of_match[] = {
>  	{ .compatible = "option,gtm601", },
> +	{ .compatible = "broadmobi,bm818", },
>  	{},
>  };

...this used the data you can provide along with the of_match as
the dai_driver so the probe function doesn't have to know about
the individual variants.

--YZQs1kEQY307C4ut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3mceIACgkQJNaLcl1U
h9D6eQf/T/YMXLxjUSaHDNc3AzKq7rmVZaiaaG+DgfkilPDOorbOBrcpI9of4xTG
59U9JeM9TLU3DNyTPO1aTK37vDTDq8y3wmkw5H2IRqldu46zxbSPqwzkeHdwBdNZ
XPWhtvtg1pcAfPR3hqSvKQOk5+rKWDQxXthiVH5sukuB+p4kavijAnJWamv+D7QU
LrSnZB9IQP17L2CfxVSKXouPphsnvD7sd8f/H+iElMtzDvYBB4iTFcnIBhpa9v6K
rbR2dFgEc+egWZCVY+OVeFh/NGRDTu9CgcLz+D7rkivTNXjcbmoUCQ9ijEEF/sRk
fdjT/0UJKPykUJvMEDbsmafVaq4J5g==
=XMui
-----END PGP SIGNATURE-----

--YZQs1kEQY307C4ut--
