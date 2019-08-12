Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7068AB09
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 01:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfHLXTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 19:19:49 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39769 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfHLXTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 19:19:49 -0400
Received: by mail-ot1-f66.google.com with SMTP id r21so159614197otq.6;
        Mon, 12 Aug 2019 16:19:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lqrNtsY3z/GqboCx94xUohSgcAprstWJeqrp2vVk0Is=;
        b=d0Nc+1hq54Ja7S5fzMZyKTbQjeAvKICKmn9JhAqVBljzCaPg8sHg/jV/NkG0zHVpts
         ABW3vACRA5V2esh0DSztOVdlG9eEW9X1iMLDJnpsXXM9bHwo0gGAdYKse7MKrvnLQvc4
         rgDuJPHR764/lqBA34YfasS0mPjiYJMQK46piPhoRfkHgvQJq/66TKhef+K7Wo6UNUMY
         /Ja36+16StO9SJHX/GG0zSiM/clEQDGwlaBt3MbWGeIDDWbLDzrgqQVVAWqMYaDZerIF
         /meEwQiGM/hBzqv5h59SlhK+F//nMVP5v6KxFLcCjJNo4X36OjFAzNadkUqSgp9qlZc1
         7i5w==
X-Gm-Message-State: APjAAAXEW8F+Vm/HdoloLel9CwdRpyhmH5iYYyjS9LO2o36vH4dvu2Lp
        Jq7PnOYmCusLH68mpNJPbU6/b/A=
X-Google-Smtp-Source: APXvYqzwBkIvZBYjlD4u+kjMaZdM68xR5wuwLJn2T+FcAD1ydiPZOHSTU9O9tYsk3wdi1CNOJnVggw==
X-Received: by 2002:a5e:9e03:: with SMTP id i3mr880391ioq.66.1565651988117;
        Mon, 12 Aug 2019 16:19:48 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id f1sm11826048ioh.73.2019.08.12.16.19.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 16:19:47 -0700 (PDT)
Date:   Mon, 12 Aug 2019 17:19:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wen He <wen.he_1@nxp.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        liviu.dudau@arm.com, brian.starkey@arm.com, airlied@linux.ie,
        daniel@ffwll.ch, leoyang.li@nxp.com
Subject: Re: [v2 2/3] dt/bindings: display: Add optional property node
 defined for Mali DP500
Message-ID: <20190812231946.GA31179@bogus>
References: <20190719095842.11683-1-wen.he_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719095842.11683-1-wen.he_1@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 05:58:42PM +0800, Wen He wrote:
> Add optional property node 'arm,malidp-arqos-value' for the Mali DP500.
> This property describe the ARQoS levels of DP500's QoS signaling.
> 
> Signed-off-by: Wen He <wen.he_1@nxp.com>
> ---
>  Documentation/devicetree/bindings/display/arm,malidp.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/arm,malidp.txt b/Documentation/devicetree/bindings/display/arm,malidp.txt
> index 2f7870983ef1..76a0e7251251 100644
> --- a/Documentation/devicetree/bindings/display/arm,malidp.txt
> +++ b/Documentation/devicetree/bindings/display/arm,malidp.txt
> @@ -37,6 +37,8 @@ Optional properties:
>      Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt)
>      to be used for the framebuffer; if not present, the framebuffer may
>      be located anywhere in memory.
> +  - arm,malidp-arqos-high-level: integer of u32 value describing the ARQoS
> +    levels of DP500's QoS signaling.

u32 here, and...

>  
>  
>  Example:
> @@ -54,6 +56,7 @@ Example:
>  		clocks = <&oscclk2>, <&fpgaosc0>, <&fpgaosc1>, <&fpgaosc1>;
>  		clock-names = "pxlclk", "mclk", "aclk", "pclk";
>  		arm,malidp-output-port-lines = /bits/ 8 <8 8 8>;
> +		arm,malidp-arqos-high-level = <&rqosvalue>;

phandle here?

>  		port {
>  			dp0_output: endpoint {
>  				remote-endpoint = <&tda998x_2_input>;
> -- 
> 2.17.1
> 
