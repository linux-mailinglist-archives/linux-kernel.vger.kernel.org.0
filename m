Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91FE395E69
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 14:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbfHTM0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 08:26:49 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45484 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbfHTM0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:26:49 -0400
Received: by mail-lf1-f66.google.com with SMTP id a30so3956878lfk.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 05:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cT7IeyJiTuoNh11nPVW7RfDYaPiUmRbRFJCMvHnaKkk=;
        b=VJ2qr1LF8/8lxUuOMkvSCzy3yE2diI1kQWqMhWfKXBgsqwpmYP83+VaB5AGDS7YShM
         Os5GQL83opFSTSdqxq6DD9rqsVVqpcfjxXSJkumls7Z/ht9h9plldaGkhU3piyLubNZ2
         Tfv8zQRM5mnlmUJT3GjS30fNhyGgs1Dtvdcr6aywrn1jLzz52vqhZ2GwYcnNJLhEa8oC
         mZpW14WNdEe1YDh38WFDj6frJv+N4o33K9qUyODWd9GAJVXXKlsMnKUdl/0/QJKkxDSc
         uT14fMtN6TmUBn5bUCAuNzgwWG2UACVwqTkHnTLgKQVjt+j4JztMVtG7riGDLtAD5zu2
         h3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cT7IeyJiTuoNh11nPVW7RfDYaPiUmRbRFJCMvHnaKkk=;
        b=bRNizbcBUcri4DfL/G3ymxdfrLeIJ87jSf0yin3O2D+g1FXAbM2wHurG9orSwHonzX
         V/2lNvXdrb3yFuSJhaOIOux5Ak15hXCpysBtbRTOcc/KT8Ah4VR1e6XD88f0NSrwdapT
         QxD9YD4XYO/INNLrfWK/wLmdwjPKEb3sI6QOciRBnh8vRe0Kt1nyZjInXbe6o6/mcd9U
         /m62S5dnRGN1mbfEj0jdwBkd29nDTvWWOP+VTKII9zN7Rtef7AmeFKPsE86RrC+IKxRa
         uYddH3k9ZsiYxC/RTv1/jhkY41lLHMub+vQexO597vTus5z9Vqg//mJD5yb2zcgIzbEl
         fT0w==
X-Gm-Message-State: APjAAAWO+1bjcWAFiA8dbhB7YL/sePt1FekrBSRISOBVXNdOWTxK75X8
        qZuB9PdoEyx/3E3ur1ttI1N71Q==
X-Google-Smtp-Source: APXvYqyCTZaCwShY1tsqdhso1wyJIDCN2cxDM2OtJF2EFgUpiZTIK4zWdxmAALVFwOo1uIipNssKyQ==
X-Received: by 2002:a19:5218:: with SMTP id m24mr15678271lfb.164.1566304007524;
        Tue, 20 Aug 2019 05:26:47 -0700 (PDT)
Received: from centauri (ua-84-219-138-247.bbcust.telenor.se. [84.219.138.247])
        by smtp.gmail.com with ESMTPSA id c17sm2848454lfj.65.2019.08.20.05.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 05:26:47 -0700 (PDT)
Date:   Tue, 20 Aug 2019 14:26:45 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] arm64: dts: qcom: sm8150-mtp: add base dts file
Message-ID: <20190820122645.GB31261@centauri>
References: <20190820064216.8629-1-vkoul@kernel.org>
 <20190820064216.8629-6-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820064216.8629-6-vkoul@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 12:12:13PM +0530, Vinod Koul wrote:
> This add base DTS file for sm8150-mtp and enables boot to console, adds
> tlmm reserved range, resin node, volume down key and also includes pmic
> file.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile       |  1 +
>  arch/arm64/boot/dts/qcom/sm8150-mtp.dts | 48 +++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm8150-mtp.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 0a7e5dfce6f7..1964dacaf19b 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -12,5 +12,6 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r3.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-db845c.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-mtp.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-mtp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
> new file mode 100644
> index 000000000000..80b15f4f07c8
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +// Copyright (c) 2017-2019, The Linux Foundation. All rights reserved.
> +// Copyright (c) 2019, Linaro Limited
> +
> +/dts-v1/;
> +
> +#include "sm8150.dtsi"
> +#include "pm8150.dtsi"
> +#include "pm8150b.dtsi"
> +#include "pm8150l.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. SM8150 MTP";
> +	compatible = "qcom,sm8150-mtp";
> +
> +	aliases {
> +		serial0 = &uart2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&qupv3_id_1 {
> +	status = "okay";
> +};
> +
> +&pon {
> +	pwrkey {
> +		status = "okay";
> +	};
> +
> +	resin {
> +		compatible = "qcom,pm8941-resin";
> +		interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
> +		debounce = <15625>;
> +		bias-pull-up;
> +		linux,code = <KEY_VOLUMEDOWN>;
> +	};
> +};

Missing a newline here.

> +&tlmm {
> +	gpio-reserved-ranges = <0 4>, <126 4>;
> +};
> +
> +&uart2 {
> +	status = "okay";
> +};
> -- 
> 2.20.1
> 
