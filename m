Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8C6352E3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 00:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfFDW4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 18:56:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36312 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfFDW4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 18:56:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id u22so13597915pfm.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 15:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DdB1hFng+j3QxIExhxP4PIq5A0CyaatjpD+2+pXTJ50=;
        b=ZVKPzblaTx+bxcO9Y3bnoWV8PC5rTlER76Z9F1K4yo11E35OaWAwcgQDTtUcnlK2X2
         fA+/OMelzeZ1zeyIe5PpR/bk7DmLUM2C3SlPWo90KZC2sHDhPy4tKb8Xzq7xAWtY2NGY
         +Z2zUT6bmbD+ivQ16XHaC40cU8MAbKdODvS4JCV8LpPXyi/b5RE8cIfiO5FPjhGPLmJe
         RYJ1dh1hCoRq6DWWQ3mKXf89GsS9gWwCSqLidzpjKSFwNjJUl6/idf2SeLZDxuJzzzzu
         sWVHU9aHzFptuW6teD7N6SgSx+7lcpCJ9a4U7jLxeUh66YWRrhG6p+zpBzqjSdBajU/L
         +Pxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DdB1hFng+j3QxIExhxP4PIq5A0CyaatjpD+2+pXTJ50=;
        b=Qf3L529LksAVbg9dSdxAIfshmeffeucnuemvRuBG8ozXOP4mPhYxj8e/0UqNNLtp7S
         6smMSBhpHKDtf46sfgmECZ7YhUMp6HTc1yHt1Ko3urQypCgIM11g+zyoNP2yym0p9k/x
         PZGsjO9RnUcCf13QPTLudFbkEoInO5Fk4ly9xPtTwKIqOF79p7rSBAL4enKFdM0BE19j
         njvvRhE/L6Ho7mLHBQoibcIGzqMmkzlmj4yJt1YVgB3Np/rQcKJ8NyR4wHnTPP6ePKDR
         K0G7SFrQhoCWQ7UFMWCPXyX1FyYm0pSoah2yoVXtO/B+Wyoen1IuW/7+ZVboqYQPY9lV
         yMPw==
X-Gm-Message-State: APjAAAW3q65mOO0X79MjHaLr6zipcVH8DOHf0G0xV1IWMod40QG/BcwB
        HLbbQTrytp2c7JcUmMCwitFPfg==
X-Google-Smtp-Source: APXvYqxXWTdDSUlDGVG4Z9cIza7OkoBhDDiWOTJHbzYr/BFQdTPMi3c6Gz/SZFMfYX6kQtHL6AKwqw==
X-Received: by 2002:aa7:860a:: with SMTP id p10mr42299386pfn.214.1559688991910;
        Tue, 04 Jun 2019 15:56:31 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r77sm24237267pgr.93.2019.06.04.15.56.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Jun 2019 15:56:31 -0700 (PDT)
Date:   Tue, 4 Jun 2019 15:56:29 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH] arm64: dts: sdm845: Add iommus property to qup1
Message-ID: <20190604225629.GF4814@minitux>
References: <20190604222939.195471-1-swboyd@chromium.org>
 <20190604223700.GE4814@minitux>
 <CAD=FV=W08iWhbM_aDjhrz0Rm5O-Gbn6DVFNcWK5X6AB2W9YiLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=W08iWhbM_aDjhrz0Rm5O-Gbn6DVFNcWK5X6AB2W9YiLw@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04 Jun 15:48 PDT 2019, Doug Anderson wrote:

> Hi,
> 
> On Tue, Jun 4, 2019 at 3:37 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Tue 04 Jun 15:29 PDT 2019, Stephen Boyd wrote:
> >
> > > The SMMU that sits in front of the QUP needs to be programmed properly
> > > so that the i2c geni driver can allocate DMA descriptors. Failure to do
> > > this leads to faults when using devices such as an i2c touchscreen where
> > > the transaction is larger than 32 bytes and we use a DMA buffer.
> > >
> >
> > I'm pretty sure I've run into this problem, but before we marked the
> > smmu bypass_disable and as such didn't get the fault, thanks.
> >
> > >  arm-smmu 15000000.iommu: Unexpected global fault, this could be serious
> > >  arm-smmu 15000000.iommu:         GFSR 0x00000002, GFSYNR0 0x00000002, GFSYNR1 0x000006c0, GFSYNR2 0x00000000
> > >
> > > Add the right SID and mask so this works.
> > >
> > > Cc: Sibi Sankar <sibis@codeaurora.org>
> > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > index fcb93300ca62..2e57e861e17c 100644
> > > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > @@ -900,6 +900,7 @@
> > >                       #address-cells = <2>;
> > >                       #size-cells = <2>;
> > >                       ranges;
> > > +                     iommus = <&apps_smmu 0x6c0 0x3>;
> >
> > According to the docs this stream belongs to TZ, the HLOS stream should
> > be 0x6c3.
> 
> Since you've already got the docs in front of you, how about looking
> up the value for qup0 so we can fix both of 'em?
> 

Good thinking. QUP_1 is at stream 0x3.

Regards,
Bjorn
