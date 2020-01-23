Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAF81470F3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 19:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgAWSld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 13:41:33 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33955 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbgAWSld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 13:41:33 -0500
Received: by mail-pf1-f196.google.com with SMTP id i6so1947648pfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 10:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j0uL3hKYvtloUNrrY22cT3PaCoUxzpbH8NZr/Q8o0KA=;
        b=CXNEFTP2R4F8SHBCz2/5Zzdx0sFdYTih2TDfK4G9t9F6FHZEmAQKe0jRZsvWKlCcZm
         GsCdp4VMOvYqWBylaMYFz3jK3aq5yW7KLIk9EOW1a+lhEGwwJc5UTxUJw4vSEFwE3swT
         5fpKlAPcs1LsnegZtNxXem+dbUFnvIaJ2Yw4bNrTE5ryTxqMyHEiBhBrmnGjzJulXbM4
         pU2tl6X779VkXBEvQvwcJO9VT38bD2quKReEXD+esMMg1qNlTCjuwBlnXoboXpi5UAJd
         1Sp1m/j9HlOv1HBL4587gw6zAFpwao4JsPMNwWlunVSVhcrE8gzHY1z0Q8W5h1bl5RYV
         Av7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j0uL3hKYvtloUNrrY22cT3PaCoUxzpbH8NZr/Q8o0KA=;
        b=Ju7D/dyzag6XX8VZahtFkWX6Z/C+1t/EwWN7BkKuwTWRcvbYNB2tfrTrf8+PfvKih5
         1nvILkBFj8drRk9oElEae+3QMDpHlbSP9gumyGAgArxXcYCVMygl7XdB1VrpxWEGf45Q
         0niWLgkZ2IWanNYM0ZR6/E2Y32KMBVyOVoNsdh2kLtpJMWiaMWNTWoTbEu6Y3BXfQb0M
         4g7Q8bWZwHuasIIxCKcnM+MBsvB9UPsmVFXlyj5aJcVRiw758nvQ8B24kMX8MjwKkh7I
         OMuN3DNoHTpQmc6x2IiF2n79mV4buFAuXzf02+bbTi+nNdl9NLFTtSGs/b7Ei/W24Aht
         V2Ww==
X-Gm-Message-State: APjAAAWWPB5S5Px9etK6u0xhkbbYirRfNJSuBVRh/CtjSwhHvlO2ybOj
        qMBSdb2ZDvactnZymxkdSi79TQ==
X-Google-Smtp-Source: APXvYqx+qa1v2W0iU2GnJArGqft14UWP8j2yatf2YzptCIB13C6YZQGrwUgPc9NPu/VFtVapmAU0PA==
X-Received: by 2002:a63:1807:: with SMTP id y7mr182102pgl.94.1579804892350;
        Thu, 23 Jan 2020 10:41:32 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g24sm3547441pfk.92.2020.01.23.10.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 10:41:31 -0800 (PST)
Date:   Thu, 23 Jan 2020 10:41:29 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Harigovindan P <harigovi@codeaurora.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        kalyan_t@codeaurora.org, nganji@codeaurora.org
Subject: Re: [v2] arm64: dts: sc7180: add display dt nodes
Message-ID: <20200123184129.GW1511@yoga>
References: <1579781700-7253-1-git-send-email-harigovi@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579781700-7253-1-git-send-email-harigovi@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 23 Jan 04:15 PST 2020, Harigovindan P wrote:

> Add display, DSI hardware DT nodes for sc7180.
> 
> Changes in v1:
> 	-Added display DT nodes for sc7180
> Changes in v2:
> 	-Renamed node names
> 	-Corrected code alignments
> 	-Removed extra new line

Please keep the changelist after the '---' for the dts patches.

> 
> Signed-off-by: Harigovindan P <harigovi@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts |  57 +++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7180.dtsi    | 125 ++++++++++++++++++++++++++++++++
>  2 files changed, 182 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> index 388f50a..f410614 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> @@ -232,6 +232,50 @@
>  	};
>  };
>  
> +&dsi_controller {
> +	status = "okay";
> +
> +	vdda-supply = <&vreg_l3c_1p2>;
> +
> +	panel@0 {
> +		compatible = "visionox,rm69299-1080p-display";
> +		reg = <0>;
> +
> +		vdda-supply = <&vreg_l8c_1p8>;
> +		vdd3p3-supply = <&vreg_l18a_2p8>;
> +
> +		pinctrl-names = "default", "suspend";
> +		pinctrl-0 = <&disp_pins_default>;
> +		pinctrl-1 = <&disp_pins_default>;
> +
> +		reset-gpios = <&pm6150l_gpio 3 0>;

Please replace the 0 here with GPIO_ACTIVE_HIGH

> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			port@0 {
> +				reg = <0>;
> +				panel0_in: endpoint {
> +					remote-endpoint = <&dsi0_out>;
> +				};
> +			};
> +		};
> +	};
[..]
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 3bc3f64..81c3aab 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -1184,6 +1184,131 @@
>  			#power-domain-cells = <1>;
>  		};
>  
> +		display_subsystem: mdss@ae00000 {

It was the name, not the label, that Stephen asked you to make generic.

> +			compatible = "qcom,sc7180-mdss";
> +			reg = <0 0x0ae00000 0 0x1000>;
> +			reg-names = "mdss";
> +
[..]
> +			display_controller: mdp@ae00000 {

mdp: display-controller@ae00000 {

[..]
> +			};
> +
> +			dsi_controller: qcom,mdss_dsi_ctrl0@ae94000 {

In particular you shouldn't have qcom, in the node name.

[..]
> +
> +			dsi_phy: dsi-phy0@ae94400 {

phy@ae94400

Regards,
Bjorn
