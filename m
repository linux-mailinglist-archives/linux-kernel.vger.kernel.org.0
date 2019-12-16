Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47190120EA0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 16:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfLPPxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 10:53:53 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46659 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfLPPxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:53:52 -0500
Received: by mail-oi1-f195.google.com with SMTP id a124so3631936oii.13;
        Mon, 16 Dec 2019 07:53:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/9D5bT/6tP3rVi8f9x2mTx0nceNBLJn6Pnm6PW8Q2Io=;
        b=IMMOqhHMM4umPNXoi0CYT4A5c6zMjeP8xKsqb2W+e1P5Bi1/r4rrRY2HAouHJBScFP
         KEo95eOWpO0mCWAX07tfkLNW98aUbgUvWS45SgM1h6Ui5MNI/2VasRUq2o7wyM7Oyv+p
         +3VClTtYWptZT6XeUlIGhcp/nHGm12L2xtlKPihdlp/MQnsw/dMrBzyZGHjj+B63rXFD
         OYA1hCkIHqW9C8Bn/EpdQ8Xt/LPsX96s6yqsYlulGCLbYZ2K0x1Okc/XdGy1nwUmYWah
         oP2M2hU3GsmK1hrwmiZh0mBesrRq7YHbGpQNbYlvdo29rTI/AokFwVM3bww/7EcWdo2D
         6yNA==
X-Gm-Message-State: APjAAAUE38cil935cPexsEJTVbblede4JFhZQpFXq/z23Uc2oLBZVRYx
        rhdFR9OU8CMZQcA1pZBzbA==
X-Google-Smtp-Source: APXvYqyjwLNiOdATGwneeb/VvNya7K52309SCLgJd3wlYpmyowMytvhPIlCjsXsVJ32JPzuOA6Vxbw==
X-Received: by 2002:aca:5f87:: with SMTP id t129mr10180489oib.36.1576511631553;
        Mon, 16 Dec 2019 07:53:51 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e65sm6962874otb.62.2019.12.16.07.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 07:53:51 -0800 (PST)
Date:   Mon, 16 Dec 2019 09:53:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Biwen Li <biwen.li@nxp.com>
Cc:     leoyang.li@nxp.com, shawnguo@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, ran.wang_1@nxp.com,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Biwen Li <biwen.li@nxp.com>
Subject: Re: [v5 3/3] Documentation: dt: binding: fsl: Add
 'fsl,ippdexpcr1-alt-addr' property
Message-ID: <20191216155350.GA10941@bogus>
References: <20191203122818.21941-1-biwen.li@nxp.com>
 <20191203122818.21941-3-biwen.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203122818.21941-3-biwen.li@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Dec 2019 20:28:18 +0800, Biwen Li wrote:
> The 'fsl,ippdexpcr1-alt-addr' property is used to handle an errata A-008646
> on LS1021A
> 
> Signed-off-by: Biwen Li <biwen.li@nxp.com>
> ---
> Change in v5:
> 	- none
> 
> Change in v4:
> 	- rename property name
> 	  fsl,ippdexpcr-alt-addr -> fsl,ippdexpcr1-alt-addr
> 
> Change in v3:
>   	- rename property name
> 	  fsl,rcpm-scfg -> fsl,ippdexpcr-alt-addr
> 
> Change in v2:
>   	- update desc of the property
> 	  'fsl,rcpm-scfg'
> 
>  .../devicetree/bindings/soc/fsl/rcpm.txt      | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
