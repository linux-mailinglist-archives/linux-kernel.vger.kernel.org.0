Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEBDF236C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 01:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732727AbfKGAoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 19:44:04 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33741 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfKGAoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 19:44:04 -0500
Received: by mail-ot1-f67.google.com with SMTP id u13so517742ote.0;
        Wed, 06 Nov 2019 16:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:content-language
         :user-agent;
        bh=0Caqne9b0+WL4rLkBbGp1GBAkgiKkmuIY6NX34hcg68=;
        b=qXDyxn528zdhlTpZaNLtmze7P8oXx/DOo+jajTth4odCB5PRwCmNEqO1ElOfnpxKqc
         v6MLBD2CWF6n9msC/768CcVVf7sK8P69kRCHe5nEfTb4MgAruGpqV0V8/BvjnqlqpIoh
         ozE/os+AVu16bny43vpXhOYCV0Gr8WjmpIu2jBFxuXaA/HVgczJ70RpAJwCNy5+qYle4
         24Ptqp0CdHaOiTvNLvu71VBu1r+gQjjmSYR0tEPFKVzLpAgpu3WDejy0iUowx07f0U6X
         tKuHYSlPKc4lzMA0Znc3TERJWZBBRYaIug8j0X+1OV7gC1JXvza+CI8G8MgK5fXe9yu+
         AnQA==
X-Gm-Message-State: APjAAAVc2CJKJ3AZp0iAIdk7NcljGIbu2Bat4x0BZ5hd+VonRyTfQiS7
        KGqygckelAzRacl+kZLidg==
X-Google-Smtp-Source: APXvYqx92yPoPX4sYPoYWxsUDxAEC9WbCWpCzZTCzN77i7Mtz6MGpHeFiBva2FYZd5mcftwDWyN+yA==
X-Received: by 2002:a9d:6452:: with SMTP id m18mr465800otl.325.1573087443454;
        Wed, 06 Nov 2019 16:44:03 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m12sm131094oih.46.2019.11.06.16.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 16:44:02 -0800 (PST)
Date:   Wed, 6 Nov 2019 18:44:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: add imx8m compatible
 string
Message-ID: <20191107004402.GA13364@bogus>
References: <1572949321-8193-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572949321-8193-1-git-send-email-peng.fan@nxp.com>
Content-Language: en-US
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2019 10:23:36 +0000, Peng Fan wrote:
> 
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add imx8mq/m/n compatible string
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V1:
>  imx8mq/m/n.dtsi already use this compatible string,
>  but not listed in binding doc, so add it.
> 
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
