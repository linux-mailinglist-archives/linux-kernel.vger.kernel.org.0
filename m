Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEAD511A734
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 10:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbfLKJd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 04:33:56 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:53828 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbfLKJdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 04:33:55 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ieyNF-0008KJ-G0; Wed, 11 Dec 2019 17:33:37 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ieyN8-0000Aw-DU; Wed, 11 Dec 2019 17:33:30 +0800
Date:   Wed, 11 Dec 2019 17:33:30 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stephen Brennan <stephen@brennan.io>
Cc:     Matt Mackall <mpm@selenic.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] Raspberry Pi 4 HWRNG Support
Message-ID: <20191211093330.h5qz4oyll3jsuqot@gondor.apana.org.au>
References: <20191119061407.69911-1-stephen@brennan.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119061407.69911-1-stephen@brennan.io>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 10:14:04PM -0800, Stephen Brennan wrote:
> This patch series enables support for the HWRNG included on the Raspberry
> Pi 4.  It is simply a rebase of Stefan's branch [1]. I went ahead and
> tested this out on a Pi 4.  Prior to this patch series, attempting to use
> the hwrng gives:
> 
>     $ head -c 2 /dev/hwrng
>     head: /dev/hwrng: Input/output error
> 
> After this series, the same command gives two random bytes.
> 
> Changes in v2:
> - specify the correct size for the region in the dts, refactor bcm283x rng
> 
> ---
> 
> Stefan Wahren (2):
>   dt-bindings: rng: add BCM2711 RNG compatible
>   hwrng: iproc-rng200: Add support for BCM2711
> 
> Stephen Brennan (1):
>   ARM: dts: bcm2711: Enable HWRNG support
> 
>  .../devicetree/bindings/rng/brcm,iproc-rng200.txt     |  1 +
>  arch/arm/boot/dts/bcm2711.dtsi                        |  6 +++---
>  arch/arm/boot/dts/bcm2835.dtsi                        |  1 +
>  arch/arm/boot/dts/bcm2836.dtsi                        |  1 +
>  arch/arm/boot/dts/bcm2837.dtsi                        |  1 +
>  arch/arm/boot/dts/bcm283x-common.dtsi                 | 11 +++++++++++
>  arch/arm/boot/dts/bcm283x.dtsi                        |  6 ------
>  drivers/char/hw_random/Kconfig                        |  2 +-
>  drivers/char/hw_random/iproc-rng200.c                 |  1 +
>  9 files changed, 20 insertions(+), 10 deletions(-)
>  create mode 100644 arch/arm/boot/dts/bcm283x-common.dtsi

Patches 1-2 applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
