Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D604E2A8B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 08:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437811AbfJXGuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 02:50:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437772AbfJXGuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 02:50:09 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 277AF20856;
        Thu, 24 Oct 2019 06:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571899808;
        bh=vwDg4QSnLPpz0IdyymC3+iUBe78FE7J5ogjvzY1gXeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d2OqChICAciMS2Otm1pRPt3j2bUApcX3Wd4AGCQdAHdYPsDJf6mDvkzJ18Yt5pl6g
         Hh3htj5C1ye5pjj++MCDdViPGeVj+ZGLbM186VaDZ4vGMIkN7nhePLxgARH+Q/y5Uk
         ppyycWTlrYS7dVW/cyv98/FuxuKmGhSSo5wCM0us=
Date:   Thu, 24 Oct 2019 08:50:05 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mark.rutland@arm.com, robh+dt@kernel.org, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 2/4] dt-bindings: crypto: Add DT bindings
 documentation for sun8i-ss Security System
Message-ID: <20191024065005.hdypdl2dgqsrry5i@gilmour>
References: <20191023201016.26195-1-clabbe.montjoie@gmail.com>
 <20191023201016.26195-3-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023201016.26195-3-clabbe.montjoie@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 23, 2019 at 10:10:14PM +0200, Corentin Labbe wrote:
> This patch adds documentation for Device-Tree bindings of the
> Security System cryptographic offloader driver.
>
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  .../bindings/crypto/allwinner,sun8i-ss.yaml   | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/crypto/allwinner,sun8i-ss.yaml
>
> diff --git a/Documentation/devicetree/bindings/crypto/allwinner,sun8i-ss.yaml b/Documentation/devicetree/bindings/crypto/allwinner,sun8i-ss.yaml
> new file mode 100644
> index 000000000000..99b7736975bc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/allwinner,sun8i-ss.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/crypto/allwinner,sun8i-ss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner Security System v2 driver
> +
> +maintainers:
> +  - Corentin Labbe <corentin.labbe@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - allwinner,sun8i-a83t-crypto
> +      - allwinner,sun9i-a80-crypto
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Bus clock
> +      - description: Module clock
> +
> +  clock-names:
> +    items:
> +      - const: bus
> +      - const: mod
> +
> +  resets:
> +    maxItems: 1

The A83t at least has a reset line, so please make a condition to have
it required.

> +  reset-names:
> +    const: bus

You don't need reset-names at all in that binding.

Maxime
