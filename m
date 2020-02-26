Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6F8170B9E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 23:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgBZWby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 17:31:54 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40594 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbgBZWby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 17:31:54 -0500
Received: by mail-oi1-f195.google.com with SMTP id a142so1242898oii.7;
        Wed, 26 Feb 2020 14:31:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rTUAqhPmK+qIf2l5k1SuT6H7Tq4pnUlwcojSvmo0cfw=;
        b=EGrHZVoa7CffO+2OtPLmjx14q9jvAuCIgdKofwQbIwrOx8hWQrL+JeveMMdfVneOMw
         iKy1QfrO1Se1nvde0Te3ZcYClAsinmZ2/RrR4Aow3Sk0ur25x/kDLKNisfF1AWuNzs1o
         GeGniAgsZMC4SpkquNH3GoX7sUoNLg6bn6anQGb937H4DSDfd7sfbANiiB6Ysymzc8f0
         dx33OIrzMx1WgikPC2aTB03n/twkdLTIpt0VlcIIThFdiH0uSrnJGcB6u7h9HwHFi7Xq
         IuVcH4aTLUy2ccd2oeqfAT4Ovz6sMsDJB3g0i6GiKCYwl+QM8yJIXUvTx/333AsipUWv
         6Z6Q==
X-Gm-Message-State: APjAAAUUx+npbAA/7vaFCwBCNt22hrij7UMm2TDl8ebmQzTSsjLmZY3/
        kHu85HsNvjMxoDk9/vtrjw==
X-Google-Smtp-Source: APXvYqz4Q/TiEhVDfkVrM9F8s2F7tiaSAWB7KSFDKSdZapJSp9W6VGyFqddUm9OUZR088Uvlwll1Vg==
X-Received: by 2002:a54:468b:: with SMTP id k11mr1016759oic.134.1582756313012;
        Wed, 26 Feb 2020 14:31:53 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q5sm1297178oia.21.2020.02.26.14.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 14:31:52 -0800 (PST)
Received: (nullmailer pid 21822 invoked by uid 1000);
        Wed, 26 Feb 2020 22:31:51 -0000
Date:   Wed, 26 Feb 2020 16:31:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Georgii Staroselskii <georgii.staroselskii@emlid.com>,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: arm: sunxi: Add PinePhone 1.0 and 1.1
 bindings
Message-ID: <20200226223151.GA21764@bogus>
References: <20200223172916.843379-1-megous@megous.com>
 <20200223172916.843379-3-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223172916.843379-3-megous@megous.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Feb 2020 18:29:15 +0100, Ondrej Jirman wrote:
> Document board compatible names for Pine64 PinePhone:
> 
> - 1.0 - Developer variant
> - 1.1 - Braveheart variant
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
