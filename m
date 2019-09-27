Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA5A9C0A11
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 19:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfI0ROX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 13:14:23 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45641 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfI0ROW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 13:14:22 -0400
Received: by mail-ot1-f68.google.com with SMTP id 41so2847114oti.12;
        Fri, 27 Sep 2019 10:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tD2ql8Ol3YdJ0O/cTPgB7oovPA/McdYPrrIyUtCvDio=;
        b=kEr1RO4nzaWhC4Ulu4VI3BqNmADfIkP5xkNx9S6ziHmshWit8C284I3lNATXCa87Ow
         PNPbk/6nDsgx5WhiQLfggNUO/2e8kmQhJzAQHvsVOsGnSiN6l0udlf91RI+cBjN6rd3t
         Pg6GAoINaYiC85O1nAspgbdSk5k06wkPlWqhEL2dUZAeLCieWlFTHl1nOOOaTbYA5VLs
         aw4UcwVEtIqZfllblLi/GVFSvtxYGGa4adqRnHoWgZuPXKk3Hk1/kNJlu4OTf0QImpZ2
         KJ/6yoyonA/bzLK2uP4EXQz5pZzoP0He70E1AdKzh3I/E1OF4JH8o9Q6qTZiOsgGydeX
         b32w==
X-Gm-Message-State: APjAAAWs+ehsttCn6HX3gSN5ZJ17ccJnY/fGwjvMXpzKHoWcG7beZpvS
        AyA4GFNE/iBMtq/Ktk8FvA==
X-Google-Smtp-Source: APXvYqypL0vEhdlG4ePe2RIoOH0cqp7SRZ9d2fcberRcnUEis5/CkGDrnlNF5opn3EvvXltDKXa2Uw==
X-Received: by 2002:a05:6830:15d7:: with SMTP id j23mr3871347otr.343.1569604461562;
        Fri, 27 Sep 2019 10:14:21 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 21sm1750040oin.26.2019.09.27.10.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 10:14:21 -0700 (PDT)
Date:   Fri, 27 Sep 2019 12:14:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Biwen Li <biwen.li@nxp.com>
Cc:     leoyang.li@nxp.com, shawnguo@kernel.org, mark.rutland@arm.com,
        ran.wang_1@nxp.com, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [v4,3/3] Documentation: dt: binding: fsl: Add
 'fsl,ippdexpcr1-alt-addr' property
Message-ID: <20190927171420.GA28375@bogus>
References: <20190926024118.15931-1-biwen.li@nxp.com>
 <20190926024118.15931-3-biwen.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926024118.15931-3-biwen.li@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 10:41:18AM +0800, Biwen Li wrote:
> The 'fsl,ippdexpcr1-alt-addr' property is used to handle an errata A-008646
> on LS1021A
> 
> Signed-off-by: Biwen Li <biwen.li@nxp.com>
> ---
> Change in v4:
> 	- rename property name
> 	  fsl,ippdexpcr-alt-addr -> fsl,ippdexpcr1-alt-addr
> 
> Change in v3:
> 	- rename property name
> 	  fsl,rcpm-scfg -> fsl,ippdexpcr-alt-addr
> 
> Change in v2:
> 	- update desc of the property 'fsl,rcpm-scfg'
> 
>  .../devicetree/bindings/soc/fsl/rcpm.txt      | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> index 5a33619d881d..751a7655b694 100644
> --- a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> +++ b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> @@ -34,6 +34,13 @@ Chassis Version		Example Chips
>  Optional properties:
>   - little-endian : RCPM register block is Little Endian. Without it RCPM
>     will be Big Endian (default case).
> + - fsl,ippdexpcr1-alt-addr : The property is related to a hardware issue
> +   on SoC LS1021A and only needed on SoC LS1021A.
> +   Must include 1 + 2 entries.
> +   The first entry must be a link to the SCFG device node.
> +   The non-first entry must be offset of registers of SCFG.
> +   The second and third entry compose an alt offset address
> +   for IPPDEXPCR1(SCFG_SPARECR8)

If only on 1 SoC, can't all this be implied by "fsl,ls1021a-rcpm"?

Adding a property means you need both a new dtb and kernel to fix the 
errata. Using the compatible string means you only need a new kernel.

>  
>  Example:
>  The RCPM node for T4240:
> @@ -43,6 +50,20 @@ The RCPM node for T4240:
>  		#fsl,rcpm-wakeup-cells = <2>;
>  	};
>  
> +The RCPM node for LS1021A:
> +	rcpm: rcpm@1ee2140 {
> +		compatible = "fsl,ls1021a-rcpm", "fsl,qoriq-rcpm-2.1+";

Both of these compatible strings aren't documented.

> +		reg = <0x0 0x1ee2140 0x0 0x8>;
> +		#fsl,rcpm-wakeup-cells = <2>;
> +
> +		/*
> +		 * The second and third entry compose an alt offset
> +		 * address for IPPDEXPCR1(SCFG_SPARECR8)
> +		 */
> +		fsl,ippdexpcr1-alt-addr = <&scfg 0x0 0x51c>;
> +	};
> +
> +
>  * Freescale RCPM Wakeup Source Device Tree Bindings
>  -------------------------------------------
>  Required fsl,rcpm-wakeup property should be added to a device node if the device
> -- 
> 2.17.1
> 
