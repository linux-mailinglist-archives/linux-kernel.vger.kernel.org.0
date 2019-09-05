Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12C1EAA5F1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 16:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732903AbfIEOdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 10:33:50 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38260 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731769AbfIEOdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 10:33:49 -0400
Received: by mail-wm1-f68.google.com with SMTP id o184so3341454wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 07:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0kWQEXS+ph2//LVOCjdO1AE5KiNrMj2peKb0h4PZi2w=;
        b=eVNvXseNmZf9gF4JlJ38WkzGzId7Rgu2QI1agmcAC1WMAo7DFc//p/dikQDyNObe7r
         AD0Ku0o6aLqrepbZpEAP2tSTLtWl/cgDYFite3oeWkDBX1MWEz6JD3Bo5EZzlOb//cC/
         oo6URQjKmK3aiAWe3FzpNayt/Pm8uA1LlzSCrZwG+i+bDiM2VeSEpmzgRwTQat16IGiM
         rE2aFL/djYliujAxKw3d52rugP9PFqCcMEgmVWI155TCYO1kJN9e5hNpAOzyCAkbkbA8
         nc9dapTBKNIcSn61NIPiDtC069BrkdmGKaN2wJKTmurBTjyuML5MelDUoIvhd9iONLbQ
         qwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0kWQEXS+ph2//LVOCjdO1AE5KiNrMj2peKb0h4PZi2w=;
        b=tzRTlIzGJGrbztFYLRsHB2WbAVslcSl+MrfirAQjqBnf8YwSwLyPL5zddOcFI92oGN
         QApeTi6gkN2Tvc1Jd5kuDxiIc40fLt8OMuCtWaU9saUIqsBt+nCWHkjkbIR6Xsve1kYT
         +Vb72W07ooh4UsNxm8gZ2wqlSTSWacMM1bg47arBVFuiTSs1P+Fg567SgTdDs7u8pLlT
         9HZtgOfMchLSgl2CW2oDi+nDRvqp2lls7HpdLOseGcPbT1si44qz39WNbkk/b9RZ4HB0
         Fh+6fMwkwhRjhI9+iOEuNXhPrgIz9uMMidiwTFPXvXt6VH0Kg6BBwYZy1O7reKZXJAH5
         sK2w==
X-Gm-Message-State: APjAAAWtR7fWtSgV4vsT9Piq3jzLin8V16/6uVqWHPF1pcTgBpWAXSoT
        CT3dnYs0b3AnbYQkablJQOOcKw==
X-Google-Smtp-Source: APXvYqxndoj+n5/jORTCTc0U+rjE4qY/hlpTto8yxEG1p+EkbUjD5WDA36ObaUU4QIXj7MlbI/xljA==
X-Received: by 2002:a1c:9a4a:: with SMTP id c71mr3044824wme.99.1567694027358;
        Thu, 05 Sep 2019 07:33:47 -0700 (PDT)
Received: from dell ([95.147.198.36])
        by smtp.gmail.com with ESMTPSA id b26sm2817469wmj.14.2019.09.05.07.33.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Sep 2019 07:33:46 -0700 (PDT)
Date:   Thu, 5 Sep 2019 15:33:45 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        "alokc@codeaurora.org" <alokc@codeaurora.org>,
        "agross@kernel.org" <agross@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] i2c: qcom-geni: Provide an option to disable DMA
 processing
Message-ID: <20190905143345.GF26880@dell>
References: <20190905102247.27583-1-lee.jones@linaro.org>
 <20190905134941.GG1157@kunai>
 <3458ed2a-ae49-b46b-3e89-ce039a2749b4@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3458ed2a-ae49-b46b-3e89-ce039a2749b4@axentia.se>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Sep 2019, Peter Rosin wrote:

> On 2019-09-05 15:49, Wolfram Sang wrote:
> > Hi Lee,
> > 
> > I understand you are in a hurry, but please double check before
> > sending...
> 
> Linus indicated that an rc8 is coming up, which should provide an extra week.
> https://lwn.net/Articles/798152/

That is good news.

> > On Thu, Sep 05, 2019 at 11:22:47AM +0100, Lee Jones wrote:
> >> We have a production-level laptop (Lenovo Yoga C630) which is exhibiting
> >> a rather horrific bug.  When I2C HID devices are being scanned for at
> >> boot-time the QCom Geni based I2C (Serial Engine) attempts to use DMA.
> >> When it does, the laptop reboots and the user never sees the OS.
> >>
> >> The beautiful thing about this approach is that, *if* the Geni SE DMA
> >> ever starts working, we can remove the C code and any old properties
> >> left in older DTs just become NOOP.  Older kernels with newer DTs (less
> >> of a priority) *still* will not work - but they do not work now anyway.
> > 
> > ... becasue this paragraph doesn't fit anymore. Needs to be reworded.

Yes, you're right.  I noticed almost the moment I pressed send. :(

> >> Fixes: 8bc529b25354 ("soc: qcom: geni: Add support for ACPI")
> > 
> > As said in the other thread, I don't get it, but this is not a show
> > stopper for me.

Ah wait.  Yes, this is applied against the wrong patch.

Please ignore.

> WAG: because ACPI made some driver load at all, and when it
> did it something started happening which crashed some machines.

I'm not sure I understand this sentence.

... resending now.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
