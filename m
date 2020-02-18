Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4B5162FC0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 20:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgBRTXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 14:23:24 -0500
Received: from foss.arm.com ([217.140.110.172]:59522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgBRTXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:23:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39CFD31B;
        Tue, 18 Feb 2020 11:23:23 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE5633F703;
        Tue, 18 Feb 2020 11:23:22 -0800 (PST)
Date:   Tue, 18 Feb 2020 19:23:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ASoC: tlv320adcx140: Add the tlv320adcx140 codec
 driver family
Message-ID: <20200218192321.GN4232@sirena.org.uk>
References: <20200218172140.23740-1-dmurphy@ti.com>
 <20200218172140.23740-3-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b1ERR0FXR0PvNIRE"
Content-Disposition: inline
In-Reply-To: <20200218172140.23740-3-dmurphy@ti.com>
X-Cookie: No alcohol, dogs or horses.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b1ERR0FXR0PvNIRE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2020 at 11:21:40AM -0600, Dan Murphy wrote:

A couple of very small things, otherwise this looks good:

> +	if (unlikely(!tx_mask)) {
> +		dev_err(component->dev, "tx and rx masks need to be non 0\n");
> +		return -EINVAL;
> +	}

Do you really need the unlikely() annotation here?  This is *hopefully*
not a hot path.

> +static int adcx140_codec_probe(struct snd_soc_component *component)
> +{
> +	struct adcx140_priv *adcx140 = snd_soc_component_get_drvdata(component);
> +	int sleep_cfg_val = ADCX140_WAKE_DEV;
> +	u8 bias_source;
> +	u8 vref_source;
> +	int ret;
> +
> +	adcx140->supply_areg = devm_regulator_get_optional(adcx140->dev,
> +							   "areg");
> +	if (IS_ERR(adcx140->supply_areg)) {

You should really do the request and defer at the I2C level, that avoids
running through the whole card initialization repeatedly when the device
isn't ready.  Basically try to do all resource aquisition at the device
level and then use it at the card level.

--b1ERR0FXR0PvNIRE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5MOagACgkQJNaLcl1U
h9Chkwf/aMC28AErRf96cbNZaa0JETsT1ZBpqi+o02dFL9JyXHDeMaOYtKdHNSkd
AaY5N6tioO/1AuvEed8mWfrlwnDjF2phkINUIZEZMqUHaU/YPRZrmGJvLfTMV2R4
aXyjU31pkz+VNNAwmX42BagezDOUh4XR1hpVInqNSbhUfv7mUeZCiemsYmwsNgXU
Q8fGLBTDHMDAQ3D0HsowNJKTSfcuNzIKbU1K3W4ZRsJrr7Be8zVhzZll/IqBzkdN
CMvufpVukGPruNgFdFQpiswM4oqBbKs5vEPrrrzYURxK+9G+nN4qP3rRb323o6LE
KhaVYwNfXlfsL0RViR7OgbcQpYRTtg==
=n7UO
-----END PGP SIGNATURE-----

--b1ERR0FXR0PvNIRE--
