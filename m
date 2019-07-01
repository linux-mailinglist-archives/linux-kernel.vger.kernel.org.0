Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45E5C19CB6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 13:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfEJLb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 07:31:26 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:33927 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfEJLbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 07:31:25 -0400
Received: by mail-ua1-f68.google.com with SMTP id f9so2023867ual.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 04:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2cC/Zcxg1JnQkjFL1bdDhsa/0fTeyhKMuLV2nPc0e84=;
        b=nmIHe/8tgbvqwCu/r/3f/ME9uxWQ9OJMDaCD2DrtbOIslLYcnb3rWqonJnBoXggPSO
         pFRB/9Hy5C7PRugIsMV0s4QwhrSBc6hkLxxfjRViMgXFic55liP1ItoCIqwmlndiwUEZ
         72uUYdxpGEpCvYqufU2nECO2hX8YwpOdZ3tDo3f5WRIRdTBVwm0M6aHY+6RASMi4RTZN
         0dM5kXoud1qIjPOVCL+zYVUSgUTm+0gp+hOc9STM1QAK7mKyoIaXb7Kn/hCGE3WsXeuM
         ItNn2/EJSojKLEsMqPS2+vQ5DtI09GO6qpGPqekfjt6f6K+bj/kr52wNs0Psa+bRLj06
         mCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2cC/Zcxg1JnQkjFL1bdDhsa/0fTeyhKMuLV2nPc0e84=;
        b=A6LW5Ns33Nj8Z7Lk9xf9eotofdXmc5Y/V4SZun3OkeNHt0mDtpNs7Jx1ZEqQ86JAbo
         umqBML44ME8NM0+CD40TIYQmhPV9piU7Czr9/GfsK0o+YcDGh4Cnb1/0MCRY0Kg69J77
         9x+stFzFv2Y6+DCsmgkQWhX0y1WL4YbJxyBjFBs8NN5Xz909+iU1+XgrRtmNL5OBvfTr
         pUX9SqFeBvBWd1B/ZXLAQpXaqHmSXc+CFUw6mKhHrYXaR+pB4LN+CLethGMRoc3DsSob
         pW4zFp/cen4F4k++qhCVMYoqbitBVC93Ejo/JstnSA9Dz6S+sIiHQQeN4yP93wJXSJkf
         Barg==
X-Gm-Message-State: APjAAAXLScTgebXQUnChv+GG4VCoN6u31Tc12L3FFs/BYOEskYNRJ1Gj
        ECQj9WMb42YVffMgNSnCYwDjiFV4/GHyoNceX59eOw==
X-Google-Smtp-Source: APXvYqxlmQTVHS5UbjDpMkORWrJ3pcVnn1nCoE4a/WT5pDdUwaL6TEOyk7y7MweHAjc7AIIpZkKo60QHlscBksDXwLM=
X-Received: by 2002:ab0:4782:: with SMTP id v2mr1131666uac.94.1557487884393;
 Fri, 10 May 2019 04:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190506193115.20909-1-niklas.cassel@linaro.org>
 <20190507053547.GE16052@vkoul-mobl> <20190507065555.GB2085@tuxbook-pro>
In-Reply-To: <20190507065555.GB2085@tuxbook-pro>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 10 May 2019 17:01:12 +0530
Message-ID: <CAHLCerMnXdPvDNpdoJNix9JMzztB+bNnENW064=qGEwhqnicFQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: qcs404: Add PSCI cpuidle support
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Lina Iyer <lina.iyer@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 7, 2019 at 12:25 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Mon 06 May 22:35 PDT 2019, Vinod Koul wrote:
>
> > On 06-05-19, 21:31, Niklas Cassel wrote:
> > > Add device bindings for CPUs to suspend using PSCI as the enable-method.
> > >
> > > Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/qcs404.dtsi | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > > index ffedf9640af7..f9db9f3ee10c 100644
> > > --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > > @@ -31,6 +31,7 @@
> > >                     reg = <0x100>;
> > >                     enable-method = "psci";
> > >                     next-level-cache = <&L2_0>;
> > > +                   cpu-idle-states = <&CPU_PC>;
> > >             };
> > >
> > >             CPU1: cpu@101 {
> > > @@ -39,6 +40,7 @@
> > >                     reg = <0x101>;
> > >                     enable-method = "psci";
> > >                     next-level-cache = <&L2_0>;
> > > +                   cpu-idle-states = <&CPU_PC>;
> > >             };
> > >
> > >             CPU2: cpu@102 {
> > > @@ -47,6 +49,7 @@
> > >                     reg = <0x102>;
> > >                     enable-method = "psci";
> > >                     next-level-cache = <&L2_0>;
> > > +                   cpu-idle-states = <&CPU_PC>;
> > >             };
> > >
> > >             CPU3: cpu@103 {
> > > @@ -55,12 +58,24 @@
> > >                     reg = <0x103>;
> > >                     enable-method = "psci";
> > >                     next-level-cache = <&L2_0>;
> > > +                   cpu-idle-states = <&CPU_PC>;
> > >             };
> > >
> > >             L2_0: l2-cache {
> > >                     compatible = "cache";
> > >                     cache-level = <2>;
> > >             };
> > > +
> > > +           idle-states {
> >
> > Since we are trying to sort the file per address and
> > alphabetically, it would be great if this can be moved before l2-cache
> > :)
> >
>
> Picked up, with the order adjusted.
>
> > Other than that this lgtm
> >
>
> I presume that lgtm == Reviewed-by...
>
> Thanks,
> Bjorn

Hi Bjorn,

Please drop this patch and check the one I've sent as part of the qcom
cpuidle series?

Regards,
Amit

> > > +                   CPU_PC: pc {
> > > +                           compatible = "arm,idle-state";
> > > +                           arm,psci-suspend-param = <0x40000003>;
> > > +                           entry-latency-us = <125>;
> > > +                           exit-latency-us = <180>;
> > > +                           min-residency-us = <595>;
> > > +                           local-timer-stop;
> > > +                   };
> > > +           };
> > >     };
> > >
> > >     firmware {
> > > --
> > > 2.21.0
> >
> > --
> > ~Vinod
