Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97F595BC6B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 15:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfGANLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 09:11:12 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35589 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfGANLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 09:11:11 -0400
Received: by mail-lf1-f66.google.com with SMTP id a25so8782281lfg.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 06:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9qPAEduDttguVrRhnFHFeM0ZPJNxzjxTsr13ZbAL/XQ=;
        b=wdYzzOfBt97yyuJLzOb8OuGg59i3B7h4TdHF3MKL6PG2BSj/1kmvCwZqoTClPN/1zx
         5XE6Cy+7PUnWbzXEMsmZkFWPi/INchUSTSCNj7WUQ1LxebRIlhCt6gytVBlX1UHtjo2n
         gHOHuAZZyzQtfTVeQO1PXnw68P9PDBUuQFo6rZRmvl4jFIwZWS8EKTD91+lGK3x377ZZ
         eX76Xfbe+RSzOn4wjkqBPHGwtQfGdO1FuHs6LH6+XhPF1lO02wbH5cSuGeEEdufn457T
         ZPYH3UOboZTayCGyXmIzGmOHpYpGJkzTwwOsjQ6s6AeVxOs/Y6b0cQI0dWr/wApNw9OT
         3jBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9qPAEduDttguVrRhnFHFeM0ZPJNxzjxTsr13ZbAL/XQ=;
        b=jrKGSMDB28ThjB3DM27jzvQNCbGRAFvRT3OSgf5WlcNUGYuhgJLqnrseYdgTtiHV4z
         7RjgtWIOgvwHiGSDE2XrDIighJGF/0FSM7QfWIc2eeURkF30+KYmc8O00K7MEsnu8UBz
         lr9UmQtEG8Lr/V1tKVcFzExqlXY1dnbs/fbjQjvpEp9JWtwaJOVdtiqJdrAesre1tMCJ
         RybBnEn3CFk3WqOGUOTgbQMXW4DVToIf6fmnJxKMSOnYPYSW5EpHQArt/3B0RPLSuzHE
         CyJdFjrVsGMccKY1pfK57WD8IKsCNbGxZRNJ1NILVAnzuhTASzDMqN4PtT7a8+ECzBHU
         JmTQ==
X-Gm-Message-State: APjAAAXLDlNN5vXi0Iot8mJX8kI3njR7CztlZTl2eHzS72GXWJuQQNOm
        UI+4C8lJB2Dy8S1yw8b06+sP7g==
X-Google-Smtp-Source: APXvYqyx33ZIsI958Tuf3hLJwehoeTSJ5Dm7gL2VbsmwJbhrCbwavwKV21ymlpZnqNFyAbajX7ue1A==
X-Received: by 2002:ac2:52ac:: with SMTP id r12mr12759243lfm.126.1561986668853;
        Mon, 01 Jul 2019 06:11:08 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id o74sm2456561lff.46.2019.07.01.06.11.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 06:11:08 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] media: venus: Update clock scaling
To:     Aniket Masule <amasule@codeaurora.org>, linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org
References: <1561480044-11834-1-git-send-email-amasule@codeaurora.org>
 <1561480044-11834-3-git-send-email-amasule@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <69610fc3-5333-ccc6-316f-aee96dc11150@linaro.org>
