Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9501832A36
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 10:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfFCIAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 04:00:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51956 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfFCIAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:00:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id f10so10080722wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 01:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=S5cWpjCtWP6cEwCb4PLedIGxhmVpA+oBg2HMGf8+esM=;
        b=GGSqkCE8VrBwFRdievnVdY9WcCEc5q61VPbovitryaz2nJE2PFCKQxmFXd+9SRXlRY
         rFW37LGw9eQZC2sb43EvX2MIz08D/i5aBTwly+YxPi9oD2JDJ7Tj7G5S66ONTsPSpNMz
         RDPgsVU0qJwzX9RAOhW8bPCOitT2I14975Wi1ZD83vKJbz3wRS9QhRkTAjpdjf4Rlf3Q
         MwWqzTUMVbQT3l6UDdziTydLrXC/iCDnvRQB714w/16wEYt/YkZ24D92XjCAMZ/u7NYD
         pkLMGowgKpRtLity/kSp+IVy4lLKksSRzb2DdcCTes2IqZ7jlL1kYXk0W7ZwZsAWcJLX
         MQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=S5cWpjCtWP6cEwCb4PLedIGxhmVpA+oBg2HMGf8+esM=;
        b=anCIR+NOzB65jcHLF8bi+wbhXyCid5emZkPHO5ViV90OHGsQPob00RUksXEfIbkpPu
         hsbIbTs2pGxdyOsmKMLgmRmuyPa6pFp9Os/BFRYHxxR3gR0vCzdyVkQiSQ+yKxWu2IDm
         VCGUAZ2zapaJKVBJ3O08JJUPl7dzgNR5FHUi18G10S/RW3E19K8F96L/Bc4mLSHPaHVN
         VZTiDgoKBykAZxP6AnTmXWMBTvR+41/gr41ieL3KmuWKGrnoO2uhsEMej9j2fAszK4ff
         kGQV5PbuKuPyW7CGGsC16zZFipXoo+Wiruf+M+JtfBmg49wxhVmmV/tOwZ7b9PxpBQMJ
         2Zmw==
X-Gm-Message-State: APjAAAXRzQUIpJ8FeM9aZ0xzbkynnwsXCa7mR96MuB2MoJa0g0zQee35
        uGO3U7JONQ1efWHUdTy61ipf1Q==
X-Google-Smtp-Source: APXvYqyTO3DC1woO81zp4cGlWYvtMXURLSdDWgNtBMOrhf4T74MPm+NUUV5RQdYEK3BX2mUkV3JAJQ==
X-Received: by 2002:a1c:7ec8:: with SMTP id z191mr1251839wmc.66.1559548832228;
        Mon, 03 Jun 2019 01:00:32 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id g5sm16275111wrp.29.2019.06.03.01.00.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 01:00:30 -0700 (PDT)
Date:   Mon, 3 Jun 2019 09:00:29 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-kernel@vger.kernel.org, Daniel Schultz <d.schultz@phytec.de>,
        stable@vger.kernel.org, Elaine Zhang <zhangqing@rock-chips.com>,
        Joseph Chen <chenjh@rock-chips.com>
Subject: Re: [PATCH RESEND] mfd: rk808: Fix RK818 ID template
Message-ID: <20190603080029.GF4797@dell>
References: <20190513082943.31750-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190513082943.31750-1-heiko@sntech.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2019, Heiko Stuebner wrote:

> From: Daniel Schultz <d.schultz@phytec.de>
> 
> The Rockchip PMIC driver can automatically detect connected component
> versions by reading the ID_MSB and ID_LSB registers. The probe function
> will always fail with RK818 PMICs because the ID_MSK is 0xFFF0 and the
> RK818 template ID is 0x8181.
> 
> This patch changes this value to 0x8180.
> 
> Fixes: 9d6105e19f61 ("mfd: rk808: Fix up the chip id get failed")
> Cc: stable@vger.kernel.org
> Cc: Elaine Zhang <zhangqing@rock-chips.com>
> Cc: Joseph Chen <chenjh@rock-chips.com>
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> [added Fixes and cc-stable]
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> The original patch from Feburary 2018 got an Ack but never reached
> the mfd-tree, so I ran into that problem this weekend as well.
> So it would be really cool if this could be applied as fix :-) .
> 
>  include/linux/mfd/rk808.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
