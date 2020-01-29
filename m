Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8F1A14C462
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 02:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgA2BYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 20:24:15 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46731 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgA2BYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 20:24:14 -0500
Received: by mail-pg1-f193.google.com with SMTP id z124so7941059pgb.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 17:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ABEaCl8eghaB63SlspLn6OWSOfbEB+69FRLfk57jKew=;
        b=EJlH9jGdkWKVSguyJVfmQBTJ5NeJpIP3u1q/DrM1f/oEIt8AqWPPhQFYdTidDimERP
         R4xlzFe4jg5q7RZqboH+BnQhCBYfPcTPKolCBnW00OrziW8SAqc/gqALlAiZmo//9mgW
         H9EnTD9jr3RcBl1lE93i7D6NITgAq6mqcbEXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ABEaCl8eghaB63SlspLn6OWSOfbEB+69FRLfk57jKew=;
        b=Oj3neD1f2TJBj8zyhttHukGdwdLNEzWqu+++5+5viwHUff6Q14NVm1whawCRTYTHiH
         /QoSRIFcaKaz/4a84+P0J+V/XlybkaQ+gsfbspTxR0d7pluEaQkenwZLhoUrmU6Xm+Be
         v3/NYGgaZnI2ZCvXOlgC/MY48x6FJWiSe+CXObhegiuNVDz5FH9aWtEoGVBo6t74Hub8
         uKRzeJB/liqe3I+/rvZqKvPwsiwfTk4CPIrr8oEyQge4qnVoJjnZyoVMwZvAGICxH+wU
         09ONoKxXD9FurLNurhwlo37qDkdcMS+4Gb+b++V5u14UpmE88O5Ajk5+G6qDMK5aZJl8
         58lw==
X-Gm-Message-State: APjAAAXlCxezLcc3Cszk9MsTebj3EFbKp9JFxTxcEPCui2JtVCY3oDfR
        1k/h44jvQtM9zyo+8RNF/8gTVA==
X-Google-Smtp-Source: APXvYqy0fsqJgkgNmjAYKqDfm+xayl+seLu9bJsiaQkshHwfjny7qJQa0p/fg20lUSyxfvS//wUEcw==
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr27309683pgh.96.1580261053832;
        Tue, 28 Jan 2020 17:24:13 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id a10sm289964pgm.81.2020.01.28.17.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 17:24:13 -0800 (PST)
Date:   Tue, 28 Jan 2020 17:24:11 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com, nm@ti.com,
        bjorn.andersson@linaro.org, agross@kernel.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        ulf.hansson@linaro.org
Subject: Re: [RFC v3 09/10] arm64: dts: qcom: sdm845: Add cpu OPP tables
Message-ID: <20200129012411.GI46072@google.com>
References: <20200127200350.24465-1-sibis@codeaurora.org>
 <20200127200350.24465-10-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200127200350.24465-10-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sibi,

On Tue, Jan 28, 2020 at 01:33:49AM +0530, Sibi Sankar wrote:
> Add OPP tables required to scale DDR/L3 per freq-domain on SDM845 SoCs.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 453 +++++++++++++++++++++++++++
>  1 file changed, 453 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index c036bab49fc03..8cb976118407b 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -199,6 +199,12 @@
>  			qcom,freq-domain = <&cpufreq_hw 0>;
>  			#cooling-cells = <2>;
>  			next-level-cache = <&L2_0>;
> +			operating-points-v2 = <&cpu0_opp_table>,
> +					      <&cpu0_ddr_bw_opp_table>,
> +					      <&cpu0_l3_bw_opp_table>;
> +			interconnects = <&gladiator_noc MASTER_APPSS_PROC &mem_noc SLAVE_EBI1>,
> +					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;

This apparently depends on the 'Split SDM845 interconnect nodes and
consolidate RPMh support' series
(https://patchwork.kernel.org/project/linux-arm-msm/list/?series=226281),
which isn't mentioned in the cover letter.

I also couldn't find a patch on the lists that adds the 'osm_l3'
interconnect node for SDM845. The same is true for SC7180 (next
patch of this series). These patches may be available in custom trees,
but that isn't really helpful for upstream review.

I would suggest to focus on landing the dependencies of this series,
before proceding with it (or at least most of them), there are plenty
and without the dependencies this series isn't going to land, it also
makes it hard for testers and reviewers to get all the pieces
together. In particular the last post of the series 'Add
required-opps support to devfreq passive gov'
(https://patchwork.kernel.org/cover/11055499/) is from July 2019 ...

Thanks

Matthias