Date:   Mon, 1 Jul 2019 16:11:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <1561480044-11834-3-git-send-email-amasule@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/25/19 7:27 PM, Aniket Masule wrote:
> Current clock scaling calculations are same for vpu4 and
> previous versions. For vpu4, Clock scaling calculations
> are updated with cycles/mb. This helps in getting precise
> clock required.
> 
> Signed-off-by: Aniket Masule <amasule@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/helpers.c | 111 ++++++++++++++++++++++++----
>  drivers/media/platform/qcom/venus/helpers.h |   2 +-
>  drivers/media/platform/qcom/venus/vdec.c    |   2 +-
>  drivers/media/platform/qcom/venus/venc.c    |   2 +-
>  4 files changed, 99 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index f7f724b..e1a0247 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -348,8 +348,9 @@ static u32 load_per_type(struct venus_core *core, u32 session_type)
>  	return mbs_per_sec;
>  }
>  
> -static int load_scale_clocks(struct venus_core *core)
> +static int scale_clocks(struct venus_inst *inst)
>  {
> +	struct venus_core *core = inst->core;
>  	const struct freq_tbl *table = core->res->freq_tbl;
>  	unsigned int num_rows = core->res->freq_tbl_size;
>  	unsigned long freq = table[0].freq;
> @@ -398,6 +399,86 @@ static int load_scale_clocks(struct venus_core *core)
>  	return ret;
>  }
>  
> +static unsigned long calculate_vpp_freq(struct venus_inst *inst)
> +{
> +	unsigned long vpp_freq = 0;
> +	u32 mbs_per_sec;
> +
> +	mbs_per_sec = load_per_instance(inst);
> +	vpp_freq = mbs_per_sec * inst->clk_data.codec_freq_data->vpp_freq;
> +	/* 21 / 20 is overhead factor */
> +	vpp_freq += vpp_freq / 20;
> +
> +	return vpp_freq;
> +}
> +
> +static int scale_clocks_v4(struct venus_inst *inst)
> +{
> +	struct venus_core *core = inst->core;
> +	const struct freq_tbl *table = core->res->freq_tbl;
> +	unsigned int num_rows = core->res->freq_tbl_size;
> +

please remove this blank line.

> +	struct clk *clk = core->clks[0];
> +	struct device *dev = core->dev;
> +	unsigned int i;
> +	unsigned long freq = 0, freq_core0 = 0, freq_core1 = 0;

could you count the cores as it is done for VIDC_CORE_ID_ ?
i.e. start counting from one.

> +	int ret;
> +
> +	freq = calculate_vpp_freq(inst);
> +
> +	if (freq > table[0].freq)
> +		goto err;

if the goto is triggered the error message will be wrong. Infact the
dev_err message is targeted for clk_set_rate failure.

> +
> +	for (i = 0; i < num_rows; i++) {
> +		if (freq > table[i].freq)
> +			break;
> +		freq = table[i].freq;
> +	}
> +
> +	inst->clk_data.freq = freq;
> +
> +	mutex_lock(&core->lock);
> +	list_for_each_entry(inst, &core->instances, list) {
> +		if (inst->clk_data.core_id == VIDC_CORE_ID_1) {
> +			freq_core0 += inst->clk_data.freq;
> +		} else if (inst->clk_data.core_id == VIDC_CORE_ID_2) {
> +			freq_core1 += inst->clk_data.freq;
> +		} else if (inst->clk_data.core_id == VIDC_CORE_ID_3) {
> +			freq_core0 += inst->clk_data.freq;
> +			freq_core1 += inst->clk_data.freq;
> +		}
> +	}
> +	mutex_unlock(&core->lock);
> +
> +	freq = max(freq_core0, freq_core1);
> +
> +	ret = clk_set_rate(clk, freq);
> +	if (ret)
> +		goto err;
> +
> +	ret = clk_set_rate(core->core0_clk, freq);
> +	if (ret)
> +		goto err;
> +
> +	ret = clk_set_rate(core->core1_clk, freq);
> +	if (ret)
> +		goto err;
> +
> +	return 0;
> +
> +err:
> +	dev_err(dev, "failed to set clock rate %lu (%d)\n", freq, ret);
> +	return ret;
> +}
> +
> +static int load_scale_clocks(struct venus_inst *inst)
> +{
> +	if (IS_V4(inst->core))
> +		return scale_clocks_v4(inst);
> +
> +	return scale_clocks(inst);
> +}
> +
>  static void fill_buffer_desc(const struct venus_buffer *buf,
>  			     struct hfi_buffer_desc *bd, bool response)
>  {
> @@ -715,35 +796,36 @@ int venus_helper_set_core_usage(struct venus_inst *inst, u32 usage)
>  }
>  EXPORT_SYMBOL_GPL(venus_helper_set_core_usage);
>  
> -int venus_helper_init_codec_data(struct venus_inst *inst)
> +int venus_helper_init_codec_freq_data(struct venus_inst *inst)
>  {
> -	const struct codec_data *codec_data;
> -	unsigned int i, codec_data_size;

those deletions shouldn't exist once you fix the git rebase issue.

> +	const struct codec_freq_data *codec_freq_data;
> +	unsigned int i, codec_freq_data_size;

could you rename the variables to shorter?

>  	u32 pixfmt;
>  	int ret = 0;
>  
>  	if (!IS_V4(inst->core))
>  		return 0;
>  
> -	codec_data = inst->core->res->codec_data;
> -	codec_data_size = inst->core->res->codec_data_size;
> +	codec_freq_data = inst->core->res->codec_freq_data;
> +	codec_freq_data_size = inst->core->res->codec_freq_data_size;
>  	pixfmt = inst->session_type == VIDC_SESSION_TYPE_DEC ?
>  			inst->fmt_out->pixfmt : inst->fmt_cap->pixfmt;
>  
> -	for (i = 0; i < codec_data_size; i++) {
> -		if (codec_data[i].pixfmt == pixfmt &&
> -		    codec_data[i].session_type == inst->session_type) {
> -			inst->clk_data.codec_data = &codec_data[i];
> +	for (i = 0; i < codec_freq_data_size; i++) {
> +		if (codec_freq_data[i].pixfmt == pixfmt &&
> +		    codec_freq_data[i].session_type == inst->session_type) {
> +			inst->clk_data.codec_freq_data =
> +				&codec_freq_data[i];
>  			break;
>  		}
>  	}
>  
> -	if (!inst->clk_data.codec_data)
> +	if (!inst->clk_data.codec_freq_data)
>  		ret = -EINVAL;
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(venus_helper_init_codec_data);
> +EXPORT_SYMBOL_GPL(venus_helper_init_codec_freq_data);
>  

-- 
regards,
Stan
