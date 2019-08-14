Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF1748DC1D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 19:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfHNRoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 13:44:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38174 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfHNRon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:44:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id e11so2878863pga.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 10:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8TCzd3zFiDX85xywn7ChohopRVZ50w25juT6dtizlkE=;
        b=oe2SbrDsxV5qofbDmFkBqA/UP9LedTWCuoTlB0Dudr7XbzPEYuUN6J4RPjYPhUydZK
         rXBGXeY5571WEWKzj9B1jVJ1S1lWxSwZUuUWFA2XtkHd0d+zQxMnATh3qY331FncYDrq
         +1dAf/OvSZAbb/D1dqBPTQB4T+/q12M1m+juWLZ63EEgRUQ3ZhrIWM+3haIFRknl2R9W
         am3nxtCWziF1Anpf4Sq4xKlgKXOiyl2aYOtwtPpJcRlPKjmsP2EsyzTVQtWoDkvEaSh+
         XANVlK78HhARtfEdjzjSHCrufUqXl1/IOcJD/qBd6rf5XlxkWBWR2KxBMfgVl+KHRHKK
         EU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8TCzd3zFiDX85xywn7ChohopRVZ50w25juT6dtizlkE=;
        b=e7ypCZzjNpPnaSPBiZQifyVsVwOTCKZX+MMjksSSr4VX8vtqXfkOJmKPYVrpdLooM9
         YkXomjEZO7zqs00KoinGY0Ql3qkxEyALIV1z+HrDQSjCLHa1w1AwNFJj2Ohtd9cXPeai
         Gnbtx3F1SlDjOeZ8R64z4oK1TLRiU4m0TQPDiEG0gDrubUVHXwnlTOpd6GjdCDjA5diL
         qTx6zw+ji8l7HfFEce+BgjnAgK+ahbdSJIoCDWlAnZoRBjztA3/nbGGxYrHGj6nJrHg2
         ClQyAVUTc5cv2eIuxuk6TFlaWU9F+56dHh6bGmfTPOxUTouweOlDqha0OXqXuElXEHSY
         uFlw==
X-Gm-Message-State: APjAAAVPQO/thpsrbO7+UObb7V96t3blOEvKpHWfET8+W8OKhGCcqf4i
        bceky4CDfXMCWoknVFOm4jWBJw==
X-Google-Smtp-Source: APXvYqz7MavHYdq/g7PveGK4Yap8TGnFicPUAMqpQBASUNRsOeDUdM0OR1O6eb/HCjCED+9QnKCHhg==
X-Received: by 2002:a62:58c4:: with SMTP id m187mr1104043pfb.147.1565804682598;
        Wed, 14 Aug 2019 10:44:42 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id e13sm438363pff.181.2019.08.14.10.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 10:44:41 -0700 (PDT)
Date:   Wed, 14 Aug 2019 10:44:39 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, sibis@codeaurora.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/22] arm64: dts: qcom: sm8150: add base dts file
Message-ID: <20190814174439.GE6167@minitux>
References: <20190814125012.8700-1-vkoul@kernel.org>
 <20190814125012.8700-2-vkoul@kernel.org>
 <20190814165855.098FD2063F@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814165855.098FD2063F@mail.kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14 Aug 09:58 PDT 2019, Stephen Boyd wrote:

> Quoting Vinod Koul (2019-08-14 05:49:51)
> > diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
[..]
> > +       clocks {
> > +               xo_board: xo-board {
> > +                       compatible = "fixed-clock";
> > +                       #clock-cells = <0>;
> > +                       clock-frequency = <19200000>;
> 
> Is it 19.2 or 38.4 MHz? It seems like lately there are dividers, but I
> guess it doesn't really matter in the end.
> 

As with previous platforms, the board's XO feeds the PMIC at 38.4MHz and
the SoC's CXO_IN pin (i.e. bi_tcxo) is fed from the PMIC's LNBBCLK1,
which is ticking at 19.2MHz.

[..]
> > +               gcc: clock-controller@100000 {
> > +                       compatible = "qcom,gcc-sm8150";
> > +                       reg = <0x00100000 0x1f0000>;
> > +                       #clock-cells = <1>;
> > +                       #reset-cells = <1>;
> > +                       #power-domain-cells = <1>;
> > +                       clock-names = "bi_tcxo", "sleep_clk";
> > +                       clocks = <&xo_board>, <&sleep_clk>;

So this first one should actually be <&rpmhcc LNBBCLK1>.

But while we now should handle this gracefully in the clock driver I
think we still have problems with the cascading probe deferral that
follows - last time I tried to do this the serial driver probe deferred
past user space initialization and the system crashed as we didn't have
a /dev/console.


So, I think we should s/xo_board/lnbbclk1/ (at 19.2MHz) to make it
represent the schematics and then once we have rpmhcc and validated that
the system handles this gracefully we can switch it out.

Regards,
Bjorn
