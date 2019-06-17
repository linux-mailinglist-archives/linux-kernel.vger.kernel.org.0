Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54C7D4863D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 16:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfFQO5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 10:57:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33414 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfFQO5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wSZVFoXXA9VznjmlzJhQDN4bJXX4kPrS+kisWxProTE=; b=p0siBZN6TTz9U9trmfZ8+2XP5
        ZtHi1jd5JKXGAR8xDa6Ajo07mFiYaHqv99wSFqknauJlVtCuiXqL/rM0mZaWsgpkZJbOuzFRjkYS6
        i5bwsXmkwRne1bT++Ecvh0XxMIna9AgjKGXU2BJctIWm+azw1H9q3Ft4c7lmcEZFbQ8V4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hct3y-0001rr-N4; Mon, 17 Jun 2019 14:56:50 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 2C1A8440046; Mon, 17 Jun 2019 15:56:50 +0100 (BST)
Date:   Mon, 17 Jun 2019 15:56:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        dgreid@chromium.org, cychiang@chromium.org
Subject: Re: [PATCH v5] ASoC: max98090: remove 24-bit format support if RJ is
 0
Message-ID: <20190617145650.GS5316@sirena.org.uk>
References: <20190617035526.85310-1-yuhsuan@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EDQ/wMYGX5nr2pOQ"
Content-Disposition: inline
In-Reply-To: <20190617035526.85310-1-yuhsuan@chromium.org>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EDQ/wMYGX5nr2pOQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 17, 2019 at 11:55:26AM +0800, Yu-Hsuan Hsu wrote:

> +	/*
> +	 * When TDM = 0, remove 24-bit format support if it is not in right
> +	 * justified mode.
> +	 */
> +	if (!max98090->tdm_slots &&
> +		(fmt & SND_SOC_DAIFMT_FORMAT_MASK) != SND_SOC_DAIFMT_RIGHT_J) {
> +		substream->runtime->hw.formats = SNDRV_PCM_FMTBIT_S16_LE;
> +		snd_pcm_hw_constraint_msbits(substream->runtime, 0, 16, 16);
> +	}

Do you need both the addition of constraints and the one way
modification of the formats here?  Also the indentation is messed up
which makes things hard to read, the second line of the conditional is
aligned with the contents of the if block.

--EDQ/wMYGX5nr2pOQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0HqjEACgkQJNaLcl1U
h9DdJgf/bo+F60U/71HCEMfPhkQogg7oTTvWn/LCTQqrC6hilrPo9g/nkRR62SXa
weDewr+wLKzBnuF89pNEzWkLXzSjVfaNZTb33kHwufVmHasqM+6czV2N92xaPdyM
0rI39R0ruvqol6My31Xtwb/KwUfcKDD4RS7dyYnEfLsy1btrFiNXNJPYui3KjTvp
rEUskwmv8gJSyZc/BPWwkSUZJ11bm2Bge8y/0887UddrwvQDC3jNIVCIygnph8hz
INIaDDlVTiMPBJtkL8gustEiXstjZXANwnR36bTe1zWYH94tBuI76FsoXwR+n/F0
kOn+Gs+TTzzzT8YM42fIkGS4a4hQsw==
=yS7N
-----END PGP SIGNATURE-----

--EDQ/wMYGX5nr2pOQ--
