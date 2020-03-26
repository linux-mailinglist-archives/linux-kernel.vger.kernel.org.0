Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C807E194712
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 20:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgCZTHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 15:07:34 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45316 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgCZTHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 15:07:34 -0400
Received: by mail-io1-f66.google.com with SMTP id a24so6649801iol.12;
        Thu, 26 Mar 2020 12:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XlPdXiaUcWF4l3W2QAopXp48lkN8VSOqX9NF2PO2ytM=;
        b=BeTR7SO6oJCzMeERVN4bLoWaA2s7Bqure483ABH38I3y6Caktcldya5nNEwfNLKO0D
         2P1Hvamj/hFISaI3UInq0hghsuUVUJsvFWF6pEO7OzCn/EFF4BVknSY702hTb9/KkDkv
         0fVMjcppW2xnL2YoiP7M38SXAmpyK3iCssqso4/se21PizyXyoVuQYtqmMX+UKVeFx8a
         Dw/UCZYQ0No0WdJRwiBOVYKrt84JuDxUMyZw7ZBQZUgwHHE92KtQe7aPkyQjQ7zZ7ggY
         uJvgwHmv58WpL7k4q1GWPpnzYOOorXmuau3LWzXVYBzUvRnAYDXSB15C3SbnCWrhvaD2
         fUTw==
X-Gm-Message-State: ANhLgQ2Y9GbPKrIt68ObMBj0Icx5Z7LbrBrssnbw4d/uWyFiWxEY8lHg
        s1A+mdsXC9JurlRZOx58AA==
X-Google-Smtp-Source: ADFU+vu0u0z3TnGzqS0Nm32vixLhgoS0FjOXf+e8I7rjAAQMub6xibKWBxvPhpJxr4Ixt/oZcl0CkQ==
X-Received: by 2002:a02:2a03:: with SMTP id w3mr9353295jaw.142.1585249653148;
        Thu, 26 Mar 2020 12:07:33 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id p69sm625874ill.46.2020.03.26.12.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 12:07:32 -0700 (PDT)
Received: (nullmailer pid 22609 invoked by uid 1000);
        Thu, 26 Mar 2020 19:07:31 -0000
Date:   Thu, 26 Mar 2020 13:07:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     allen <allen.chen@ite.com.tw>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <mripard@kernel.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 1/3] dt-bindings: Add vendor prefix for ITE Tech. Inc.
Message-ID: <20200326190731.GA15606@bogus>
References: <1584941015-20541-1-git-send-email-allen.chen@ite.com.tw>
 <1584941015-20541-2-git-send-email-allen.chen@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584941015-20541-2-git-send-email-allen.chen@ite.com.tw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 01:21:52PM +0800, allen wrote:
> ITE Tech. Inc. (abbreviated as ITE ) is a professional fabless IC
> design house. ITE's core technology includes PC and NB Controller chips,
> Super I/O, High Speed Serial Interface, Video Codec, Touch Sensing,
> Surveillance, OFDM, Sensor Fusion, and so on.

The commit message should explain why you are changing ',' to '.' 
because you are no longer adding the vendor.

> 
> more information on: http://www.ite.com.tw/
> 
> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 4c8eaa1..49b7294 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -482,7 +482,7 @@ patternProperties:
>    "^issi,.*":
>      description: Integrated Silicon Solutions Inc.
>    "^ite,.*":
> -    description: ITE Tech, Inc.
> +    description: ITE Tech. Inc.
>    "^itead,.*":
>      description: ITEAD Intelligent Systems Co.Ltd
>    "^iwave,.*":
> -- 
> 1.9.1
> 
