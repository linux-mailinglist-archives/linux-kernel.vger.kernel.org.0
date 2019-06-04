Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBDE352C6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 00:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfFDWhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 18:37:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35197 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfFDWhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 18:37:03 -0400
Received: by mail-pg1-f194.google.com with SMTP id s27so5580563pgl.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 15:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q3LYolv9HS8m3O9LEPPo+AYNjPUFnZ39lcs8VPIoY7Y=;
        b=rB6ebIAvraBr3OkVvfCrDmvlEKBZzTdiegPVzW+a9Mp/EQswhhTU6Fke3ruVWDYx4S
         UpJS8sapWXy50/ISJ4Xr9DyiQGrIgHPoP/ir/U7XQEKbJrpmSAKES9u15fms3X9Nwepo
         abRM00W1dy0ncnCbHsztuaGXBoBHHmEHVNx0RcpgS4i6/1m/1Tf4tEsPxPNphrkinks0
         UFjA341cRsyEdx6HxcVXe3vnf4YVnY06xJPFrGGdHm2yxQh+TCUfEePfUYkeH/D5tDxp
         WyxqLUmZSP/UpKPaeZypRh9nI0UKMt1uB+AB3XVc3HOogo042WGitH/d/+LxSKqwyUK3
         S8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q3LYolv9HS8m3O9LEPPo+AYNjPUFnZ39lcs8VPIoY7Y=;
        b=tNmjFFm5OfHYMaT7KXZLkVs4inYsrMSeh1s+EDhz4gB+Jc1u58sjxojjkubGNNaGfG
         vqQnemT3/IFeTW6ofoDjFBMXmYpsi/HWoI0U5NANVGClCzLGuHFWpWhT/o1Eo+9CYUHi
         ubMAU+iFTjIZ+U0XrQMrx3vbeepCp+GRgyanRsYrgPWBefguwi/yMfj4oT1njAfSOPe+
         ATqtoGYVhzzHt3/RQkb2KB0Pn/PIgoB6I/OwVL9pR/kEZHrEfAgDtUTwliAgUs5Ij9rc
         wWSsnob8wlviLdt0DUXANF+r07QhWF/rDVcV/vV5p9Czh8aZvCFrHI9tbmkHsKJnT7cR
         QoFQ==
X-Gm-Message-State: APjAAAUN4sLSZF5nbgKrqHM4KspwYZoLTY8o29CkJpV3l9KMFXlIpfLN
        wT5QAguQJJ3Iwg1wmY+L/27/SQ==
X-Google-Smtp-Source: APXvYqyBR8kVfo5UG11Mff9yGDhpHlpTueoxyePcbFTPSVifGJSFF+exudIdxNVt5jQnwyblXLDmlA==
X-Received: by 2002:a63:1c59:: with SMTP id c25mr182601pgm.395.1559687822780;
        Tue, 04 Jun 2019 15:37:02 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h15sm471630pfr.44.2019.06.04.15.37.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Jun 2019 15:37:02 -0700 (PDT)
Date:   Tue, 4 Jun 2019 15:37:00 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH] arm64: dts: sdm845: Add iommus property to qup1
Message-ID: <20190604223700.GE4814@minitux>
References: <20190604222939.195471-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604222939.195471-1-swboyd@chromium.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04 Jun 15:29 PDT 2019, Stephen Boyd wrote:

> The SMMU that sits in front of the QUP needs to be programmed properly
> so that the i2c geni driver can allocate DMA descriptors. Failure to do
> this leads to faults when using devices such as an i2c touchscreen where
> the transaction is larger than 32 bytes and we use a DMA buffer.
> 

I'm pretty sure I've run into this problem, but before we marked the
smmu bypass_disable and as such didn't get the fault, thanks.

>  arm-smmu 15000000.iommu: Unexpected global fault, this could be serious
>  arm-smmu 15000000.iommu:         GFSR 0x00000002, GFSYNR0 0x00000002, GFSYNR1 0x000006c0, GFSYNR2 0x00000000
> 
> Add the right SID and mask so this works.
> 
> Cc: Sibi Sankar <sibis@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index fcb93300ca62..2e57e861e17c 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -900,6 +900,7 @@
>  			#address-cells = <2>;
>  			#size-cells = <2>;
>  			ranges;
> +			iommus = <&apps_smmu 0x6c0 0x3>;

According to the docs this stream belongs to TZ, the HLOS stream should
be 0x6c3.

Regards,
Bjorn

>  			status = "disabled";
>  
>  			i2c8: i2c@a80000 {
> -- 
> Sent by a computer through tubes
> 
