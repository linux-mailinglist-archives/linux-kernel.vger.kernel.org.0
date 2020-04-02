Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97E1819BD5D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 10:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387667AbgDBINw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 04:13:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbgDBINw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:13:52 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD42F2078B;
        Thu,  2 Apr 2020 08:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585815232;
        bh=MfvQQkIj2OFoUDYO9jUXwG7FM99uzokTU3uHkH5wg0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lq/LJrlM2qvKHHPYYTWR7RsC++8+oesBipjopjmq3dFbpRSnuBHDI9xa8/9afO/s1
         GhDRHhUSi7sdxX9Ps1865zTSvyjC/n+k1bjKPrVBosVPvvP/Fg/jToNU2O/XicfKJH
         /iEcLGvV4zdP4OlFXxZOt0Y4+V/NH4W7D6Ki5VZc=
Date:   Thu, 2 Apr 2020 09:13:47 +0100
From:   Will Deacon <will@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, hsinyi@chromium.org,
        geert+renesas@glider.be, swboyd@chromium.org, robh@kernel.org,
        tytso@mit.edu
Subject: Re: [PATCH] Documentation: dt-bindings: Document 'rng-seed' for
 /chosen
Message-ID: <20200402081346.GA2548@willie-the-truck>
References: <20200402033640.12465-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402033640.12465-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Wed, Apr 01, 2020 at 08:36:40PM -0700, Florian Fainelli wrote:
> The /chosen node can have a 'rng-seed' property read as a u32 quantity
> which would contain a random number provided by the boot agent. This is
> useful in configurations where the kernel does not have access to a
> random number generator.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  Documentation/devicetree/bindings/chosen.txt | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Thanks for doing this; I realised it was undocumented the other day when I
tried to look it up myself.

> diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
> index 45e79172a646..126b31eecfeb 100644
> --- a/Documentation/devicetree/bindings/chosen.txt
> +++ b/Documentation/devicetree/bindings/chosen.txt
> @@ -28,6 +28,19 @@ mode) when EFI_RNG_PROTOCOL is supported, it will be overwritten by
>  the Linux EFI stub (which will populate the property itself, using
>  EFI_RNG_PROTOCOL).
>  
> +rng-seed
> +--------
> +
> +This property is used to initialize the kernel's entropy pool from a
> +trusted boot agent capable of providing a random number. It is parsed
> +as a u32 value, e.g.

Are you sure about this being limited to a u32 value? I thought you could
pass an arbitrary-length value here.

Will
