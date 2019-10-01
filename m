Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1489FC35F9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 15:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388623AbfJANjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 09:39:41 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43695 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfJANjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:39:41 -0400
Received: by mail-ot1-f67.google.com with SMTP id o44so11539261ota.10;
        Tue, 01 Oct 2019 06:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VUMlq66dEzuwplXVYJdSygdvuPoZ83mfs0aFAtH/Dos=;
        b=CcEtSPk0OmURoPKu2Mbca7v0SPoURBvFJkYYMr64Ba2kijtzbG4LU1ss31wCcn1uyQ
         mVkZKqtsXuGjVoNoihvwUkTSmyVYTOJZj/C/t1i/XpicJaxsWwdx6EC6T+U7X3suQRkv
         tDMfg8TiGICds+ZOecIHH4hkrHY7LtqyOZQNuVJZbM3R9fDKVdnDWeBNaVX9uwWpuSfq
         2o53DWIyruolzL8WV7VuXaJ2ttBo2X4OweEbAAwB+7fkZVaBmuk18glxHK2TJIc13oCG
         tCOA5xgH12CJUO/88dA21/G6TUbCvqyqtlNXqV9szh0d3ozVk8Iy+7uGkHv22ILVZ1jk
         OVgQ==
X-Gm-Message-State: APjAAAWdm+I9LXfyXOW1AccARojkd1eNzgZRc47WgrJf9uyzudAZNN45
        EnXtkjK319IWsvNHTPsKvTwbDoUNXw==
X-Google-Smtp-Source: APXvYqwcZLcnAoU3g0ebxrKDG2Zm3JhH90F8tOYDm55u0jQnbo17K7uPCU6e+MSayZYt4F74qyGV+A==
X-Received: by 2002:a9d:7251:: with SMTP id a17mr1388490otk.110.1569937180254;
        Tue, 01 Oct 2019 06:39:40 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j11sm4674948otk.80.2019.10.01.06.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 06:39:39 -0700 (PDT)
Date:   Tue, 1 Oct 2019 08:39:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v5 2/2] dt-bindings: timer: Use defines instead of
 numbers in Exynos MCT examples
Message-ID: <20191001133939.GA13715@bogus>
References: <20190930154418.4884-1-krzk@kernel.org>
 <20190930154418.4884-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930154418.4884-2-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Sep 2019 17:44:18 +0200, Krzysztof Kozlowski wrote:
> Make the examples in Exynos Multi Core Timer bindings more readable and
> bring them closer to real DTS by using defines for interrupt flags.
> Fix also GIC interrupt type in example for Exynos4412 (from SPI to PPI).
> 
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Use GIC_PPI where applicable.
> 
> Rebased on top of:
> https://patchwork.kernel.org/project/linux-samsung-soc/list/?series=177667&state=*
> ---
>  .../timer/samsung,exynos4210-mct.yaml         | 37 ++++++++++++++-----
>  1 file changed, 27 insertions(+), 10 deletions(-)
> 

Applied, thanks.

Rob
