Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36208637D3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 16:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfGIOWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 10:22:39 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38275 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfGIOWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 10:22:38 -0400
Received: by mail-io1-f67.google.com with SMTP id j6so43531962ioa.5;
        Tue, 09 Jul 2019 07:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nyw3ayYjb6xxz+TXQiu0yImt7hvULSuFd6no466kGDg=;
        b=cojslcn7Qn5H3peNZIMzlMW+/9bM+6ieTKp3Vq1S2EvfQ5iB+NhqVOu7Y2iXcpitr9
         2lkHgEgTueBQxuP5qTd+B/sO5AgsBRQNB4x80oPq/kRVH5GoSkYJW03O1Ase85LuM3Bd
         Uvtyr1uB5M9TaiWvZu6hLKsWkQAQX6ZplbOtyZehN+UWpIZY9SIM+M+1wXbQjyfkrW0j
         n/BUyUo8XEGYrHoHBJu+x8eONlqRt/xybCQdArLJ/UCJZRVVKxeriR6N+69iLemcZau6
         1BxLQK4K0rR7nNGlIJRlpLbDG+EJRYApuAtaUf4tkigk4DA+0CTqNimAyieEPyeHj4Kd
         CLog==
X-Gm-Message-State: APjAAAU3GiNswDJ8Ax5gZJDyYvOoNoOE8bE026R56YKtey5iSLcqR7+7
        fL2S5DzoG+YOzNdQTNVuFw==
X-Google-Smtp-Source: APXvYqwGEmLaEm/oSVALxwoDJQLE4Vi1IOoNxGbBog+3P1/ET15BHO6JQdjBS6+02vhPwx0mCo0XXw==
X-Received: by 2002:a6b:dc08:: with SMTP id s8mr10053113ioc.209.1562682157639;
        Tue, 09 Jul 2019 07:22:37 -0700 (PDT)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id n17sm19238636iog.63.2019.07.09.07.22.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 07:22:36 -0700 (PDT)
Date:   Tue, 9 Jul 2019 08:22:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jumin Li <jumin.li@mediatek.com>
Subject: Re: [PATCH 3/5] dt-bindings: usb: mtk-xhci: add an optional xhci_ck
 clock
Message-ID: <20190709142235.GA11951@bogus>
References: <5e06482a0be15476c7b5825f155accf98275afa8.1560246390.git.chunfeng.yun@mediatek.com>
 <9b6ad8dee142d73b56d653ecb7475c4ed28e5eb8.1560246390.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b6ad8dee142d73b56d653ecb7475c4ed28e5eb8.1560246390.git.chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 01:55:19PM +0800, Chunfeng Yun wrote:
> Add a new optional clock xhci_ck
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
> index 266c2d917a28..91c0704b586b 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
> @@ -29,6 +29,7 @@ Required properties:
>  	"sys_ck": controller clock used by normal mode,
>  	the following ones are optional:
>  	"ref_ck": reference clock used by low power mode etc,
> +	"xhci_ck": controller clock,
>  	"mcu_ck": mcu_bus clock for register access,
>  	"dma_ck": dma_bus clock for data transfer by DMA

A new clock should go at the end to stay backwards compatible.

>  
> @@ -100,7 +101,7 @@ Required properties:
>   - clocks : a list of phandle + clock-specifier pairs, one for each
>  	entry in clock-names
>   - clock-names : must contain "sys_ck", and the following ones are optional:
> -	"ref_ck", "mcu_ck" and "dma_ck"
> +	"ref_ck", "xhci_ck", "mcu_ck" and "dma_ck"
>  
>  Optional properties:
>   - vbus-supply : reference to the VBUS regulator;
> -- 
> 2.21.0
> 
