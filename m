Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA13168126
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 16:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgBUPHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 10:07:39 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53521 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbgBUPHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:07:39 -0500
Received: by mail-wm1-f66.google.com with SMTP id s10so2138545wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 07:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=e0L4/lKklK0pPHv+p72Qf9pkHd2IRBOpN8nR2j+6GjM=;
        b=nKxVgXbuLxoFN5LZ1SEgJEJ6Q+p9oRBvp6Mu7yEf7xwANCpQC6zNg72BHYf0NA82S7
         iBjBZ8gpnUD0HqJRWDiyVUPZU21XfXavtUUFOJ2sF4aeABbxhFGisVHwvtnE13iP7ql/
         aiSblwtCEnHfPFaqwonU2maDbKsViGQ/fXAcwxb2Jf6XrBFIsRShH5v15u2sdmbB9P2N
         qGsI7c/fdyT+DkNgYRMegxb3nd+kxF/GpPhdmGv4SK+bUd7MgOB6WxwgxaDb137PrXsQ
         CEYzz70M6nU3SIgNU3ng4xQKpB/A27n3/rfqCOnzXRFUU5LAbAfMjRKDbbwwcSOz2Ynx
         zy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=e0L4/lKklK0pPHv+p72Qf9pkHd2IRBOpN8nR2j+6GjM=;
        b=UFoxwTgVeqqstHVvlPNqyvh1eRCNKFVyQxO5vtg4jSFoJpgly1hl8p/7FKSdqU8paz
         OL7V4GaDFfskaM55FHh/UXAnX9tEjkaIVw+H0BdeRVrOxv8aTDV8unuu1t2BvsJxMT7G
         uNtancwvG4TtTk5NAl6bgiu0R6y9Di1BAs44NcMnTJWegwQhwSLpiCSJczoHjsTK5Far
         5H9F4qK96a5YuglIAx0KV9fHvSAIdxf85gMmtKG32KwN+1mjkTuciIKYIbyVaoEaPzPt
         hlc3JpPi/jp3afBtreBBSjp4htdBrdEnG7AxFfurnnjIZF4bUVpCjGF0WsTTYCqPGvA2
         1/sA==
X-Gm-Message-State: APjAAAXawyaIHX/VZSMKvQEJTJkLQd9Z0zuiskb/UCDze7E1whx5OA8h
        LlQLy3eb59eNQgZdMEN7TF5kQw==
X-Google-Smtp-Source: APXvYqyuqN+IUjfBMyk8cWX21uCBxSpBZ1yH0FZnXDsBtGAM+msBu1kqHkIEg+2hGsqiibQjHskgcQ==
X-Received: by 2002:a1c:a952:: with SMTP id s79mr4582992wme.83.1582297656460;
        Fri, 21 Feb 2020 07:07:36 -0800 (PST)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id w22sm4143316wmk.34.2020.02.21.07.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 07:07:34 -0800 (PST)
References: <20200221122242.1500093-1-jbrunet@baylibre.com> <20200221122242.1500093-3-jbrunet@baylibre.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 2/3] ASoC: meson: g12a: add internal DAC glue driver
In-reply-to: <20200221122242.1500093-3-jbrunet@baylibre.com>
Date:   Fri, 21 Feb 2020 16:07:33 +0100
Message-ID: <1jo8ts2d3e.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 21 Feb 2020 at 13:22, Jerome Brunet <jbrunet@baylibre.com> wrote:

> Add support for the internal audio DAC glue found on the Amlogic g12a
> and sm1 SoC families. This allows to connect the TDM outputs of the SoC
> to the internal t9015 audio DAC.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Please ignore this patch. It is incomplete, a part was mistakenly
squashed with another change I'm preparing

