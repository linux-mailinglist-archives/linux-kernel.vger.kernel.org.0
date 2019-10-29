Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8488AE882C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 13:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbfJ2M3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 08:29:38 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43648 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfJ2M3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:29:37 -0400
Received: by mail-oi1-f193.google.com with SMTP id s5so8716285oie.10;
        Tue, 29 Oct 2019 05:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=okLPsosnjsIdAglbOpT+46TAv0woYLu5g4KKw1XBUMA=;
        b=lM6VWrT9du2QY1TbvJlMHZnGLobKPcF0GBn/06Edvjns67NhXPGISiqeOwl2ETwdrY
         INXVaQHFjA1L/4WVeluNbRdooUk3HM2vgDvjPfPA9lCQv0pqVEhwEQjPtNnFP/ZKiQzM
         4LM9i48qE0MpSwjC4GESNTcSY7cHIwcbttPYUwWo4QMeH0zZoql8yMhhQQ9RMaf9LBeF
         MelIXESTwTIGurwE2q/V9ppC0b0WaJ3F5+TgTU++Srwc5nB7P8Se0FGV+tY8lCznHzfu
         7+b2Z+AIu9w4jvcOwvr5vFurwWybYGdh6JCDBLIO3TzfGz55q64NFPzJQe6Ig1vTFvn6
         fqNg==
X-Gm-Message-State: APjAAAUknjtybA0IwoxlJ1rOKgGS4FL985J6ues4fGxDkmPiNf9yxwvm
        O+bqd5M9b59sJmsj6KNmNA==
X-Google-Smtp-Source: APXvYqyO8DH2IEhStv2gSlye9+VbvTmQX6+T9WxWt66DaOIg31GxlTrzat5+Bsvuee/7K8GJyRccXw==
X-Received: by 2002:aca:4896:: with SMTP id v144mr3970672oia.16.1572352176888;
        Tue, 29 Oct 2019 05:29:36 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m4sm4653250otm.14.2019.10.29.05.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 05:29:36 -0700 (PDT)
Date:   Tue, 29 Oct 2019 07:29:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: at91: Document Kizboxmini boards
 binding
Message-ID: <20191029122935.GA8412@bogus>
References: <20191018140304.31547-1-kamel.bouhara@bootlin.com>
 <20191018140304.31547-2-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018140304.31547-2-kamel.bouhara@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 04:03:03PM +0200, Kamel Bouhara wrote:
> Document devicetree's bindings for the SAM9G25 Kizbox Mini boards of
> Overkiz SAS.
> 
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> ---
>  .../devicetree/bindings/arm/atmel-at91.yaml        | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> index 1e72e3e6e025..666462988179 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> +++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> @@ -35,6 +35,20 @@ properties:
>                - atmel,at91sam9x60
>            - const: atmel,at91sam9
>  
> +      - description: Overkiz kizbox Mini Mother Board
> +        items:
> +          - const: overkiz,kizboxmini-mb
> +          - const: atmel,at91sam9g25
> +          - const: atmel,at91sam9x5
> +          - const: atmel,at91sam9
> +
> +      - description: Overkiz kizbox Mini RailDIN
> +        items:
> +          - const: overkiz,kizboxmini-rd
> +          - const: atmel,at91sam9g25
> +          - const: atmel,at91sam9x5
> +          - const: atmel,at91sam9

These 2 can also be combined into 1 entry.

> +
>        - items:
>            - enum:
>                - atmel,at91sam9g15
> -- 
> 2.23.0
> 
