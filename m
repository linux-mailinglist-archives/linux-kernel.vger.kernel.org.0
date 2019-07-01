Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B62904AEE4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 02:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbfFSAHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 20:07:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36221 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfFSAHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 20:07:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id f21so8570038pgi.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 17:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GQXaooy3YTQO/7dhNz5IloaGMVtvq8OISjNBJivVZk8=;
        b=QISWmhKmDdfZzkXDJE6OzYJ7fuHyi4jZQkR4GwS7QDM8X/tZAk41MVJTWQY6eHW2lO
         WOYnQ1BQTPLTE3eknm53dYv9AvyasKMMGsPEBStbDfxZIH2prIu9Ytmt8eeqHkVM+bvm
         DvpIU4M7ujQL6vMPUs5Ho9z9gYlAhCpXwYGFrD5XNnv7YqkCmEUs8Rf0cwDy/qMfkyt1
         zti+RIx+roo+Ok7+YhRy9J9Knie6tb8Iyuh6vlqF+55jva5V7OapBWtAK2AIEz/TGQw7
         8NsHzIv5o7krpsJT295ejNFqvaV4w0gLHRHbI9mF8aoGuTCXUJ6q33i7H1Z/n+6spkA3
         NSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GQXaooy3YTQO/7dhNz5IloaGMVtvq8OISjNBJivVZk8=;
        b=mOWd4TvXprhUQa6mjArai3T7+lpy+Z2ZkY6ejEFIrOuEIqXAmpqKwMFYhiUgkuqkUA
         AXxckn4d72nMrXsGUOYJIuIhcC4mDk3C0IwH4qjxvQ4XE8hZQVq9SMSlV7cDXkZ9bdZi
         TB96XVTFdwS2vadcFuq1fd1dfv7+ecoaJjhgipeoExjS+7EYGCXbPBeRHwrMl3Y0Tbiq
         uF1ooMrULr9eMqgBgBsEc3YmITuxKW+uURMGwWKBIp80Gd39UGrkE4Hfo/9tKyUVH8CN
         QIbfoYc6pkljUWuzxe8IZZawIP2MY2E/oAdVep6TJ9LTZ80Ss+TqH3HPdPtBrZ2xzTkD
         fnQA==
X-Gm-Message-State: APjAAAVJc+nUxsioF76yFckCxtFxiYMwMb/j0a3SANSnic18OYF0lllW
        kO+s8XMMKTdY5U515wOG9dvXIQ==
X-Google-Smtp-Source: APXvYqz5ltPufYbUT+ecfpkCtqsZC1ypLVG6bKP028wuxw3yyPlrrxm4ZnTOE+kOsARleDrxVvQ5ww==
X-Received: by 2002:aa7:8752:: with SMTP id g18mr7086261pfo.201.1560902824089;
        Tue, 18 Jun 2019 17:07:04 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c26sm15772646pfr.71.2019.06.18.17.07.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 17:07:03 -0700 (PDT)
Date:   Tue, 18 Jun 2019 17:07:01 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        MSM <linux-arm-msm@vger.kernel.org>, devicetree@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] arm64: dts: qcom: Add Dragonboard 845c
Message-ID: <20190619000701.GI4814@minitux>
References: <20190618211945.27431-1-bjorn.andersson@linaro.org>
 <CAOCk7Nq7X=3LdzQF83J1QDRnrQtWmjRcySyLZ-3M321HtHxHfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOCk7Nq7X=3LdzQF83J1QDRnrQtWmjRcySyLZ-3M321HtHxHfg@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 18 Jun 14:27 PDT 2019, Jeffrey Hugo wrote:

> On Tue, Jun 18, 2019 at 3:21 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
[..]
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> > new file mode 100644
> > index 000000000000..71bd717a4251
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> > @@ -0,0 +1,557 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2019, Linaro Ltd.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> > +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> > +#include "sdm845.dtsi"
> > +#include "pm8998.dtsi"
> > +#include "pmi8998.dtsi"
> > +
> > +/ {
> > +       model = "Thundercomm Dragonboard 845c";
> > +       compatible = "thundercomm,db845c", "qcom,sdm845";
> 
> Is "thundercomm" a legal vendor prefix?
> 

Following the other board vendors, yes. But you're right in that it
should be added to vendor-prefixes.yaml as well.

Given the review feedback on v2 I've merged this revision for v5.3.

Regards,
Bjorn
