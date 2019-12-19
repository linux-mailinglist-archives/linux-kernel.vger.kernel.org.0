Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0CB1265E0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 16:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfLSPhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 10:37:17 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42908 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfLSPhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 10:37:17 -0500
Received: by mail-lf1-f67.google.com with SMTP id y19so4644209lfl.9;
        Thu, 19 Dec 2019 07:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pld/l8edlik8C/F6nI0tM9RySZZrW4VVQNNmZpZC1jA=;
        b=nI797VqKqLspJs5Hggp0kqi6l62H2tT8TJxZHoNn+LLYZHEHW1KkiYa7p/gFTmtJII
         IrheZpDVL/mZbAShCpaRmr1688rHF4isHeE0GG8dHFbznGrxxu462Z3LgnYVXJlT8EQ2
         /wgJm6srsqRtEcLBvbDU+aaKu7kR72mEaWOemV677IVIeVrhYf37WGSgvctZkE+dplo4
         fUAl5qjrt5HODuRpHz2DnPVmgQzQwd07WD83f8B2kwAocf/5hU0zacXpSjWuDAwFW1Vp
         LVdz69iVo91FqOtVkRuCwzW/UZD8rwoMWGJ6CPxjQDNaamz4XHV2jSiWVIDejFmsG5rv
         euHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pld/l8edlik8C/F6nI0tM9RySZZrW4VVQNNmZpZC1jA=;
        b=bYUANCsVfYylRcGvFZgT1b5zRXcfAR8lUKToi2zdVQDma5tTQZ7SstgluoHaCwanV8
         L25xAnDdU13teishFqJ0DV2glRlw/aZE/X95weBpv7J08j9BiYki2eaKjdyitHEII+Um
         klq78FAXBVXbA6RtfymGa1/46TVG/MeXUiZ92VX8+JHAeObPm2extYaysKg3YLEjsCYf
         zp07bavOqexBKZn06nJzTcFj9OZZbtVAte5oZAE+whtV683SJmYkQ0RASDGlU+5FqnGg
         VGUhkZU/TvXvy8jrX/GfTvCVUc5gWTV/mNzgFrvkrCa+dYf0vklQvlgk9ZdgyTRNtvZa
         upWw==
X-Gm-Message-State: APjAAAVVNGq6fECP5FbHBK9M6D268+hc3AwM/NFQlo3t3U9lIBGoHOkJ
        M2M5w1t96unCro1qOuM8Xzvr6MTj
X-Google-Smtp-Source: APXvYqywFGR/vYDQ7UPpw+oGuLm/wQUUV95WLpswDyBfRcZMhxGMphKd0daOZmBRut6p3Nj1VXF6IA==
X-Received: by 2002:ac2:44d9:: with SMTP id d25mr5940423lfm.15.1576769834185;
        Thu, 19 Dec 2019 07:37:14 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id l21sm2802849lfh.74.2019.12.19.07.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 07:37:13 -0800 (PST)
Subject: Re: [PATCH v1 3/4] usb: phy: tegra: Perform general clean up of the
 code
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191218175313.16235-1-digetx@gmail.com>
 <20191218175313.16235-4-digetx@gmail.com> <20191219125437.GB1440537@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a37a10de-2b40-16af-210c-c69049277f35@gmail.com>
Date:   Thu, 19 Dec 2019 18:37:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191219125437.GB1440537@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

19.12.2019 15:54, Thierry Reding пишет:
> On Wed, Dec 18, 2019 at 08:53:12PM +0300, Dmitry Osipenko wrote:
>> This patch fixes few dozens of legit checkpatch warnings, adds missed
>> handling of potential error-cases, fixes ULPI clk-prepare refcounting and
>> prettifies code where makes sense. All these clean-up changes are quite
>> minor and do not fix any problems.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/usb/phy/phy-tegra-usb.c | 367 +++++++++++++++++---------------
>>  1 file changed, 197 insertions(+), 170 deletions(-)
> 
> This could've been multiple patches to make it easier to review, but
> either way:
> 
> Acked-by: Thierry Reding <treding@nvidia.com>

Yes, it probably could be separated into 10 patches, but then there is a
chance that I won't do it because sometimes it takes more time for me to
write commit message than to make a code change + extra time to re-check
every patch before sending it out :)

> One minor comment below...
> 
>> diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
>> index 15bd253d53c9..76949dbbbdc2 100644
>> --- a/drivers/usb/phy/phy-tegra-usb.c
>> +++ b/drivers/usb/phy/phy-tegra-usb.c
> [...]
>> @@ -310,13 +315,16 @@ static void ulpi_close(struct tegra_usb_phy *phy)
>>  	}
>>  }
>>  
>> -static void utmip_pad_power_on(struct tegra_usb_phy *phy)
>> +static int utmip_pad_power_on(struct tegra_usb_phy *phy)
>>  {
>> -	unsigned long val, flags;
>> -	void __iomem *base = phy->pad_regs;
>>  	struct tegra_utmip_config *config = phy->config;
>> +	void __iomem *base = phy->pad_regs;
>> +	unsigned long val, flags;
> 
> I think technically the "val" variable would have to be u32 because
> that's what readl() and writel() operate on.

I had the same thought and decided it's not worth the extra effort.

> That could be a separate
> patch, though and isn't really a big problem.

But I'll do it now for complicity, since you're asking about it (in a v2
perhaps).

Thank you very much for the reviews!
