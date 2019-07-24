Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 098AB7271C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 07:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfGXFBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 01:01:23 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37797 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfGXFBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 01:01:23 -0400
Received: by mail-vs1-f66.google.com with SMTP id v6so30546878vsq.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 22:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L6bmVsqhCrWcP44dNz+ryOiefuDJUbPMuZZHROp2h8o=;
        b=yeYLnMe6AHfk4GzU5rqIM1QMbCG15Q7n5ovV0MGRY/5YLxQw+pvxOqLscbpUs64eLn
         qPc1t6Uth7uzIxN5EibV4b60nlofOD+3yha8qaF0nA/QfyPpJZ7QOVlH8QihTRRyed4j
         Wu/ATEA06t7GeqFFZY8peXscvnC3xYUJ97VZR/nyRQRDUVzRFzzcJwqpZ4UobUoOpiiF
         ZasxzIlC751HDXsSH9zBwTLX3u+JTG5oDxER7yeXgu69rNQ8yRqCli1Y2slpHEQdZ++q
         2xG2gZNpiOeM/0aXwCHHrBX/VubD/Pst79FhLlbNoBRdcVkWrrg4bNxfbqb3IfvtbaOK
         b5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L6bmVsqhCrWcP44dNz+ryOiefuDJUbPMuZZHROp2h8o=;
        b=tUbTO4Cqlm9cdV2hit7JnHs/fmKe4mrR+JUSHWEqE0sCMqeOzuZf4RBZk+WNb9wcF8
         mQiM5BAVc7j6VMgOOQIZ8/9dTbDygWtol5/heddYgKfWhVABB0adZdnCqcN2dyLhxoyI
         xciIwS/gYOPAqe52OrNLDNyAOne3Bj1sVZG2LOlen8BCFfs3SZJqOX+e3AmO05abowSU
         zlEY9E4a10nPRRW16QhVO33nWttTG/mac+yK3iihpIvsR8mfD47qpbU2cnGhdmECy0FN
         woLD4NBMyslSSGAIG9hL+CX3ho875n5x1LtAVzEoGk7WuCPy0ntJZajXXgsCHEVHosSH
         f+lA==
X-Gm-Message-State: APjAAAV1nv+bmDjHW6Qp0jkYeikzDGuC4DasJxPRHE/E+JMB193Zkccl
        tSMpXslMpUxrIlSUEn/DoC5LC7ZknCqEFFNQ3ob2VucmXJM=
X-Google-Smtp-Source: APXvYqw3yyWPpdCbrOX1pwgsfoztuivUgg/sQFikQTctRLB/C9ty3TU+JpmHdrbtAnjAT5/MlnGoWezxaV8YAJhNPSc=
X-Received: by 2002:a67:d990:: with SMTP id u16mr51197352vsj.95.1563944482317;
 Tue, 23 Jul 2019 22:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190724044906.12007-1-vkoul@kernel.org> <20190724044906.12007-3-vkoul@kernel.org>
In-Reply-To: <20190724044906.12007-3-vkoul@kernel.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 24 Jul 2019 10:31:11 +0530
Message-ID: <CAHLCerPQXQKrm4njTv3bTTKHFCpQC_TnJ98Jmnr0g+bD_Q3ycw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] arm64: dts: qcom: sdm845: remove unnecessary
 properties for dsi nodes
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 10:20 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> We get a warning about unnecessary properties of
>
> arch/arm64/boot/dts/qcom/sdm845.dtsi:2211.22-2257.6: Warning (avoid_unnecessary_addr_size): /soc/mdss@ae00000/dsi@ae94000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
> arch/arm64/boot/dts/qcom/sdm845.dtsi:2278.22-2324.6: Warning (avoid_unnecessary_addr_size): /soc/mdss@ae00000/dsi@ae96000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>
> So, remove these properties
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index e81f4a6d08ce..2985df032179 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -2234,9 +2234,6 @@
>
>                                 status = "disabled";
>
> -                               #address-cells = <1>;
> -                               #size-cells = <0>;
> -
>                                 ports {
>                                         #address-cells = <1>;
>                                         #size-cells = <0>;
> @@ -2301,9 +2298,6 @@
>
>                                 status = "disabled";
>
> -                               #address-cells = <1>;
> -                               #size-cells = <0>;
> -
>                                 ports {
>                                         #address-cells = <1>;
>                                         #size-cells = <0>;
> --
> 2.20.1
>
