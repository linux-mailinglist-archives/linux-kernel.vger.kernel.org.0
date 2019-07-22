Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A34870690
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 19:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbfGVRNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 13:13:23 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39596 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729058AbfGVRNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:13:22 -0400
Received: by mail-io1-f68.google.com with SMTP id f4so75601966ioh.6;
        Mon, 22 Jul 2019 10:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L1CKsuR2Aj6lAs8InXlYaMJ2CXlS4I/JR7pcZ0ogj/k=;
        b=DtBaP12bgZx7Z45wIFqDsp8GqL5rca6uhtNXL09n96aFdx3jRspwc0Md9HHTuH1XqA
         3TgPaGT46PvzhMrJmq+r803W0CkaX7BbVMRUhug1mA5yyGi3KCf1f7QcThGgfGeT4ABz
         PVb51QG4+3uphQr8lXjX4zLoA4UVcrTevcZR1bjaCTDripmMl8dvZV9mzq0nd36kGsox
         KcfIxIqU/59eTYqmDuYzpBucyRId9dVnNXNYrXVOXQ/7yB6IByozghDPugVD5HzJnTBh
         flDJ7lZ5UbvblIVEn8sqpPdZi0k4OXfoCZ94WUTtPu4TXaykXHLa1gFy3QT6aPf4dgMg
         0SeA==
X-Gm-Message-State: APjAAAWk8u2lP2JlO5UBG/dEILqGe0rtbpy1EORAFHCxe5avv0oqgz/Q
        q08yxEfJInEq630aIyX2wQ==
X-Google-Smtp-Source: APXvYqy72Ozo+5lEKdgPd0TnUyVwMIgJagxKRXz4L0gqBlISYHh886+zOO3SwVbKeK4f70AEfGNBcQ==
X-Received: by 2002:a6b:7b01:: with SMTP id l1mr62468845iop.60.1563815601759;
        Mon, 22 Jul 2019 10:13:21 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id n17sm32851341iog.63.2019.07.22.10.13.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 10:13:21 -0700 (PDT)
Date:   Mon, 22 Jul 2019 11:13:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Crystal Guo <Crystal.Guo@mediatek.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH v4 2/3] dt-bindings: rng: add bindings for MediaTek ARMv8
 SoCs
Message-ID: <20190722171320.GA9806@bogus>
References: <1561361052-13072-1-git-send-email-neal.liu@mediatek.com>
 <1561361052-13072-3-git-send-email-neal.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561361052-13072-3-git-send-email-neal.liu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 03:24:11PM +0800, Neal Liu wrote:
> Document the binding used by the MediaTek ARMv8 SoCs random
> number generator with TrustZone enabled.
> 
> Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> ---
>  .../devicetree/bindings/rng/mtk-sec-rng.txt        |   10 ++++++++++
>  1 file changed, 10 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rng/mtk-sec-rng.txt
> 
> diff --git a/Documentation/devicetree/bindings/rng/mtk-sec-rng.txt b/Documentation/devicetree/bindings/rng/mtk-sec-rng.txt
> new file mode 100644
> index 0000000..c04ce15
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rng/mtk-sec-rng.txt
> @@ -0,0 +1,10 @@
> +MediaTek random number generator with TrustZone enabled
> +
> +Required properties:
> +- compatible : Should be "mediatek,mtk-sec-rng"

What's the interface to access this? 

A node with a 'compatible' and nothing else is a sign of something that 
a parent device should instantiate and doesn't need to be in DT. IOW, 
what do complete bindings for firmware functions look like?

> +
> +Example:
> +
> +hwrng: hwrng {
> +	compatible = "mediatek,mtk-sec-rng";
> +}
> -- 
> 1.7.9.5
> 
