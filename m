Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64ABCD1423
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 18:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731778AbfJIQfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 12:35:46 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50796 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730546AbfJIQfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 12:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=owdfGfpxxrkSa3bEZCcNRIXecf20ZOjPIlOoM7dfj2Q=; b=xxg1yPso5ztQ/T7iDk98vnYtJ
        yNHDZeAYSyQgIshsARNOL1FqCQHj1VaXP/dJo3gUYOY4qNXNjz8JpcxJEkFrKPBIfNIu4MnUjB0X/
        mrL0zJGtyr4YRB57vqtiNy9kEoc+5kEgCnwLvlhTUdhlab7uBtEBflGAKjCp4spvsCDHE=;
Received: from 188.31.199.195.threembb.co.uk ([188.31.199.195] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iIEw5-0005Em-A6; Wed, 09 Oct 2019 16:35:37 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 19E0BD03ED3; Wed,  9 Oct 2019 17:35:35 +0100 (BST)
Date:   Wed, 9 Oct 2019 17:35:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     spapothi@codeaurora.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, vkoul@kernel.org,
        pierre-louis.bossart@linux.intel.com
Subject: Re: [PATCH v7 2/2] ASoC: codecs: add wsa881x amplifier support
Message-ID: <20191009163535.GK2036@sirena.org.uk>
References: <20191009085108.4950-1-srinivas.kandagatla@linaro.org>
 <20191009085108.4950-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4+GP5VtpSFAXb8tV"
Content-Disposition: inline
In-Reply-To: <20191009085108.4950-3-srinivas.kandagatla@linaro.org>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4+GP5VtpSFAXb8tV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 09, 2019 at 09:51:08AM +0100, Srinivas Kandagatla wrote:

> +static const u8 wsa881x_reg_readable[WSA881X_CACHE_SIZE] = {

> +static bool wsa881x_readable_register(struct device *dev, unsigned int reg)
> +{
> +	return wsa881x_reg_readable[reg];
u
There's no bounds check and that array size is not...

> +static struct regmap_config wsa881x_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 8,
> +	.cache_type = REGCACHE_RBTREE,
> +	.reg_defaults = wsa881x_defaults,
> +	.num_reg_defaults = ARRAY_SIZE(wsa881x_defaults),
> +	.max_register = WSA881X_MAX_REGISTER,

...what regmap has as max_register.  Uusually you'd render as a
switch statement (as you did for volatile) and let the compiler
figure out a sensible way to do the lookup.

> +static void wsa881x_init(struct wsa881x_priv *wsa881x)
> +{
> +	struct regmap *rm = wsa881x->regmap;
> +	unsigned int val = 0;
> +
> +	regmap_read(rm, WSA881X_CHIP_ID1, &wsa881x->version);
> +	regcache_cache_only(rm, true);
> +	regmap_multi_reg_write(rm, wsa881x_rev_2_0,
> +			       ARRAY_SIZE(wsa881x_rev_2_0));
> +	regcache_cache_only(rm, false);

This looks broken, what is it supposed to be doing?  It looks
like it should be a register patch but it's not documented.

> +static const struct snd_kcontrol_new wsa881x_snd_controls[] = {
> +	SOC_ENUM("Smart Boost Level", smart_boost_lvl_enum),
> +	WSA881X_PA_GAIN_TLV("PA Gain", WSA881X_SPKR_DRV_GAIN,
> +			    4, 0xC, 1, pa_gain),

As covered in control-names.rst all volume controls should end in
Volume.

> +static void wsa881x_clk_ctrl(struct snd_soc_component *comp, bool enable)
> +{
> +	struct wsa881x_priv *wsa881x = snd_soc_component_get_drvdata(comp);
> +
> +	mutex_lock(&wsa881x->res_lock);

What is this lock supposed to be protecting?  As far as I can
tell this function is the only place it is used and this function
has exactly one caller which itself has only one caller which is
a DAPM widget and hence needs no locking.  It looks awfully like
it should just be a widget itself, or inlined into the single
caller.

> +static void wsa881x_bandgap_ctrl(struct snd_soc_component *comp, bool enable)
> +{
> +	struct wsa881x_priv *wsa881x = snd_soc_component_get_drvdata(comp);

Similarly here.

> +static int32_t wsa881x_resource_acquire(struct snd_soc_component *comp,
> +					bool enable)
> +{
> +	wsa881x_clk_ctrl(comp, enable);
> +	wsa881x_bandgap_ctrl(comp, enable);
> +
> +	return 0;
> +}

There's no corresponding disables.

--4+GP5VtpSFAXb8tV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2eDFYACgkQJNaLcl1U
h9CtLgf8CePH7+ZsY0W4cRF5zvZs+qrkT8EShEl1pRNhR80s4tivFZnFYccKkM1a
NSlUywoTsagGw1dijsM7tCzj82aQ5pxABSezmv0erVwZv9cFqnbfNG/yh3epnLbH
/T/MBashmZA7sR02wH7y3PFvxlWkH3buk6jlwKeCJtZNnX6pGpv5mfwy5p9nkygB
iIgIG6WEd8pB0/pGk4MVArDRhLIGkH2C+cyxEC46zIG6FVrfi1DlNffgYjmbne6N
UO6g0GtmdlI6HyuLCQ4DO56BrExtnjieHzCJgyyFN6vn86S6OFLwFGfj8P8lduk7
GAvcrZSHg8UKdrOLheSE57TbN6KqGQ==
=ijUj
-----END PGP SIGNATURE-----

--4+GP5VtpSFAXb8tV--
