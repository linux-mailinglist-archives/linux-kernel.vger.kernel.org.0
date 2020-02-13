Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 377C615BC94
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 11:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbgBMKRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 05:17:51 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35656 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbgBMKRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 05:17:51 -0500
Received: by mail-ed1-f65.google.com with SMTP id f8so6160652edv.2;
        Thu, 13 Feb 2020 02:17:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RRIEPdo2GBfjmyVoBn6+vY/7+N02sDl5h1yeWIDZHL4=;
        b=fE25IgnWH4kDnTlwGuqsrZtGTaN/VV/ZsLaOw5OmU1gQnN1vs826Vk9rkTMNPNv0lE
         acjCiaoGZNhOun5ELMnCsKPE7dKtbHAIh4pnrLdRRrjBnfm8/uRyuRrzrvXmGq5Ownvs
         dWR1eg4PoG7mCYv5rzatii2WqnBckT45J7bYbLXajTvwrkkHWTsitwXp+pzuMa2WsbbH
         FuWzQnBOpXarn+xn4I/5TyKY6CJLlwTnsvSmXqcP5oA0L3UtbNRXEkLCZ80pHX/yh/QE
         KsbuzpNc+hatvcAyX0I8k8ghOXhxm9UIsuGa7lFLQq3XFKWCFz89zPX7o8jOdiHdGrHH
         ovGQ==
X-Gm-Message-State: APjAAAXEqSAuWstI4x6zz1V6a/tmD9AceNmmJsPOD5AJy0Ydc+8WzSMi
        F0mulTklYNG8LUje1IfbVtk=
X-Google-Smtp-Source: APXvYqzJPEBHGEKtNpeIz/sbcpHCr12wSxQrNRMVB1G8sc2hvXl2J7zmFFF7vRMRvXQXSbI6JC33dg==
X-Received: by 2002:a05:6402:1426:: with SMTP id c6mr7748047edx.49.1581589068803;
        Thu, 13 Feb 2020 02:17:48 -0800 (PST)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id k11sm158564edr.38.2020.02.13.02.17.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Feb 2020 02:17:48 -0800 (PST)
Date:   Thu, 13 Feb 2020 11:17:44 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCHv1 0/2] Add FSYS2 power domain for MMC driver
Message-ID: <20200213101744.GA11087@kozik-lap>
References: <20200212120237.1332-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200212120237.1332-1-linux.amoon@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 12:02:35PM +0000, Anand Moon wrote:
> This patches add the power domain for MMC driver,
> but somehow the suspend/resume feature is broken
> so any input on how to fix this.

I think S2R was working on XU3-family after Marek's fixes, so you mean
that these patches break it?

Best regards,
Krzysztof


> 
> Also on similar lines I tried to add power domain
> FSYS for usb3 and usb2 nodes but this time
> it failed to load the kernel, so how can I reslove
> this issue.
> 
> -Anand
> 
> Anand Moon (2):
>   ARM: dts: exynos: Add FSYS2 power domain to Exynos542x
>   clk: samsung: exynos542x: Move FSYS2 subsystem clocks to its sub-CMU
> 
>  arch/arm/boot/dts/exynos5420.dtsi    | 10 ++++++++++
>  drivers/clk/samsung/clk-exynos5420.c | 24 +++++++++++++++++++++---
>  2 files changed, 31 insertions(+), 3 deletions(-)
> 
> -- 
> 2.25.0
> 
