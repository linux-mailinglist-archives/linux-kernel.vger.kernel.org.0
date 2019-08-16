Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0DA990AB2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2019 00:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfHPWFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 18:05:02 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41059 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbfHPWFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 18:05:02 -0400
Received: by mail-ot1-f67.google.com with SMTP id o101so10934154ota.8;
        Fri, 16 Aug 2019 15:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m+/GrDOlw8V/WnlKBum1E7h0x50v5VF5XgLEdaqT7lc=;
        b=fV6EHhuIo3duxl3p6QS30erpvZKVSXvqbK6I2Bjjj/sqeqlJ2JmUw9ILv7XCb2XmXF
         SoUfo4J00EkjA46es6d8Tr1wuP5xChbpLnYp60Uoy2sqJaDTOZgGBdsTI4HWHEIQJAC9
         vZ3dx0H5oT/D+SMqmSAlzgSKYoWnQ695aSb48kuNQKwMPoc4ZADG9GP3Cp7FohpZNJC3
         BhrVB75R197Iqw35Rl8Bo2akzQ3YMrYgNmNN80FO6jj77Hx8aHWYmW5N+ulmaiBBcVgg
         gS3bFnOOXHlyo3GIauczHYYYttmAmnojiXsHs2A7h8liMmwvMJ55gYxLS5zGwMIpoWEG
         0/cQ==
X-Gm-Message-State: APjAAAX1mlon+0xx9zYG1yuMvEdPc2Z4fzYvs23SDpYok+XEEJScjc6X
        JDGMxTQKwrXG1JWuXTfDDA==
X-Google-Smtp-Source: APXvYqweBwEeIPrnPyr8HVOmsSdh2iM9PU4khjo3aK/6Wx6KSjzTLcpBvnY3z0DI62wGpQ7ZR1JXyA==
X-Received: by 2002:a9d:39c8:: with SMTP id y66mr8896600otb.289.1565993101012;
        Fri, 16 Aug 2019 15:05:01 -0700 (PDT)
Received: from localhost ([2607:fb90:1cdf:eef6:c125:340:5598:396e])
        by smtp.gmail.com with ESMTPSA id u17sm1858033oif.11.2019.08.16.15.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 15:05:00 -0700 (PDT)
Date:   Fri, 16 Aug 2019 17:04:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ronen Krupnik <ronenk@amazon.com>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, barakw@amazon.com, dwmw@amazon.co.uk,
        benh@amazon.com, jonnyc@amazon.com, talel@amazon.com,
        hhhawa@amazon.com, hanochu@amazon.com
Subject: Re: [PATCH 1/2] dt-bindings: amazon: add Amazon Annapurna Labs
 Alpine support
Message-ID: <20190816220459.GA17518@bogus>
References: <20190728195135.12661-1-ronenk@amazon.com>
 <20190728195135.12661-2-ronenk@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728195135.12661-2-ronenk@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 10:51:34PM +0300, Ronen Krupnik wrote:
> This patch adds DT bindings info for Amazon Annapurna Labs Alpine SOC
> and related reference boards.
> 
> Signed-off-by: Ronen Krupnik <ronenk@amazon.com>
> ---
>  .../devicetree/bindings/arm/amazon,alpine.txt | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/amazon,alpine.txt

Board bindings are in DT schema format now.

Also, we already have al,alpine.yaml. Please combine with that one or 
remove it perhaps. Seems kind of abandoned given the lack of response on 
it.

> 
> diff --git a/Documentation/devicetree/bindings/arm/amazon,alpine.txt b/Documentation/devicetree/bindings/arm/amazon,alpine.txt
> new file mode 100644
> index 000000000000..58817208421b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/amazon,alpine.txt
> @@ -0,0 +1,23 @@
> +Amazon Annapurna Labs Alpine v3 Platform Device Tree Bindings
> +---------------------------------------------------------------
> +
> +Platforms based on Amazon Annapurna Labs Alpine SoC architecture
> +shall follow the following scheme:
> +
> +SoCs
> +----
> +
> +Each device tree root node must specify which exact SoC in alpine
> +architecture it uses, using one of the following compatible values:
> +
> +- alpine v3
> +  compatible = "amazon,alpine-v3";
> +
> +Boards
> +------
> +
> +Each device tree must specify which one or more of the following
> +board-specific compatible values:
> +
> +- alpine-v3 Evaluation Platform (EVP)
> +  compatible = "amazon,alpine-v3-evp";
> -- 
> 2.21.0
> 
