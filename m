Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2FF15AFC9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 19:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgBLSaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 13:30:12 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52970 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBLSaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 13:30:12 -0500
Received: by mail-pj1-f67.google.com with SMTP id ep11so1233595pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 10:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D2gAKKMYVUTv732gUqZOj+7ckf88ZsvW6cqPTYLGO40=;
        b=BFn0hGEVWw7yxb0YcvQ1+wm52euwa2Fwwej9sOqkWtzM20fwcdWL/NGTHSPpxP27Yb
         KyrZjkAX+FNDgA+kB0AtyLnGCh3DPTyYp11sUKFHzVNYvV083nymz0FkySdWveJI/Clk
         RpSUCDfkncS7+V3ohXIBT86f3yc6LibTkZUWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D2gAKKMYVUTv732gUqZOj+7ckf88ZsvW6cqPTYLGO40=;
        b=GFZPlJPCLWl2DcFGiHLfLXp0+8klJG++WXwnFzFmii3XmcXAsWzImDNC5jSsxj1dk3
         gmxGHEe16aJJzJDHatU7yGv9QB9k8s2zmwFb+40g4jJ7wq+U4tohkHXevGpurd9mPF6H
         8FFaSWNLfZYzRei5ZE/Cs1UBPuztSI5HDhfM9kv749v6/rpyTySmvlmwgYTZ2gkhSZNq
         58x7YYWR/94QTB4iAFeX+I91fyNz2kMvmnDFGCUiGJCLzx1gkXS28f1OGum8BSxX+ptH
         dUsuVDvUADwxBirDxBPVqmN/mdtxk37c52nP6wTB22jAFFYWQD4CeN0q6hHxmQFjFfJA
         KXmw==
X-Gm-Message-State: APjAAAWxJch7BEHu8rWk0L5KygdIsepUWgz1WY1B3W/OD3xeCdq1oSfJ
        v45kQlczRdJsPZc86SH+ut6luw==
X-Google-Smtp-Source: APXvYqy5wu+YZAailUTF1yC+HGzZ3aIDlchABAy3Rc8LFi4IMLp/p78ezaFXNhdSzmSQBQcaV1gDaw==
X-Received: by 2002:a17:90a:d104:: with SMTP id l4mr458593pju.60.1581532211359;
        Wed, 12 Feb 2020 10:30:11 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id a9sm1676189pfo.35.2020.02.12.10.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 10:30:10 -0800 (PST)
Date:   Wed, 12 Feb 2020 10:30:09 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, hemantg@codeaurora.org,
        robh+dt@kernel.org, mark.rutland@arm.com, gubbaven@codeaurora.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7180: Add node for bluetooth soc
 wcn3990
Message-ID: <20200212183009.GA50449@google.com>
References: <20200212155419.20741-1-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200212155419.20741-1-bgodavar@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 09:24:19PM +0530, Balakrishna Godavarthi wrote:

> Subject: arm64: dts: qcom: sc7180: Add node for bluetooth soc wcn3990

The subject still suggests that this is relevant for all SC7180 boards
that use the WCN3990 for Bluetooth. Please in the future save folks time
and make it clear in the *subject* that this is for a specific board
(the IDP).

> Add bluetooth SoC node for SC7180 IDP board.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> v2:
>   * updated commit text
>   * removed status form dts node
> ---
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> index 388f50ad4fde..7a50a439b6f3 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> @@ -19,6 +19,7 @@
>  	aliases {
>  		hsuart0 = &uart3;
>  		serial0 = &uart8;
> +		bluetooth0 = &bluetooth;

nit: it would be nicer to have the aliases in alphabetical order.

>  	};
>  
>  	chosen {
> @@ -256,6 +257,16 @@
>  
>  &uart3 {
>  	status = "okay";
> +
> +	bluetooth: wcn3990-bt {
> +		compatible = "qcom,wcn3990-bt";
> +		vddio-supply = <&vreg_l10a_1p8>;
> +		vddxo-supply = <&vreg_l1c_1p8>;
> +		vddrf-supply = <&vreg_l2c_1p3>;
> +		vddch0-supply = <&vreg_l10c_3p3>;
> +		max-speed = <3200000>;
> +		clocks = <&rpmhcc RPMH_RF_CLK2>;
> +	};
>  };
>  
>  &uart8 {

Reviewed-by: Matthias Kaehlcke <matthias@chromium.org>
