Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 441906E52E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 13:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfGSLrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 07:47:06 -0400
Received: from foss.arm.com ([217.140.110.172]:42322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfGSLrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 07:47:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43AA3337;
        Fri, 19 Jul 2019 04:47:05 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 240093F71A;
        Fri, 19 Jul 2019 04:47:05 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id E41C868065E; Fri, 19 Jul 2019 12:47:03 +0100 (BST)
Date:   Fri, 19 Jul 2019 12:47:03 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Wen He <wen.he_1@nxp.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        brian.starkey@arm.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, leoyang.li@nxp.com
Subject: Re: [v2 2/3] dt/bindings: display: Add optional property node
 defined for Mali DP500
Message-ID: <20190719114703.GC16673@e110455-lin.cambridge.arm.com>
References: <20190719095842.11683-1-wen.he_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190719095842.11683-1-wen.he_1@nxp.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 05:58:42PM +0800, Wen He wrote:
> Add optional property node 'arm,malidp-arqos-value' for the Mali DP500.
> This property describe the ARQoS levels of DP500's QoS signaling.
> 
> Signed-off-by: Wen He <wen.he_1@nxp.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Thanks for the patch!

Best regards,
Liviu

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
>  
>  
>  Example:
> @@ -54,6 +56,7 @@ Example:
>  		clocks = <&oscclk2>, <&fpgaosc0>, <&fpgaosc1>, <&fpgaosc1>;
>  		clock-names = "pxlclk", "mclk", "aclk", "pclk";
>  		arm,malidp-output-port-lines = /bits/ 8 <8 8 8>;
> +		arm,malidp-arqos-high-level = <&rqosvalue>;
>  		port {
>  			dp0_output: endpoint {
>  				remote-endpoint = <&tda998x_2_input>;
> -- 
> 2.17.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