> ---
>  sound/soc/meson/Kconfig         |   9 ++
>  sound/soc/meson/Makefile        |   2 +
>  sound/soc/meson/g12a-toacodec.c | 240 ++++++++++++++++++++++++++++++++
>  3 files changed, 251 insertions(+)
>  create mode 100644 sound/soc/meson/g12a-toacodec.c
>
> diff --git a/sound/soc/meson/Kconfig b/sound/soc/meson/Kconfig
> index d27e9180b453..8b6295283989 100644
> --- a/sound/soc/meson/Kconfig
> +++ b/sound/soc/meson/Kconfig
> @@ -109,6 +109,15 @@ config SND_MESON_GX_SOUND_CARD
>  	help
>  	  Select Y or M to add support for the GXBB/GXL SoC sound card
>  
> +config SND_MESON_G12A_TOACODEC
> +	tristate "Amlogic G12A To Internal DAC Control Support"
> +	select SND_MESON_CODEC_GLUE
> +	select REGMAP_MMIO
> +	imply SND_SOC_MESON_T9015
> +	help
> +	  Select Y or M to add support for the internal audio DAC on the
> +	  g12a SoC family
> +
>  config SND_MESON_G12A_TOHDMITX
>  	tristate "Amlogic G12A To HDMI TX Control Support"
>  	select REGMAP_MMIO
> diff --git a/sound/soc/meson/Makefile b/sound/soc/meson/Makefile
> index 3c9d48846816..e446bc980481 100644
> --- a/sound/soc/meson/Makefile
> +++ b/sound/soc/meson/Makefile
> @@ -22,6 +22,7 @@ snd-soc-meson-axg-pdm-objs := axg-pdm.o
>  snd-soc-meson-card-utils-objs := meson-card-utils.o
>  snd-soc-meson-codec-glue-objs := meson-codec-glue.o
>  snd-soc-meson-gx-sound-card-objs := gx-card.o
> +snd-soc-meson-g12a-toacodec-objs := g12a-toacodec.o
>  snd-soc-meson-g12a-tohdmitx-objs := g12a-tohdmitx.o
>  snd-soc-meson-t9015-objs := t9015.o
>  
> @@ -40,5 +41,6 @@ obj-$(CONFIG_SND_MESON_AXG_PDM) += snd-soc-meson-axg-pdm.o
>  obj-$(CONFIG_SND_MESON_CARD_UTILS) += snd-soc-meson-card-utils.o
>  obj-$(CONFIG_SND_MESON_CODEC_GLUE) += snd-soc-meson-codec-glue.o
>  obj-$(CONFIG_SND_MESON_GX_SOUND_CARD) += snd-soc-meson-gx-sound-card.o
> +obj-$(CONFIG_SND_MESON_G12A_TOACODEC) += snd-soc-meson-g12a-toacodec.o
>  obj-$(CONFIG_SND_MESON_G12A_TOHDMITX) += snd-soc-meson-g12a-tohdmitx.o
>  obj-$(CONFIG_SND_SOC_MESON_T9015) += snd-soc-meson-t9015.o
> diff --git a/sound/soc/meson/g12a-toacodec.c b/sound/soc/meson/g12a-toacodec.c
> new file mode 100644
> index 000000000000..719bbe9966b1
> --- /dev/null
> +++ b/sound/soc/meson/g12a-toacodec.c
> @@ -0,0 +1,240 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (c) 2020 BayLibre, SAS.
> +// Author: Jerome Brunet <jbrunet@baylibre.com>
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <sound/pcm_params.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dai.h>
> +
> +#include <dt-bindings/sound/meson-g12a-toacodec.h>
> +#include "axg-tdm.h"
> +#include "meson-codec-glue.h"
> +
> +#define G12A_TOACODEC_DRV_NAME "g12a-toacodec"
> +
> +#define TOACODEC_CTRL0			0x0
> +#define  CTRL0_ENABLE_SHIFT		31
> +#define  CTRL0_DAT_SEL			GENMASK(15, 14)
> +#define  CTRL0_LANE_SEL			12
> +#define  CTRL0_LRCLK_SEL		GENMASK(9, 8)
> +#define  CTRL0_BLK_CAP_INV		BIT(7)
> +#define  CTRL0_BCLK_O_INV		BIT(6)
> +#define  CTRL0_BCLK_SEL			GENMASK(5, 4)
> +#define  CTRL0_MCLK_SEL			GENMASK(2, 0)
> +
> +#define TOACODEC_OUT_CHMAX		2
> +
> +static const char * const g12a_toacodec_mux_texts[] = {
> +	"I2S A", "I2S B", "I2S C",
> +};
> +
> +static int g12a_toacodec_get_mux(struct snd_soc_component *component)
> +{
> +	unsigned int val;
> +
> +	snd_soc_component_read(component, TOACODEC_CTRL0, &val);
> +	return FIELD_GET(CTRL0_DAT_SEL, val);
> +}
> +
> +static int g12a_toacodec_put_mux(struct snd_soc_component *component,
> +				 unsigned int mux)
> +{
> +	snd_soc_component_update_bits(component, TOACODEC_CTRL0,
> +				      CTRL0_DAT_SEL |
> +				      CTRL0_LRCLK_SEL |
> +				      CTRL0_BCLK_SEL,
> +				      FIELD_PREP(CTRL0_DAT_SEL, mux) |
> +				      FIELD_PREP(CTRL0_LRCLK_SEL, mux) |
> +				      FIELD_PREP(CTRL0_BCLK_SEL, mux));
> +
> +	/*
> +	 * FIXME:
> +	 * On this soc, the glue gets the MCLK directly from the clock
> +	 * controller instead of going the through the TDM interface.
> +	 *
> +	 * Here we assume interface A uses clock A, etc ... While it is
> +	 * true for now, it could be different. Instead the glue should
> +	 * find out the clock used by the interface and select the same
> +	 * source. For that, we will need regmap backed clock mux which
> +	 * is a work in progress
> +	 */
> +	snd_soc_component_update_bits(component, TOACODEC_CTRL0,
> +				      CTRL0_MCLK_SEL,
> +				      FIELD_PREP(CTRL0_MCLK_SEL, mux));
> +
> +	return 0;
> +}
> +
> +static MESON_CODEC_GLUE_ENUM_DECL(g12a_toacodec_mux_glue,
> +				  g12a_toacodec_mux_texts,
> +				  g12a_toacodec_get_mux,
> +				  g12a_toacodec_put_mux);
> +
> +static const struct snd_kcontrol_new g12a_toacodec_mux =
> +	SOC_DAPM_ENUM_EXT("Source", g12a_toacodec_mux_enum,
> +			  snd_soc_dapm_get_enum_double,
> +			  g12a_toacodec_mux_put_enum);
> +
> +static const struct snd_kcontrol_new g12a_toacodec_out_enable =
> +	SOC_DAPM_SINGLE_AUTODISABLE("Switch", TOACODEC_CTRL0,
> +				    CTRL0_ENABLE_SHIFT, 1, 0);
> +
> +static const struct snd_soc_dapm_widget g12a_toacodec_widgets[] = {
> +	SND_SOC_DAPM_MUX("SRC", SND_SOC_NOPM, 0, 0,
> +			 &g12a_toacodec_mux),
> +	SND_SOC_DAPM_SWITCH("OUT EN", SND_SOC_NOPM, 0, 0,
> +			    &g12a_toacodec_out_enable),
> +};
> +
> +static int g12a_toacodec_input_hw_params(struct snd_pcm_substream *substream,
> +					 struct snd_pcm_hw_params *params,
> +					 struct snd_soc_dai *dai)
> +{
> +	struct meson_codec_glue_input *data;
> +	int ret;
> +
> +	ret = meson_codec_glue_input_hw_params(substream, params, dai);
> +	if (ret)
> +		return ret;
> +
> +	/* The glue will provide 1 lane out of the 4 to the output */
> +	data = meson_codec_glue_input_get_data(dai);
> +	data->params.channels_min = min_t(unsigned int, TOACODEC_OUT_CHMAX,
> +					data->params.channels_min);
> +	data->params.channels_max = min_t(unsigned int, TOACODEC_OUT_CHMAX,
> +					data->params.channels_max);
> +
> +	return 0;
> +}
> +
> +static const struct snd_soc_dai_ops g12a_toacodec_input_ops = {
> +	.hw_params	= g12a_toacodec_input_hw_params,
> +	.set_fmt	= meson_codec_glue_input_set_fmt,
> +};
> +
> +static const struct snd_soc_dai_ops g12a_toacodec_output_ops = {
> +	.startup	= meson_codec_glue_output_startup,
> +};
> +
> +#define TOACODEC_STREAM(xname, xsuffix, xchmax)			\
> +{								\
> +	.stream_name	= xname " " xsuffix,			\
> +	.channels_min	= 1,					\
> +	.channels_max	= (xchmax),				\
> +	.rate_min       = 5512,					\
> +	.rate_max	= 192000,				\
> +	.formats	= AXG_TDM_FORMATS,			\
> +}
> +
> +#define TOACODEC_INPUT(xname, xid) {					\
> +	.name = xname,							\
> +	.id = (xid),							\
> +	.playback = TOACODEC_STREAM(xname, "Playback", 8),		\
> +	.ops = &g12a_toacodec_input_ops,				\
> +	.probe = meson_codec_glue_input_dai_probe,			\
> +	.remove = meson_codec_glue_input_dai_remove,			\
> +}
> +
> +#define TOACODEC_OUTPUT(xname, xid) {					\
> +	.name = xname,							\
> +	.id = (xid),							\
> +	.capture = TOACODEC_STREAM(xname, "Capture", TOACODEC_OUT_CHMAX), \
> +	.ops = &g12a_toacodec_output_ops,				\
> +}
> +
> +static struct snd_soc_dai_driver g12a_toacodec_dai_drv[] = {
> +	TOACODEC_INPUT("IN A", TOACODEC_IN_A),
> +	TOACODEC_INPUT("IN B", TOACODEC_IN_B),
> +	TOACODEC_INPUT("IN C", TOACODEC_IN_C),
> +	TOACODEC_OUTPUT("OUT", TOACODEC_OUT),
> +};
> +
> +static int g12a_toacodec_component_probe(struct snd_soc_component *c)
> +{
> +	/* Initialize the static clock parameters */
> +	return snd_soc_component_write(c, TOACODEC_CTRL0,
> +				       CTRL0_BLK_CAP_INV);
> +}
> +
> +static const struct snd_soc_dapm_route g12a_toacodec_routes[] = {
> +	{ "SRC", "I2S A", "IN A Playback" },
> +	{ "SRC", "I2S B", "IN B Playback" },
> +	{ "SRC", "I2S C", "IN C Playback" },
> +	{ "OUT EN", "Switch", "SRC" },
> +	{ "OUT Capture", NULL, "OUT EN" },
> +};
> +
> +static const struct snd_kcontrol_new g12a_toacodec_controls[] = {
> +	SOC_SINGLE("Lane Select", TOACODEC_CTRL0, CTRL0_LANE_SEL, 3, 0),
> +};
> +
> +static const struct snd_soc_component_driver g12a_toacodec_component_drv = {
> +	.probe			= g12a_toacodec_component_probe,
> +	.controls		= g12a_toacodec_controls,
> +	.num_controls		= ARRAY_SIZE(g12a_toacodec_controls),
> +	.dapm_widgets		= g12a_toacodec_widgets,
> +	.num_dapm_widgets	= ARRAY_SIZE(g12a_toacodec_widgets),
> +	.dapm_routes		= g12a_toacodec_routes,
> +	.num_dapm_routes	= ARRAY_SIZE(g12a_toacodec_routes),
> +	.endianness		= 1,
> +	.non_legacy_dai_naming	= 1,
> +};
> +
> +static const struct regmap_config g12a_toacodec_regmap_cfg = {
> +	.reg_bits	= 32,
> +	.val_bits	= 32,
> +	.reg_stride	= 4,
> +};
> +
> +static const struct of_device_id g12a_toacodec_of_match[] = {
> +	{ .compatible = "amlogic,g12a-toacodec", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, g12a_toacodec_of_match);
> +
> +static int g12a_toacodec_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	void __iomem *regs;
> +	struct regmap *map;
> +	int ret;
> +
> +	ret = device_reset(dev);
> +	if (ret)
> +		return ret;
> +
> +	regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +
> +	map = devm_regmap_init_mmio(dev, regs, &g12a_toacodec_regmap_cfg);
> +	if (IS_ERR(map)) {
> +		dev_err(dev, "failed to init regmap: %ld\n",
> +			PTR_ERR(map));
> +		return PTR_ERR(map);
> +	}
> +
> +	return devm_snd_soc_register_component(dev,
> +			&g12a_toacodec_component_drv, g12a_toacodec_dai_drv,
> +			ARRAY_SIZE(g12a_toacodec_dai_drv));
> +}
> +
> +static struct platform_driver g12a_toacodec_pdrv = {
> +	.driver = {
> +		.name = G12A_TOACODEC_DRV_NAME,
> +		.of_match_table = g12a_toacodec_of_match,
> +	},
> +	.probe = g12a_toacodec_probe,
> +};
> +module_platform_driver(g12a_toacodec_pdrv);
> +
> +MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
> +MODULE_DESCRIPTION("Amlogic G12a To Internal DAC Codec Driver");
> +MODULE_LICENSE("GPL v2");

