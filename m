Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C20B170B70
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 23:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgBZWXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 17:23:32 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36679 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbgBZWXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 17:23:32 -0500
Received: by mail-ot1-f68.google.com with SMTP id j20so1047250otq.3;
        Wed, 26 Feb 2020 14:23:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9/KR8/ro7ANRurfSfz9QDDSqoIKmisafRnjItkiqO1U=;
        b=E0KQnAPlQ4Ou8K8JODSGbFeMdPRlSRn/4oRFkG3yY8Nm12sj0GNS/OcqcvQpHW9KGw
         t4xT1+XJ/ynY14Bp3CEAIpgXrrMpFxQHhqAHTOsrDFnpI7mm2vnYDwH9qKJR1/NzuXO3
         H3JBmUsIQc4jxo4zJlMHTkiXrJjZh7d3+hyIwzK8wS2X9qCyERL5SbMGnl/iPkCDv1EQ
         rAMtXXcbcHqutb+PbaD/+Ra1BKrzt80kglMIhnb56IzH2Dc0TanEIVWpoNRHJrUO2BrW
         puXyFPM3U3/D6UKtg6gTJ5MWEBCa3Q6Dwyyp9AAA751k3AzPJoF2XVLLotgyk82l1ak0
         VU8A==
X-Gm-Message-State: APjAAAWTWKopRrgzYu2HZOk4qkyorWU1E/3x87CVNauhxgCOisJvNYmi
        xig3i/C3U2CZ41PyfTzYbA==
X-Google-Smtp-Source: APXvYqxQoc+Y2Yxgre6xns0v4FBKE/B92IK5PIDzgAyBU4JtbAuTWwoJBOY8QPJnsvQfCddn4rj14g==
X-Received: by 2002:a9d:2dea:: with SMTP id g97mr841706otb.33.1582755811422;
        Wed, 26 Feb 2020 14:23:31 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a30sm1226839otc.79.2020.02.26.14.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 14:23:30 -0800 (PST)
Received: (nullmailer pid 9442 invoked by uid 1000);
        Wed, 26 Feb 2020 22:23:30 -0000
Date:   Wed, 26 Feb 2020 16:23:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        adamboardman@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 1/4] dt-bindings: i2c: Document I2C controller binding
 for MT6797 SoC
Message-ID: <20200226222330.GA9392@bogus>
References: <20200222162444.11590-1-manivannan.sadhasivam@linaro.org>
 <20200222162444.11590-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222162444.11590-2-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Feb 2020 21:54:41 +0530, Manivannan Sadhasivam wrote:
> I2C controller driver for MT6577 SoC is reused for MT6797 SoC. Hence,
> document that in DT binding.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
