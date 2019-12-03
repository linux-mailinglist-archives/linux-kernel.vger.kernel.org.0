Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86782110081
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 15:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfLCOl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 09:41:27 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51638 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfLCOl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 09:41:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Fp1zIL2SAEar9dlKMYM/RfsmIkwJExCTW8u8xALWSC4=; b=SVtk5WFRlwEs+eVTFb0dxpn/a
        +g7p4XXuEkIrnH0632RPHUvw2hjP1m+sPepNvWNLcm3CfleuHd95OCxIO5RnaEgCeHgWjVhcQR29g
        14ZZZhbHLQvrHxt+snCURi55qiO4J1T/wTKzvL/UZ4nHok/xkXdTqC5Rro5rT270VGApE=;
Received: from fw-tnat-cam1.arm.com ([217.140.106.49] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ic9KY-0002mV-9f; Tue, 03 Dec 2019 14:39:10 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 03672D003B4; Tue,  3 Dec 2019 14:39:10 +0000 (GMT)
Date:   Tue, 3 Dec 2019 14:39:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, apatard@mandriva.com
Subject: Re: [PATCH] ASoC: cs42l51: add dac mux widget in codec routes
Message-ID: <20191203143909.GL1998@sirena.org.uk>
References: <20191203141627.29471-1-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kaF1vgn83Aa7CiXN"
Content-Disposition: inline
In-Reply-To: <20191203141627.29471-1-olivier.moysan@st.com>
X-Cookie: Cleanliness is next to impossible.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kaF1vgn83Aa7CiXN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 03, 2019 at 03:16:27PM +0100, Olivier Moysan wrote:

> -	SND_SOC_DAPM_DAC_E("Left DAC", "Left HiFi Playback",
> -		CS42L51_POWER_CTL1, 5, 1,
> -		cs42l51_pdn_event, SND_SOC_DAPM_PRE_POST_PMD),
> -	SND_SOC_DAPM_DAC_E("Right DAC", "Right HiFi Playback",
> -		CS42L51_POWER_CTL1, 6, 1,
> -		cs42l51_pdn_event, SND_SOC_DAPM_PRE_POST_PMD),
> +	SND_SOC_DAPM_DAC_E("Left DAC", NULL, CS42L51_POWER_CTL1, 5, 1,
> +			   cs42l51_pdn_event, SND_SOC_DAPM_PRE_POST_PMD),
> +	SND_SOC_DAPM_DAC_E("Right DAC", NULL, CS42L51_POWER_CTL1, 6, 1,
> +			   cs42l51_pdn_event, SND_SOC_DAPM_PRE_POST_PMD),

This looks like an unrelated formatting change?

--kaF1vgn83Aa7CiXN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3mc40ACgkQJNaLcl1U
h9CUawf9E5BprJC3A8QmnT0q77HnN92qqStvFvpZ7Q+v1APD/Orb+E4kskU/mHiN
B5qpYUUgoYUGyeTSG4nlSpBOG6nG2O7cpuaGz0ObLfybVJRGI7UgTIU+OtMm34DL
HzyhFvaYhg7xYbtj0m2LNLEgUWTwY2L7ktbZachaCpAjDs9IRSE/Eint/DSKl5SN
2X+nFXeDTl7Ig0vE26pukGume2hbhrnozhZIU1P4r4F965QBd4T2/490LXOWandk
xTCSMOJIkL7SBsXSlu2nwY6vYn9QBsuF/OMSfC1VqY05lxeqCcg/RJZLJj2aKizM
kPKMYjCzJLneVYT+7IsywZGFeIfH2Q==
=Bvzr
-----END PGP SIGNATURE-----

--kaF1vgn83Aa7CiXN--
