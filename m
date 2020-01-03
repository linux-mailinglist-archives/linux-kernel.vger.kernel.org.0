Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A287212F521
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 08:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgACH6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 02:58:08 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:2573 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgACH6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 02:58:08 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47py251QD8z7s;
        Fri,  3 Jan 2020 08:58:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1578038285; bh=zkjL1hrrT7myfigooh6KuldpzOYUcI60uVQjI24wYgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XQtTcmZehlZS0vz8AgGQh39LrS0ZLMZt+Cu2ZBfahf4+0srsdcEM/v4U8O0M9+z0R
         2TyHJE4T9+Iri+aNHvZwbg5ZK5iD19iDcrrih4GqSgMf7iYahVDOLLGll5UlwMNjZ6
         Cpze4GbbHQvWUHh6wJYaRZ1JnlmcMfbxQsEF2S0HmQRXDptkx8X/H61byUAx5rFzSg
         6wg9jXnR6E4UiZw6gT3W+FTeNgXSw4Hlo+XGpBDZwyuW52fQDClh82sswT5NRMZTQ8
         pt3udMMRzshnrNsy1v28z2GL3WCU1G0HPIKWO8cz1ZSbWU6JPzzlFsVc3MpqThhwVg
         KVWqhQ0aByorQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Fri, 3 Jan 2020 08:58:04 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/16] usb: phy: tegra: Use device-tree notion of
 reset-GPIO's active-state
Message-ID: <20200103075803.GC14228@qmqm.qmqm.pl>
References: <20191228203358.23490-1-digetx@gmail.com>
 <20191228203358.23490-11-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191228203358.23490-11-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2019 at 11:33:52PM +0300, Dmitry Osipenko wrote:
[...]
>  static int ulpi_open(struct tegra_usb_phy *phy)
>  {
> -	int err;
> -
> -	err = gpio_direction_output(phy->reset_gpio, 0);
> -	if (err) {
> -		dev_err(phy->u_phy.dev,
> -			"ULPI reset GPIO %d direction not deasserted: %d\n",
> -			phy->reset_gpio, err);
> -		return err;
> -	}
> +	gpiod_set_value_cansleep(phy->reset_gpio, 1);
>  
>  	return 0;
>  }

The message now removed seems inverted to the meaning of the code. Is
this a bug, or the reset really should be asserted here? I can see that
it is deasserted in phy_power_up, but that goes before or after ulpi_open()?
After the change below, the reset is asserted at probe() time now.

[...]
> -		err = devm_gpio_request(&pdev->dev, tegra_phy->reset_gpio,
> -					"ulpi_phy_reset_b");
> +		gpiod = devm_gpiod_get_from_of_node(&pdev->dev, np,
> +						    "nvidia,phy-reset-gpio",
> +						    0, GPIOD_OUT_HIGH,
> +						    "ulpi_phy_reset_b");
> +		err = PTR_ERR_OR_ZERO(gpiod);
>  		if (err) {
> -			dev_err(&pdev->dev, "Request failed for GPIO %d: %d\n",
> -				tegra_phy->reset_gpio, err);
> +			dev_err(&pdev->dev,
> +				"Request failed for reset GPIO: %d\n", err);
>  			return err;
>  		}
> +		tegra_phy->reset_gpio = gpiod;

A nice extension to kernel's printf - "%pe" format - has just landed in
Linus' master tree.

Best Regards,
Micha³ Miros³aw
