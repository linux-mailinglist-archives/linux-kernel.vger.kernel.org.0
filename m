Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80779124088
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 08:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfLRHru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 02:47:50 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41735 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLRHrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 02:47:49 -0500
Received: by mail-lf1-f68.google.com with SMTP id m30so944081lfp.8;
        Tue, 17 Dec 2019 23:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nokscQl1JvA6OpV4GvGWn17FH9+5TgQgiHxyucvRXr0=;
        b=bWBen/oElwkvKXrpTUboVi2P/lSOZPNr9GQmoGYBFqH02T/VyHBuW0TYF/HqUU6KFr
         tZ4bKYgZjjM8xYfpLzhWJv8MArRkRhUAt/F8CnTN4BP4ldz8pjjS67o6CKxtdIXW2e/M
         MHpkW7nVTK/dSudcadPaCCQSbCncFLnyl/RsNDFOJC/QPszpFh4HyCb05PK1qdETCQ2F
         G3vResEu6brZ0JzmnFmNAMec6rG2TcP+JjGOgCzDRNliG7ex4t54ZRWwXJhsZ7PoRnbp
         h2YF6Lz0Fns/AWZoWcXCSGrqLoPJ+JUB0z0bVkMnNlGf/kwYY/NQAfJqnv0RXvLjWV21
         DOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nokscQl1JvA6OpV4GvGWn17FH9+5TgQgiHxyucvRXr0=;
        b=PRQPnqEi1hNcKeNWzlE0UQulOEy6W9r5newPt7FdDoSy04KXo74bzfPYoyhTUCuwtB
         uk+dBDGqWh9kKKgjmrGfAtY9J/Z6GmVYeF34TWsd/FgdSGdp7/Qe8KZZDWh2DDyvCS2C
         JJDez85IM3RzTQoua84V64ZNSxkUaPSLTfFwPWos+XDP1PFdQM1FTd0R4HpxGnCa2KB7
         8hprV1qFzVhJRElMCa1uUIQjL8LFEWnRrd8VrCxynziY/PdJ7w6yWbRvLUhFOLI/zN1v
         0eZ9dthXVrqERWCCz7x1w3Pc9dSRFvm9U0WPlhmm1XJwkyk0dzBj74azYjis++OlPX4l
         fGsA==
X-Gm-Message-State: APjAAAXL1kyIziXeR74Nu4dXKg4zorOanvmJqv9R8Ax8p8E6CAHIDi+h
        TyaMvPLbSE3cCkdHZaYjs7JlICci
X-Google-Smtp-Source: APXvYqz+CfkLON/D1NMhSf0doeeLndWcWpkn4yEURwpXpsudJkqOg3yvsKH2956LGtgXteWmd7zQSA==
X-Received: by 2002:ac2:41c8:: with SMTP id d8mr823048lfi.65.1576655266559;
        Tue, 17 Dec 2019 23:47:46 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id a15sm623886lfi.60.2019.12.17.23.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 23:47:46 -0800 (PST)
Subject: Re: [PATCH v4 17/19] ARM: tegra: Update sound node clocks in device
 tree
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
 <1576613046-17159-18-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3dd0e953-220a-e265-8a12-aa68682aa9f0@gmail.com>
Date:   Wed, 18 Dec 2019 10:47:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1576613046-17159-18-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.12.2019 23:04, Sowjanya Komatineni пишет:
> clk_out_1, clk_out_2, and clk_out_3 are part of Tegra PMC block
> and are moved from clock driver to pmc driver with pmc as clock
> provider.
> DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
> 	t=1576613055; bh=aZWp4sScdv8qprM+UpGS0w1DX7YelR50gFqoThf23X4=;
> 	h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
> 	 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
> 	 Content-Type;
> 	b=p9EmVtuTvJK6owqo0lmnZnAvftCWc6+7Mkp/Ks9y26tKN5c4jU+I+YEAaMWoHuzd+
> 	 7n0vS98WNMGomj19IUXoaH49IeTgPAlqOkU57IIiL2qEnX3sYNYpl/rCRUIs7vd33t
> 	 LSn8tQeu9Lz+Yfl8hvXcN3sdxRQOEPDYwzWG+tVy1FCnwouTHSfBhgado2Tx/9cWgi
> 	 HlSWkzjvodag7mAmZtLCl5P4J+oVEJnpYnjSZKNojqszn8u651ErvnVI/VbhZwQ0G5
> 	 Yg8kEr8YECPk2L4MXUe8J2YmKtNyZaADOkUhjyxqMjZ2bGrB9RDm5dKNFxkWuEeSpb
> 	 U3nMi7MNcvBmQ==
> 
> clk_out_1 is dedicated for audio mclk on Tegra30 through Tegra210.
> 
> This patch updates device tree sound node to use clk_out_1 from
> pmc provider as mclk and uses assigned-clock properties to specify
> clock parents for clk_out_1 and extern1.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  arch/arm/boot/dts/tegra114-dalmore.dts      | 7 ++++++-
>  arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 7 ++++++-
>  arch/arm/boot/dts/tegra124-apalis.dtsi      | 7 ++++++-
>  arch/arm/boot/dts/tegra124-jetson-tk1.dts   | 7 ++++++-
>  arch/arm/boot/dts/tegra124-nyan.dtsi        | 7 ++++++-
>  arch/arm/boot/dts/tegra124-venice2.dts      | 7 ++++++-
>  arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi  | 7 ++++++-
>  arch/arm/boot/dts/tegra30-apalis.dtsi       | 7 ++++++-
>  arch/arm/boot/dts/tegra30-beaver.dts        | 7 ++++++-
>  arch/arm/boot/dts/tegra30-cardhu.dtsi       | 7 ++++++-
>  arch/arm/boot/dts/tegra30-colibri.dtsi      | 7 ++++++-
>  11 files changed, 66 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
> index 97a5c3504bbe..c1914b590f5c 100644
> --- a/arch/arm/boot/dts/tegra114-dalmore.dts
> +++ b/arch/arm/boot/dts/tegra114-dalmore.dts
> @@ -1296,7 +1296,12 @@
>  
>  		clocks = <&tegra_car TEGRA114_CLK_PLL_A>,
>  			 <&tegra_car TEGRA114_CLK_PLL_A_OUT0>,
> -			 <&tegra_car TEGRA114_CLK_EXTERN1>;
> +			 <&pmc TEGRA_PMC_CLK_OUT_1>;
>  		clock-names = "pll_a", "pll_a_out0", "mclk";
> +
> +		assigned-clocks = <&tegra_car TEGRA114_CLK_EXTERN1>,
> +				  <&pmc TEGRA_PMC_CLK_OUT_1>;

Won't hurt to add a blank line here, similarly in other places below.

> +		assigned-clock-parents = <&tegra_car TEGRA114_CLK_PLL_A_OUT0>,
> +					 <&tegra_car TEGRA114_CLK_EXTERN1>;

[snip]

