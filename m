Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F238714B977
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 15:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387594AbgA1OcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 09:32:18 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34341 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733222AbgA1O0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:26:49 -0500
Received: by mail-ot1-f65.google.com with SMTP id a15so12128834otf.1;
        Tue, 28 Jan 2020 06:26:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qQkCUlHSeSutqpYYYEuSpgaq1CGRr1gMxP5zgQMXFLE=;
        b=Wq+obXxqJ9znep3ys52HEXDRa6pIXxgvGSmGG/a/Rbt+m/OqOaTsd36lI/jJwWickN
         EiTSe2xFQyhIuJYESExZg+K6a1yli7B+RauIVWvatU81dv7PbkXL2DPuHChAIVKEe0ZO
         UEM4WvdTSGufNlTmCMfNlVQtxWYyK8oZNFsO6ajMp25aAe6QfxUcMLGOgUdp2GYtcbCD
         BYC21o8itI+MjFUthDEHwxm7oKg9onLm7XxJwNa9205U2EiApWIJ5v9ioPmp6vF1FpHI
         95DHEbh9GWzM9PkOznPq+tOVfGl7eTwZO8s1zAR/smnWIf05UZjxWCDLokkY9VTlN8S0
         Hj2g==
X-Gm-Message-State: APjAAAWmY9f2+dSBL0q6dsDJ6oShPbHjHy/Fcp1y7/o1l2iKbq/bUjQ1
        eST/082WKWO/mCrV2BYueg==
X-Google-Smtp-Source: APXvYqwFJVk0FJAugT05thhhxD8ynpQt6Xxwj2dYD7xIOhRcGHbVx5Pc86KH1o6GE7zkGGtDMoAw+w==
X-Received: by 2002:a05:6830:1116:: with SMTP id w22mr16929063otq.63.1580221607750;
        Tue, 28 Jan 2020 06:26:47 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f37sm5770746otb.33.2020.01.28.06.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 06:26:46 -0800 (PST)
Received: (nullmailer pid 18064 invoked by uid 1000);
        Tue, 28 Jan 2020 14:26:46 -0000
Date:   Tue, 28 Jan 2020 08:26:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de, ulf.hansson@linaro.org,
        chzigotzky@xenosoft.de, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] of: Add OF_DMA_DEFAULT_COHERENT & select it on powerpc
Message-ID: <20200128142646.GA17341@bogus>
References: <20200126115247.13402-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200126115247.13402-1-mpe@ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jan 2020 22:52:47 +1100, Michael Ellerman wrote:
> There's an OF helper called of_dma_is_coherent(), which checks if a
> device has a "dma-coherent" property to see if the device is coherent
> for DMA.
> 
> But on some platforms devices are coherent by default, and on some
> platforms it's not possible to update existing device trees to add the
> "dma-coherent" property.
> 
> So add a Kconfig symbol to allow arch code to tell
> of_dma_is_coherent() that devices are coherent by default, regardless
> of the presence of the property.
> 
> Select that symbol on powerpc when NOT_COHERENT_CACHE is not set, ie.
> when the system has a coherent cache.
> 
> Fixes: 92ea637edea3 ("of: introduce of_dma_is_coherent() helper")
> Cc: stable@vger.kernel.org # v3.16+
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/Kconfig | 1 +
>  drivers/of/Kconfig   | 4 ++++
>  drivers/of/address.c | 6 +++++-
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 

Applied, thanks.

Rob
