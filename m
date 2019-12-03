Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1A20111BBD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 23:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfLCWhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 17:37:06 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36317 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbfLCWhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:37:06 -0500
Received: by mail-oi1-f194.google.com with SMTP id c16so4987554oic.3;
        Tue, 03 Dec 2019 14:37:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NnWqN+v6idF+rYohPBc8yK8WHdS4XunbYI4eJ0qCx44=;
        b=qLvXrafEhECzB00M92S5NoPrN0EMhLLOobUfVu4OGWPo4L+CBYM2sWwoYhc9HHmyTo
         akc1URSkmKipvL6CkfvZ41qvBd0TBPHsoEPXHKgCoGj39gUCFkXPrzpNTQgHl4LJpS+h
         FLAXEplOUwwaLwc7+Jgwz6buS8FBCQ7eDbgwH1d/XXlhF58qrvEn7PVxmCLyohiOq96M
         BBJc0yolsK/86LS3v3jSTflu4D4RA/gSuL4mITXhMkRLE9+k5BnDBWLcllRAUGfODAJn
         6CFVPIWOOkkFU2Oz2SsFaC3rwtUsrtOEEPKYHiWCX0/OvQ1RJJ0dQve5VmvE68vea4jr
         fiMg==
X-Gm-Message-State: APjAAAVRzVTeGhcVK9EtadVvHJ5rOodJMkEXHNCuwxVcnbHHyLke6qDt
        GN7dGJi6e+3phu8W6iCgEg==
X-Google-Smtp-Source: APXvYqyY+MvnuM+hiACvXhy/3tKtbTc72UkG95+81S0zipokTze6+5MxpHqRBYpAnCxnfaY6IROUJQ==
X-Received: by 2002:aca:4cc7:: with SMTP id z190mr996oia.10.1575412625132;
        Tue, 03 Dec 2019 14:37:05 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m2sm1615150oim.13.2019.12.03.14.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 14:37:04 -0800 (PST)
Date:   Tue, 3 Dec 2019 16:37:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Levin Du <djw@t-chip.com.cn>,
        Akash Gajjar <akash@openedev.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Da Xue <da@lessconfused.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: rockchip: Add libretech for
 roc-pc binding
Message-ID: <20191203223704.GA29109@bogus>
References: <20191119185817.11216-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119185817.11216-1-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 12:28:16AM +0530, Jagan Teki wrote:
> Though the ROC-PC is manufactured by firefly, it is co-designed
> by libretch like other Libretech computer boards from allwinner,
> amlogic does.
> 
> It is always meaningful to keep maintain those vendors who are
> part of design participation, so add libretech roc-pc compatible
> with existing binding.

Maybe so, but this is pretty pointless if it's not different h/w. 
Compatible strings are simply a h/w identifier.

> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index f7470ed1e17d..45728fd22af8 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -100,6 +100,7 @@ properties:
>        - description: Firefly ROC-RK3399-PC
>          items:
>            - enum:
> +              - libretech,roc-rk3399-pc
>                - firefly,roc-rk3399-pc
>                - firefly,roc-rk3399-pc-mezzanine

This doesn't match your change in the dts. file. The schema says there 
are 2 strings with the first one being 1 of these 3.

>            - const: rockchip,rk3399
> -- 
> 2.18.0.321.gffc6fa0e3
> 
