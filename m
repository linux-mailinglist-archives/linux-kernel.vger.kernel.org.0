Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86E0DCC429
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 22:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388125AbfJDU1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 16:27:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56262 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387515AbfJDU1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 16:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=j1l9R8UvUtl5K9DzHEaSXMPJHZn+w5VoGhEEAB809Lg=; b=Cjt0a11lbipjrwc8HUiJfKcDw
        u3dmVKxXk5NW0UX+1IYyj8Y5r0j3hxXi9CNQJeTDCRhRv6+za35zwkxMFwAkOX6V8QNaiFdFOATlR
        IuycBMoP38Ax1tZuFVQK4eVFPN41MfPgEQUgotmoTB5RhFlK4AVjG7232fd8f91EN2Pmw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iGUA7-0004Vs-Mo; Fri, 04 Oct 2019 20:26:51 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3BB032741EF0; Fri,  4 Oct 2019 21:26:51 +0100 (BST)
Date:   Fri, 4 Oct 2019 21:26:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     shifu0704@thundersoft.com, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org, navada@ti.com,
        perex@perex.cz, tiwai@suse.com
Subject: Re: [PATCH] ASoC: tas2770: Fix snd_soc_update_bits error handling
Message-ID: <20191004202651.GH4866@sirena.co.uk>
References: <20191004202245.22855-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JI+G0+mN8WmwPnOn"
Content-Disposition: inline
In-Reply-To: <20191004202245.22855-1-dmurphy@ti.com>
X-Cookie: core error - bus dumped
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JI+G0+mN8WmwPnOn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 04, 2019 at 03:22:45PM -0500, Dan Murphy wrote:

> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -395,6 +395,7 @@ CONFIG_SND_SOC_OMAP_ABE_TWL6040=m
>  CONFIG_SND_SOC_OMAP_HDMI=m
>  CONFIG_SND_SOC_CPCAP=m
>  CONFIG_SND_SOC_TLV320AIC23_I2C=m
> +CONFIG_SND_SOC_TAS2770=m
>  CONFIG_SND_SIMPLE_CARD=m
>  CONFIG_SND_AUDIO_GRAPH_CARD=m
>  CONFIG_HID_GENERIC=m

This is unrelated and shouldn't be here.

--JI+G0+mN8WmwPnOn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2XqwoACgkQJNaLcl1U
h9DDOwf/UTlL8bw9b4taTYD1MwGNNlg9SxfVFtrDM/5aGt1a9Kbzn6yUXUw8+gz8
B9eB+hdcxAKsLB/LAIITzTvrZN0NH5ak57GSabcplwoOVVtqp+HmFwnwQFPNMg/h
XawKlTByjNYh7Zr2vCkuxaqD4pQlvTLHFknRgiy7kUIVewD4Z+Z7fW6YPGFh28On
T+zrDHEzh8SMo1/6oyLWh9SzkgQPVXmxZ9mzMDMGzhdnXsBVj9iYNpszdOAEMiQi
nKH2Ys+sLlbLMT8/BVZL9T28Awow/ptQdF8dX9+JNRyza3Ro71obaeePaDivY0xd
asd3JxTne23nHxgakjKbXHpTSs3mMw==
=uFst
-----END PGP SIGNATURE-----

--JI+G0+mN8WmwPnOn--
