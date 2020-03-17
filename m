Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5533A188767
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 15:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgCQOYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 10:24:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:19832 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgCQOYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:24:44 -0400
IronPort-SDR: v6EKwtVNyQbGYcJUcqP45TH+zKQ+okwdxtGsKwqvBHz8k+6LD6OeC29KTCKfEuddhFdwVyERHb
 7kBo6AFzkB8g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 07:24:44 -0700
IronPort-SDR: UrTN2MTmca/v3pbjuGA0H3ilsTaZGZgz+Bdujev27zl8CWimGerZj8JyH8A7mddwBkeUnD+D2G
 rCTpBzshVP5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,564,1574150400"; 
   d="scan'208";a="244492157"
Received: from dasabhi1-mobl.amr.corp.intel.com (HELO [10.255.35.148]) ([10.255.35.148])
  by orsmga003.jf.intel.com with ESMTP; 17 Mar 2020 07:24:42 -0700
Subject: Re: [PATCH 1/2] ASoC: qcom: sdm845: handle soundwire stream
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        linux-kernel@vger.kernel.org, vkoul@kernel.org
References: <20200317095351.15582-1-srinivas.kandagatla@linaro.org>
 <20200317095351.15582-2-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <8daeeb26-851b-8311-30f5-5d285ccbc255@linux.intel.com>
Date:   Tue, 17 Mar 2020 08:07:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200317095351.15582-2-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> @@ -45,11 +48,20 @@ static int sdm845_slim_snd_hw_params(struct snd_pcm_substream *substream,
>   	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>   	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>   	struct snd_soc_dai *codec_dai;
> +	struct sdm845_snd_data *pdata = snd_soc_card_get_drvdata(rtd->card);
>   	u32 rx_ch[SLIM_MAX_RX_PORTS], tx_ch[SLIM_MAX_TX_PORTS];
> +	struct sdw_stream_runtime *sruntime;
>   	u32 rx_ch_cnt = 0, tx_ch_cnt = 0;
>   	int ret = 0, i;
>   
>   	for_each_rtd_codec_dais(rtd, i, codec_dai) {
> +		sruntime = snd_soc_dai_get_sdw_stream(codec_dai,
> +						      substream->stream);
> +		if (sruntime != ERR_PTR(-ENOTSUPP))
> +			pdata->sruntime[cpu_dai->id] = sruntime;
> +		else
> +			pdata->sruntime[cpu_dai->id] = NULL;
> +

Can you explain this part?
The get_sdw_stream() is supposed to return what was set by 
set_sdw_stream(), so if it's not supported isn't this an error?

>   		ret = snd_soc_dai_get_channel_map(codec_dai,
>   				&tx_ch_cnt, tx_ch, &rx_ch_cnt, rx_ch);
>   
> @@ -425,8 +437,65 @@ static void  sdm845_snd_shutdown(struct snd_pcm_substream *substream)
>   	}
>   }
>   
> +static int sdm845_snd_prepare(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
> +	int ret;
> +
> +	if (!sruntime)
> +		return 0;

same here, isn't this an error?

> +	if (data->stream_prepared[cpu_dai->id]) {
> +		sdw_disable_stream(sruntime);
> +		sdw_deprepare_stream(sruntime);
> +		data->stream_prepared[cpu_dai->id] = false;
> +	}
> +
> +	ret = sdw_prepare_stream(sruntime);
> +	if (ret)
> +		return ret;
> +
> +	/**
> +	 * NOTE: there is a strict hw requirement about the ordering of port
> +	 * enables and actual WSA881x PA enable. PA enable should only happen
> +	 * after soundwire ports are enabled if not DC on the line is
> +	 * accumulated resulting in Click/Pop Noise
> +	 * PA enable/mute are handled as part of codec DAPM and digital mute.
> +	 */
> +
> +	ret = sdw_enable_stream(sruntime);
> +	if (ret) {
> +		sdw_deprepare_stream(sruntime);
> +		return ret;
> +	}
> +	data->stream_prepared[cpu_dai->id] = true;
> +
> +	return ret;
> +}
> +
> +static int sdm845_snd_hw_free(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
> +
> +	if (sruntime && data->stream_prepared[cpu_dai->id]) {

and here?

Really wondering where the stream is actually allocated and set.

> +		sdw_disable_stream(sruntime);
> +		sdw_deprepare_stream(sruntime);
> +		data->stream_prepared[cpu_dai->id] = false;
> +	}
> +
> +	return 0;
> +}
> +
>   static const struct snd_soc_ops sdm845_be_ops = {
>   	.hw_params = sdm845_snd_hw_params,
> +	.hw_free = sdm845_snd_hw_free,
> +	.prepare = sdm845_snd_prepare,
>   	.startup = sdm845_snd_startup,
>   	.shutdown = sdm845_snd_shutdown,
>   };
> 
