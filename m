Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2A8183931
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 20:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgCLTF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 15:05:56 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44602 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLTF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 15:05:56 -0400
Received: by mail-ot1-f67.google.com with SMTP id a49so4697207otc.11;
        Thu, 12 Mar 2020 12:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MobSju737te+JzYsenr0FH2yt0dGhamzIqGShRXIww0=;
        b=AN8NcpbEBvo+d2HsEpIGadGY7HPChwo/Fgm7g1iD/ijc50XOUuPQq2SbJEriRWqxfJ
         NjzgXPr86FEGMv76wqLsFsTt1cKBeTr3q2Lkdy/+9CKW9THNZKqy6Q+is7OpBH6emkEL
         /WGJ3xn3rZo5mWB6ICQgq9tdNx84RxomDKRoYzQZmPzYoS0gdBJ2qFTmJ9YUaE1Rw3Ot
         JCfaBwaPTOU7B0tHZwep3PEWUkIB1iDx0Ei0R/8eOElD2pbd1KAoa6JOPBW/CrqFSv2/
         9s95gzPUh5/fqGs2AWvFDZljkN6EePI9ldjTQBCra1xkjie5JKdXW+jJlWprD/bXP0id
         cWhg==
X-Gm-Message-State: ANhLgQ18QjUlnz8wreTwNgVKio9O7rGgnZwAuZwvlyLcS9+sCrQSujyi
        SLCziJUYimgzju8O7KhNUg==
X-Google-Smtp-Source: ADFU+vtq2J5SulXMF97WnPUs+sTCKOEXlKI1n5cCcASwRTD3mYvpkHVbjij/yfwU4dUaGCxhLoVyiQ==
X-Received: by 2002:a9d:19c8:: with SMTP id k66mr7205481otk.43.1584039954027;
        Thu, 12 Mar 2020 12:05:54 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t21sm15631904otk.13.2020.03.12.12.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 12:05:53 -0700 (PDT)
Received: (nullmailer pid 31500 invoked by uid 1000);
        Thu, 12 Mar 2020 19:05:52 -0000
Date:   Thu, 12 Mar 2020 14:05:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eason Yen <eason.yen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>, jiaxin.yu@mediatek.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH 1/2] ASoC: mediatek: mt6359: add codec document
Message-ID: <20200312190552.GA27630@bogus>
References: <1583465622-16628-1-git-send-email-eason.yen@mediatek.com>
 <1583465622-16628-2-git-send-email-eason.yen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583465622-16628-2-git-send-email-eason.yen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 11:33:41AM +0800, Eason Yen wrote:
> Add mt6359 codec document
> 
> Signed-off-by: Eason Yen <eason.yen@mediatek.com>
> ---
>  Documentation/devicetree/bindings/sound/mt6359.txt | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mt6359.txt

Please convert to a DT schema.

> 
> diff --git a/Documentation/devicetree/bindings/sound/mt6359.txt b/Documentation/devicetree/bindings/sound/mt6359.txt
> new file mode 100644
> index 0000000..77864e0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mt6359.txt
> @@ -0,0 +1,16 @@
> +Mediatek MT6359 Audio Codec
> +
> +The communication between MT6358 and SoC is through Mediatek PMIC wrapper.
> +For more detail, please visit Mediatek PMIC wrapper documentation.
> +
> +Must be a child node of PMIC wrapper.
> +
> +Required properties:
> +
> +- compatible : "mediatek,mt6359-sound".

A compatible with no other properties is generally suspect. Don't you 
have clocks, connection to I2S or something, etc.

> +
> +Example:
> +
> +mt6359_snd {

audio-codec {

> +	compatible = "mediatek,mt6359-sound";
> +};
> -- 
> 1.9.1
