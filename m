Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F836102E9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 00:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfD3WzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 18:55:07 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40669 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfD3WzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 18:55:06 -0400
Received: by mail-ot1-f66.google.com with SMTP id w6so13495725otl.7;
        Tue, 30 Apr 2019 15:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PlWRnvoNeGSRNiJdO+rj0X41rOIxvI08504/rjFNJko=;
        b=nwRhYS9/n/aLxTohiuYNbu9KvPc2dGmvVus9AqlCc35o1Jtibs927aQ2OufBxM2SAV
         q4TKq2vcrPMXUjY9+XdZL0v04b3JDyGmgiW1E8N1t5Qh5K6nR3erEOUL/Qs8NlsD7tbh
         MlB211WTB/2RHr3GtxT4UZpO4ZggUFjbL5mvRIIH3rAqG5y+Mop+W8rpPkSxi5QzSnwg
         zBpdoVPHSHEQbzfHrx51Gk2sCjAcDF5dmqOqiBYUd98xMy1TOJ6uDDBZAZ3V+qMEYV4m
         jmL+yIOsGH7uvkeapt3rd2xBME5HQzCL9VXyJdgLnHKyiYP6VSeTnJLFeuPK2igw8RQs
         sz/Q==
X-Gm-Message-State: APjAAAVcb8k4FiYv6wJ7TuE900IXokTNCiRzuCHBv9dAtPlvgXRmLKS0
        zkAM+zznhmNGOyso47vQ6w==
X-Google-Smtp-Source: APXvYqyIFTwoGmBY/KtB3oMGtf5E54aGT5YMyl6jv5MMXbn3oykKcqG1y7OLSDTNFdZVtXegYuj+jw==
X-Received: by 2002:a9d:6d8e:: with SMTP id x14mr1020773otp.251.1556664905932;
        Tue, 30 Apr 2019 15:55:05 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k14sm7980382otl.72.2019.04.30.15.55.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 15:55:04 -0700 (PDT)
Date:   Tue, 30 Apr 2019 17:55:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mallikarjun Kasoju <mkasoju@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] dt-bindings: mfd: max77620: Add
 maxim,system-power-controller property
Message-ID: <20190430225504.GA19387@bogus>
References: <20190424224900.8018-1-digetx@gmail.com>
 <20190424224900.8018-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424224900.8018-6-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 01:48:59AM +0300, Dmitry Osipenko wrote:
> Add new property that designates the PMIC as the system's power
> controller.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/max77620.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/max77620.txt b/Documentation/devicetree/bindings/mfd/max77620.txt
> index 9058499051e0..dda6d158b170 100644
> --- a/Documentation/devicetree/bindings/mfd/max77620.txt
> +++ b/Documentation/devicetree/bindings/mfd/max77620.txt
> @@ -18,6 +18,9 @@ Optional properties:
>  			IRQ numbers for different interrupt source of MAX77620
>  			are defined at dt-bindings/mfd/max77620.h.
>  
> +- maxim,system-power-controller: Indicates that this PMIC is controlling the
> +				 system power.

Drop the 'maxim'. We have a standard property for this.

> +
>  Optional subnodes and their properties:
>  =======================================
>  
> -- 
> 2.21.0
> 
