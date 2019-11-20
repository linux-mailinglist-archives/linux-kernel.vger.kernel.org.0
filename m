Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09B791031A4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 03:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfKTCfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 21:35:33 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46034 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbfKTCfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 21:35:33 -0500
Received: by mail-pg1-f196.google.com with SMTP id k1so11234857pgg.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 18:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=demOKi0KmBJXgMXKUxgMCHYSTMZ41kb+ilF6SbHTJuQ=;
        b=XNMurbf0t4fehDU7BCwNIN75pA9gnfvEnIOOhcJ5UqJIhzvwZeakrQZ1XXip+zT4at
         GBT+W4v1j3sDr3tJPcTiS1/hLFnUpZ50rfrQXwxJkffTxT/gQ9wLnM22zpocxJK/hKsX
         TYTK3QWC3EpoJOOnuW4ql0gnrFj9cQDJKc3Rso9azUgcz9fMwxklo7lgvu0i18cIyrLY
         k7RzKIxb5Dc5giyHIk9H1qcWzu8WRZ6gfdRN+DravYT2B34tI3MUTdWeWLzUZsIr7TvU
         YbqlqId3Hsle8dVB9bkf4Rlie3WpHHxskTFmEGDbJyRkATTPSkzemXaKyKTU+cWardh7
         7hBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=demOKi0KmBJXgMXKUxgMCHYSTMZ41kb+ilF6SbHTJuQ=;
        b=iJ8xVmY4t6CseMaWoc3U0UOTd9tZneVz/sDWK4hp0rF5+/rg3tu2EbeCkYGoM/cgmy
         uGntoLUFwYg0JF4+j8sjoJ39iO0AnMSGbiMNLGWAl8UaMMwb0Z5xPGWGq6+GtGXs/3Ck
         lmh2ddLYlKbSxMB4dqBc8J9K3XI7cV4xN6fpdeI4ThwXaCpFbUwc5fEdOQKWf0LhsjrI
         d4et1X+AVH6ROm3Pv5tNSilQ2BhG5dB9N38coQYVwGvL+LfV0oJltpiws4hOoe6oQD+Y
         UJqia3lDwh1pTJxd40R2fo/8V+5E2xxcmnuaTwkSbG1T7RsnGxmmTh6GJ1L6ZwaZx0JI
         5OSg==
X-Gm-Message-State: APjAAAWWtFI+dAhm1xAu614RD4Hv2UmbJSHSSmE2b7sXEHtJWpG1RtkB
        FtyYTX7us9kQWmF0nfn6HkBD5g==
X-Google-Smtp-Source: APXvYqzplDwcuPhXEeFBVafJ6hd/Ct5IVvHGuZjFEf55wyIRINqbwLDg4aZ7LcJedX3pxFtStlJYNA==
X-Received: by 2002:a65:47c1:: with SMTP id f1mr376719pgs.393.1574217330662;
        Tue, 19 Nov 2019 18:35:30 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d6sm26533702pfn.32.2019.11.19.18.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 18:35:30 -0800 (PST)
Date:   Tue, 19 Nov 2019 18:35:27 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     robh+dt@kernel.org, ulf.hansson@linaro.org, rnayak@codeaurora.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        mark.rutland@arm.com, swboyd@chromium.org, dianders@chromium.org
Subject: Re: [PATCH 6/6] arm64: dts: sm8150: Add rpmh power-domain node
Message-ID: <20191120023527.GO18024@yoga>
References: <20191118173944.27043-1-sibis@codeaurora.org>
 <0101016e7f99efe5-cee866e3-7031-4ecf-a8a6-4b247e9e69ff-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0101016e7f99efe5-cee866e3-7031-4ecf-a8a6-4b247e9e69ff-000000@us-west-2.amazonses.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18 Nov 09:40 PST 2019, Sibi Sankar wrote:

> Add the DT node for the rpmhpd power controller.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 55 ++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 8f23fcadecb89..0ac257637c2af 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -5,6 +5,7 @@
>   */
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  
> @@ -469,6 +470,60 @@
>  				clock-names = "xo";
>  				clocks = <&xo_board>;
>  			};
> +
> +			rpmhpd: power-controller {
> +				compatible = "qcom,sm8150-rpmhpd";
> +				#power-domain-cells = <1>;
> +				operating-points-v2 = <&rpmhpd_opp_table>;
> +
> +				rpmhpd_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					rpmhpd_opp_ret: opp1 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_RETENTION>;
> +					};
> +
> +					rpmhpd_opp_min_svs: opp2 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
> +					};
> +
> +					rpmhpd_opp_low_svs: opp3 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +					};
> +
> +					rpmhpd_opp_svs: opp4 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
> +					};
> +
> +					rpmhpd_opp_svs_l1: opp5 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
> +					};
> +
> +					rpmhpd_opp_svs_l2: opp6 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
> +					};
> +
> +					rpmhpd_opp_nom: opp7 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
> +					};
> +
> +					rpmhpd_opp_nom_l1: opp8 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
> +					};
> +
> +					rpmhpd_opp_nom_l2: opp9 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L2>;
> +					};
> +
> +					rpmhpd_opp_turbo: opp10 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
> +					};
> +
> +					rpmhpd_opp_turbo_l1: opp11 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
> +					};
> +				};
> +			};
>  		};
>  	};
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
