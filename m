Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1C83123EBC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 06:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfLRFPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 00:15:51 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45262 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfLRFPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 00:15:50 -0500
Received: by mail-lf1-f65.google.com with SMTP id 203so675165lfa.12;
        Tue, 17 Dec 2019 21:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Muu5q8Fps2+SKFxVklBGeC5/MVx/Fov2oo+BdZqlLjg=;
        b=L4ZhOowTQpZdtmeCPOjp0Sl/kuNotYeKtNtPZQUmNBaWSaSko1SGQVK9McyzRx5jpK
         EVuPOvuhHw/Qayem+7mKKWll22hEyM3nN5rab4WIL+3BVVl/0950htgVwcdQz0uNRAV0
         pZe7wx6lGhavyjEksHHn3WG0bNCoe9jQke4kZAySDpsbaFgi62fIrAsDA/KXwk06wENv
         CXlYwGs99ZF1bgVcW6JKPnFbgflY30/tHbmMWJhLsYSiHq84zRx255XqUHY+CLu1NCRF
         qG3emucrvNEc5hCBhedF6IK3qb8QTiwyCclYfu7I8846utKRwvBQOXckxRtdq1OJYfee
         tYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Muu5q8Fps2+SKFxVklBGeC5/MVx/Fov2oo+BdZqlLjg=;
        b=gNs0iKwPXc1v6CTCY6FQBlTjvz1ObQD8utSvuzHV9wWH5B1skgeaoih2rQA8k0BPdd
         edeHWk7YJ31cKdX40fd8HcLCwk6UxIPQVgkG4Wvy7tt0jHpC9hvRmCDRzF977tvsCLr3
         AhNRfWqtE8y4Pv2FjiWlPiwuV1oPGI1NWkfHXJ53ZXLYxAk9dUCTiMmS5yQNE//dyEz+
         7CWqJLUefJ7R5BkKsS8hd8sTHjeh1eVbJHSsT3124ZhObkl9qe/bMjg9iF5VnQ4XEXKk
         yapeqYNkpotX71/IbayW2sNlkZe2D1eiiKRBe2TF6pQslYAh7QMM717C6vZFcrrtatsr
         29sw==
X-Gm-Message-State: APjAAAXNWhZa+YXgJOqjCfMzJE81046zjK59Qk54YYqn/n+3HcPOPvMh
        yWQf9Y3ZDvlYloUTTUDhRQwHh58l
X-Google-Smtp-Source: APXvYqxUpZwUFVyWk7q3cYBXx7sJpOFPMix6TwEawFTqUljubYnlDHGvWcpU69oxSeKohmNsmtX5Jw==
X-Received: by 2002:a19:22cc:: with SMTP id i195mr436477lfi.148.1576645696280;
        Tue, 17 Dec 2019 21:08:16 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id p15sm385752lfo.88.2019.12.17.21.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 21:08:15 -0800 (PST)
Subject: Re: [PATCH v4 08/19] soc: tegra: Add support for 32KHz blink clock
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1576613046-17159-1-git-send-email-skomatineni@nvidia.com>
 <1576613046-17159-9-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b3f79e55-2104-c571-5d2a-27f4d549a404@gmail.com>
