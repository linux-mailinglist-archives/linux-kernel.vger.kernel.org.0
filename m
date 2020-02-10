Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 850A9157CD3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 14:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgBJNwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 08:52:55 -0500
Received: from foss.arm.com ([217.140.110.172]:34118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbgBJNwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 08:52:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F2091FB;
        Mon, 10 Feb 2020 05:52:54 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B77AB3F68E;
        Mon, 10 Feb 2020 05:52:53 -0800 (PST)
Date:   Mon, 10 Feb 2020 13:52:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: tlv320adcx140: Add the tlv320adcx140 codec
 driver family
Message-ID: <20200210135252.GK7685@sirena.org.uk>
References: <20200207194533.29967-1-dmurphy@ti.com>
 <20200207194533.29967-2-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/rDaUNvWv5XYRSKj"
Content-Disposition: inline
In-Reply-To: <20200207194533.29967-2-dmurphy@ti.com>
X-Cookie: Avoid gunfire in the bathroom tonight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/rDaUNvWv5XYRSKj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 07, 2020 at 01:45:33PM -0600, Dan Murphy wrote:

> +	/* interface format */
> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_I2S:
> +		iface_reg1 |= ADCX140_I2S_MODE_BIT;
> +		break;
> +	case SND_SOC_DAIFMT_LEFT_J:
> +		iface_reg1 |= ADCX140_LEFT_JUST_BIT;
> +		break;
> +	case SND_SOC_DAIFMT_DSP_A:
> +	case SND_SOC_DAIFMT_DSP_B:
> +		break;

_DSP_A and _DSP_B are two different format so I'd expect the device to
be configured differently for them, or for only one to be supported.

> +static int adcx140_mute(struct snd_soc_dai *codec_dai, int mute)
> +{
> +	struct snd_soc_component *component = codec_dai->component;
> +	int config_reg;
> +	int mic_enable;
> +	int i;
> +
> +	/* There is not a single register to mute.  Each enabled path has to be
> +	 * muted individually.  Read which path is enabled and mute it.
> +	 */
> +	snd_soc_component_read(component, ADCX140_IN_CH_EN, &mic_enable);
> +	if (!mic_enable)
> +		return 0;

You could also just offer this control to userspace, it's not
*essential* to have this operation though it can help with glitching
during stream startup.

> +
> +	for (i = 0; i < ADCX140_MAX_CHANNELS; i++) {
> +		config_reg = ADCX140_CH8_CFG2 - (5 * i);
> +		if (!(mic_enable & BIT(i)))
> +			continue;
> +
> +		if (mute)
> +			snd_soc_component_write(component, config_reg, 0);
> +	}

How does the unmute work?

> +	internal_reg = device_property_present(adcx140->dev,
> +					       "ti,use-internal-areg");
> +
> +	if (internal_reg)
> +		sleep_cfg_val |= ADCX140_AREG_INTERNAL;

Does this actually need a specific property or could you support the
regulator API and then use regulator_get_optional() to figure out if an
external AVDD is attached?

> +static int adcx140_codec_probe(struct snd_soc_component *component)
> +{
> +	struct adcx140_priv *adcx140 = snd_soc_component_get_drvdata(component);
> +
> +	return adc5410_init(adcx140);
> +}

Does the separate init function buy us anything?

--/rDaUNvWv5XYRSKj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5BYDMACgkQJNaLcl1U
h9BUOAf+NPAlIw9NPESCRsZ+YSXEwkW2K1Sq//mlXmXxrrI2wHxmlwS0kuN+OL5G
+zlKtg/VOImhuklWWD2aP8Tu5/a2W0r6x4ms08xRFROy8crTbfcXob6Pt6r1l47S
ZOEHGz5/bB+XOab5k4u1nzj3e9KuMLoUy899bL84idLny9keFmWN1vvXgTX67fKB
UlmNc9bQZljHBju6UNZWJcZzKvQm2cnLSPxhebAihahWVUbbJytidXztB/rhGWLK
Mz+L7Cjk+F7S3hbGEpbRYYkRZ7utvSFQl4YgLbBQ4p9Slhd7RWc4pt+JnT/KNKnC
lOzRASGc8ls4NEUO6rRswGKP4b18Aw==
=b/Ku
-----END PGP SIGNATURE-----

--/rDaUNvWv5XYRSKj--
