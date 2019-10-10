Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF01D264D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 11:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387953AbfJJJ2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 05:28:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33121 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfJJJ2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 05:28:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id r17so6679753wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 02:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D/ELkajn5nIeWjt+au+JukJPjjOmYN8ul5L5G8g9Cbw=;
        b=vBgud5FUoF0BluzVgOr5mc+3sO+QeVDiiFna1seL30oxei6d/G1Gcn6OURjpSV5FJp
         tyIDD8hgqfT6TqZ0m8A+Y570QFqu7S18n75up5d6x6MwFgpV2at9SaLbbeQMiQbgHkK1
         HFkubXUAXl0UuYvhGw8Hu6IcWiMWHPa3r20trLP/WXhWAHUJQg3ZNz8NkhNi/DKeFb97
         FTEXsltHQ9xnTUKo9aJL817yRA6Kjg8QH9Af0vGts/ubMQ8yskDLIBA44ZPI4WOVeS+G
         FTra92WmfZuYkQdI53afAlAcjNMt5rfa5bQr5fIQIGChlBjL3p7uv9RQPwGWYYdlPOsj
         tXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D/ELkajn5nIeWjt+au+JukJPjjOmYN8ul5L5G8g9Cbw=;
        b=C4j7JyYCDxd+y76zEJSlP8mANPVZN2cr6MSe+2DcizMXOGnol0yk2F7R857FWSPmDm
         0qTRD2Bt4hXM7ZAl6YX/e/2i2L0H1egKslkZXQxKiFX/FvC/slXBFxfrLCZYvby/ID59
         JrWMr93w0D99T1MCVJX43AhgqlQcH+4K1NHG20MdhI4zYA6F6Yl8/HcQk8jYeLLVU/cl
         KF2LTpydVGwsvCPYLL2UFD1yPJVvuXJz/4Z6p1W4bRIhDkvLJDxNLt+prOV/QQAAplDs
         gxemH6g/dx+7PI05KtwEbR8s/ycTVJB6616hzKGPbaqQNDAFcwHJNJaB/Bvzqka4sCkC
         5VOg==
X-Gm-Message-State: APjAAAVlg3ryoKGj8DF1NcplmLyC4YxrjXtGQ8xMrbVA8/HFnhxdkLcS
        LagT2yYN8RT6kYSjTJoFZSbtcw==
X-Google-Smtp-Source: APXvYqzh6cSKpRv0QPcGFghP+vIiOOMTWhRv7tSw50MdW0LwB1cnhPJCjyLv5lQ6J6Vs3RTkKyuYyg==
X-Received: by 2002:a7b:caea:: with SMTP id t10mr6538733wml.118.1570699691297;
        Thu, 10 Oct 2019 02:28:11 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id l11sm6282042wmh.34.2019.10.10.02.28.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 02:28:10 -0700 (PDT)
Subject: Re: [PATCH v7 2/2] ASoC: codecs: add wsa881x amplifier support
To:     Mark Brown <broonie@kernel.org>
Cc:     spapothi@codeaurora.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, vkoul@kernel.org,
        pierre-louis.bossart@linux.intel.com
References: <20191009085108.4950-1-srinivas.kandagatla@linaro.org>
 <20191009085108.4950-3-srinivas.kandagatla@linaro.org>
 <20191009163535.GK2036@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <95637c0a-8373-0eda-47e5-ac6e529019e5@linaro.org>
Date:   Thu, 10 Oct 2019 10:28:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191009163535.GK2036@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Mark for taking time to review this patch.

On 09/10/2019 17:35, Mark Brown wrote:
> On Wed, Oct 09, 2019 at 09:51:08AM +0100, Srinivas Kandagatla wrote:
> 
>> +static const u8 wsa881x_reg_readable[WSA881X_CACHE_SIZE] = {
> 
>> +static bool wsa881x_readable_register(struct device *dev, unsigned int reg)
>> +{
>> +	return wsa881x_reg_readable[reg];
> u
> There's no bounds check and that array size is not...
> 
I converted this now to a proper switch statement as other drivers do.

>> +static struct regmap_config wsa881x_regmap_config = {
>> +	.reg_bits = 32,
>> +	.val_bits = 8,
>> +	.cache_type = REGCACHE_RBTREE,
>> +	.reg_defaults = wsa881x_defaults,
>> +	.num_reg_defaults = ARRAY_SIZE(wsa881x_defaults),
>> +	.max_register = WSA881X_MAX_REGISTER,
> 
> ...what regmap has as max_register.  Uusually you'd render as a
> switch statement (as you did for volatile) and let the compiler
> figure out a sensible way to do the lookup.

Sorry, I did not get your point here.

Are you saying that we can skip max_register in this regmap config ?
Then how would max_register in regmap be set?

> 
>> +static void wsa881x_init(struct wsa881x_priv *wsa881x)
>> +{
>> +	struct regmap *rm = wsa881x->regmap;
>> +	unsigned int val = 0;
>> +
>> +	regmap_read(rm, WSA881X_CHIP_ID1, &wsa881x->version);
>> +	regcache_cache_only(rm, true);
>> +	regmap_multi_reg_write(rm, wsa881x_rev_2_0,
>> +			       ARRAY_SIZE(wsa881x_rev_2_0));
>> +	regcache_cache_only(rm, false);
> 
> This looks broken, what is it supposed to be doing?  It looks
> like it should be a register patch but it's not documented.
> 
Yep, it makes sense to move this to patch, its done in new version.

>> +static const struct snd_kcontrol_new wsa881x_snd_controls[] = {
>> +	SOC_ENUM("Smart Boost Level", smart_boost_lvl_enum),
>> +	WSA881X_PA_GAIN_TLV("PA Gain", WSA881X_SPKR_DRV_GAIN,
>> +			    4, 0xC, 1, pa_gain),
> 
> As covered in control-names.rst all volume controls should end in
> Volume.
> 
Fixed this in next version.

>> +static void wsa881x_clk_ctrl(struct snd_soc_component *comp, bool enable)
>> +{
>> +	struct wsa881x_priv *wsa881x = snd_soc_component_get_drvdata(comp);
>> +
>> +	mutex_lock(&wsa881x->res_lock);
> 
> What is this lock supposed to be protecting?  As far as I can
> tell this function is the only place it is used and this function
> has exactly one caller which itself has only one caller which is
> a DAPM widget and hence needs no locking.  It looks awfully like
> it should just be a widget itself, or inlined into the single
> caller.
> 
This was done for temperature sensor reads which can happen in parallel.
But for now I will remove it and add back once we add tsens support.

>> +static void wsa881x_bandgap_ctrl(struct snd_soc_component *comp, bool enable)
>> +{
>> +	struct wsa881x_priv *wsa881x = snd_soc_component_get_drvdata(comp);
> 
> Similarly here.
> 
This one was over done! its now removed in next version.

>> +static int32_t wsa881x_resource_acquire(struct snd_soc_component *comp,
>> +					bool enable)
>> +{
>> +	wsa881x_clk_ctrl(comp, enable);
>> +	wsa881x_bandgap_ctrl(comp, enable);
>> +
>> +	return 0;
>> +}
> 
> There's no corresponding disables.

both wsa881x_clk_ctrl() and wsa881x_bandgap_ctrl() have corresponding 
disables in that functions.

thanks,
srini
> 