Date:   Wed, 18 Dec 2019 08:08:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1576613046-17159-9-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.12.2019 23:03, Sowjanya Komatineni пишет:
> Tegra PMC has blink control to output 32 Khz clock out to Tegra
> blink pin. Blink pad DPD state and enable controls are part of
> Tegra PMC register space.
> 
> Currently Tegra clock driver registers blink control by passing
> PMC address and register offset to clk_register_gate which performs
> direct PMC access during clk_ops and with this when PMC is in secure
> mode, any access from non-secure world does not go through.
> 
> This patch adds blink control registration to the Tegra PMC driver
> using PMC specific clock gate operations that use tegra_pmc_readl
> and tegra_pmc_writel to support both secure mode and non-secure
> mode PMC register access.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
> 
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 6d65194a6e71..19996c21c60d 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -61,12 +61,15 @@
>  #define  PMC_CNTRL_SYSCLK_OE		BIT(11) /* system clock enable */
>  #define  PMC_CNTRL_SYSCLK_POLARITY	BIT(10) /* sys clk polarity */
>  #define  PMC_CNTRL_PWRREQ_POLARITY	BIT(8)
> +#define  PMC_CNTRL_BLINK_EN		7
>  #define  PMC_CNTRL_MAIN_RST		BIT(4)
>  
>  #define PMC_WAKE_MASK			0x0c
>  #define PMC_WAKE_LEVEL			0x10
>  #define PMC_WAKE_STATUS			0x14
>  #define PMC_SW_WAKE_STATUS		0x18
> +#define PMC_DPD_PADS_ORIDE		0x1c
> +#define  PMC_DPD_PADS_ORIDE_BLINK	20
>  
>  #define DPD_SAMPLE			0x020
>  #define  DPD_SAMPLE_ENABLE		BIT(0)
> @@ -79,6 +82,7 @@
>  
>  #define PWRGATE_STATUS			0x38
>  
> +#define PMC_BLINK_TIMER			0x40
>  #define PMC_IMPL_E_33V_PWR		0x40
>  
>  #define PMC_PWR_DET			0x48
> @@ -170,6 +174,14 @@ struct pmc_clk {
>  
>  #define to_pmc_clk(_hw) container_of(_hw, struct pmc_clk, hw)
>  
> +struct pmc_clk_gate {
> +	struct clk_hw	hw;
> +	unsigned long	offs;
> +	u32		shift;
> +};
> +
> +#define to_pmc_clk_gate(_hw) container_of(_hw, struct pmc_clk_gate, hw)
> +
>  struct pmc_clk_init_data {
>  	char *name;
>  	const char *const *parents;
> @@ -320,6 +332,7 @@ struct tegra_pmc_soc {
>  
>  	const struct pmc_clk_init_data *pmc_clks_data;
>  	unsigned int num_pmc_clks;
> +	bool has_blink_output;
>  };
>  
>  static const char * const tegra186_reset_sources[] = {
> @@ -2330,6 +2343,60 @@ tegra_pmc_clk_out_register(const struct pmc_clk_init_data *data,
>  	return clk_register(NULL, &pmc_clk->hw);
>  }
>  
> +static int pmc_clk_gate_is_enabled(struct clk_hw *hw)
> +{
> +	struct pmc_clk_gate *gate = to_pmc_clk_gate(hw);
> +
> +	return tegra_pmc_readl(pmc, gate->offs) & BIT(gate->shift) ? 1 : 0;
> +}
> +
> +static int pmc_clk_gate_enable(struct clk_hw *hw)
> +{
> +	struct pmc_clk_gate *gate = to_pmc_clk_gate(hw);
> +
> +	pmc_clk_set_state(gate->offs, gate->shift, 1);
> +
> +	return 0;
> +}
> +
> +static void pmc_clk_gate_disable(struct clk_hw *hw)
> +{
> +	struct pmc_clk_gate *gate = to_pmc_clk_gate(hw);
> +
> +	pmc_clk_set_state(gate->offs, gate->shift, 0);
> +}
> +
> +static const struct clk_ops pmc_clk_gate_ops = {
> +	.is_enabled = pmc_clk_gate_is_enabled,
> +	.enable = pmc_clk_gate_enable,
> +	.disable = pmc_clk_gate_disable,
> +};
> +
> +static struct clk *
> +tegra_pmc_clk_gate_register(const char *name, const char *parent_name,
> +			    unsigned long flags, unsigned long offset,
> +			    u32 shift)
> +{
> +	struct clk_init_data init;
> +	struct pmc_clk_gate *gate;
> +
> +	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
> +	if (!gate)
> +		return ERR_PTR(-ENOMEM);
> +
> +	init.name = name;
> +	init.ops = &pmc_clk_gate_ops;
> +	init.parent_names = &parent_name;
> +	init.num_parents = 1;
> +	init.flags = flags;

What about "init.flags = 0"?

> +	gate->hw.init = &init;
> +	gate->offs = offset;
> +	gate->shift = shift;
> +
> +	return clk_register(NULL, &gate->hw);
> +}
> +
>  static void tegra_pmc_clock_register(struct tegra_pmc *pmc,
>  				     struct device_node *np)
>  {
> @@ -2339,6 +2406,8 @@ static void tegra_pmc_clock_register(struct tegra_pmc *pmc,
>  	int i, err = -ENOMEM;
>  
>  	num_clks = pmc->soc->num_pmc_clks;
> +	if (pmc->soc->has_blink_output)
> +		num_clks += 1;
>  
>  	if (!num_clks)
>  		return;
> @@ -2380,6 +2449,37 @@ static void tegra_pmc_clock_register(struct tegra_pmc *pmc,
>  		}
>  	}
>  
> +	if (pmc->soc->has_blink_output) {
> +		tegra_pmc_writel(pmc, 0x0, PMC_BLINK_TIMER);
> +		clk = tegra_pmc_clk_gate_register("blink_override",
> +						  "clk_32k", 0,
> +						  PMC_DPD_PADS_ORIDE,
> +						  PMC_DPD_PADS_ORIDE_BLINK);
> +		if (IS_ERR(clk)) {
> +			dev_err(pmc->dev, "unable to register blink_override\n");
> +			err = PTR_ERR(clk);
> +			goto free_clks;
> +		}
> +
> +		clk = tegra_pmc_clk_gate_register("blink",
> +						  "blink_override", 0,
> +						  PMC_CNTRL,
> +						  PMC_CNTRL_BLINK_EN);
> +		if (IS_ERR(clk)) {
> +			dev_err(pmc->dev, "unable to register blink\n");
> +			err = PTR_ERR(clk);
> +			goto free_clks;
> +		}
> +
> +		clk_data->clks[TEGRA_PMC_CLK_BLINK] = clk;
> +		err = clk_register_clkdev(clk, "blink", NULL);
> +		if (err) {
> +			dev_err(pmc->dev,
> +				"unable to register blink clock lookup\n");
> +			goto free_clks;
> +		}
> +	}
> +
>  	err = of_clk_add_provider(np, of_clk_src_onecell_get, clk_data);
>  	if (err) {
>  		dev_err(pmc->dev, "failed to add pmc clk provider\n");
> @@ -2658,6 +2758,7 @@ static const struct tegra_pmc_soc tegra20_pmc_soc = {
>  	.num_reset_levels = 0,
>  	.pmc_clks_data = NULL,
>  	.num_pmc_clks = 0,
> +	.has_blink_output = true,
>  };
>  
>  static const char * const tegra30_powergates[] = {
> @@ -2707,6 +2808,7 @@ static const struct tegra_pmc_soc tegra30_pmc_soc = {
>  	.num_reset_levels = 0,
>  	.pmc_clks_data = tegra_pmc_clks_data,
>  	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
> +	.has_blink_output = true,
>  };
>  
>  static const char * const tegra114_powergates[] = {
> @@ -2760,6 +2862,7 @@ static const struct tegra_pmc_soc tegra114_pmc_soc = {
>  	.num_reset_levels = 0,
>  	.pmc_clks_data = tegra_pmc_clks_data,
>  	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
> +	.has_blink_output = true,
>  };
>  
>  static const char * const tegra124_powergates[] = {
> @@ -2873,6 +2976,7 @@ static const struct tegra_pmc_soc tegra124_pmc_soc = {
>  	.num_reset_levels = 0,
>  	.pmc_clks_data = tegra_pmc_clks_data,
>  	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
> +	.has_blink_output = true,
>  };
>  
>  static const char * const tegra210_powergates[] = {
> @@ -2989,6 +3093,7 @@ static const struct tegra_pmc_soc tegra210_pmc_soc = {
>  	.wake_events = tegra210_wake_events,
>  	.pmc_clks_data = tegra_pmc_clks_data,
>  	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
> +	.has_blink_output = true,
>  };
>  
>  #define TEGRA186_IO_PAD_TABLE(_pad)					     \
> @@ -3120,6 +3225,7 @@ static const struct tegra_pmc_soc tegra186_pmc_soc = {
>  	.wake_events = tegra186_wake_events,
>  	.pmc_clks_data = NULL,
>  	.num_pmc_clks = 0,
> +	.has_blink_output = false,
>  };
>  
>  static const struct tegra_io_pad_soc tegra194_io_pads[] = {
> @@ -3239,6 +3345,7 @@ static const struct tegra_pmc_soc tegra194_pmc_soc = {
>  	.wake_events = tegra194_wake_events,
>  	.pmc_clks_data = NULL,
>  	.num_pmc_clks = 0,
> +	.has_blink_output = false,
>  };
>  
>  static const struct of_device_id tegra_pmc_match[] = {
> 

