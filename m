Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 184E2182D49
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 11:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgCLKRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 06:17:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54430 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCLKRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:17:36 -0400
Received: by mail-wm1-f67.google.com with SMTP id n8so5416486wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 03:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JSh5SwgggaNNIP1rhJKmLIM4vESq/2xFcSyTZp+7Nus=;
        b=Rx+1EGWt2dGF/rxSvLT7XGg2rRWc3yl5MrGHM3fODfxN+My4zCiGC9aeKEjXVaY/C/
         +LHCPygIqp9eoxc+JZrBWd7bE5FY7+BnkvLH11AHW/mdG41YmsLhn15hx0GwjkuK1X/F
         ewTFglT3n/TGbE1lgqU0mwv3vp++G2D3agpGYFaUIaiCmkzvLOJ1Ohco+rUjxj5WO/8d
         SytvKXLoXZb7b1MkmlzgHZ4b6ixTjOpbOkiacoaqMAlyG6heH8taLU8p2f7qFn5Khhr6
         E7im34jcZgsPPAc4GqZdIJrpbekoOOBrxw8QTkhyx32epfHsyD4B2w6iVmJgKc36a6Ns
         ejHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JSh5SwgggaNNIP1rhJKmLIM4vESq/2xFcSyTZp+7Nus=;
        b=OUMV/UukcPam+PInj5HSB7YkET4Ab647EEjzU+M39/Vaa8rloWFH9s7vurfTwloNTp
         tPLy3mY41NN8DRm1aiN+ojtfR8iZU6XImx5Eamyae1Q9bKUVBbi6PbgFbLCRl2BunRtD
         gfJFyES9i+wkL+UWsfYUzQj8FLhVkKybJpVujTkwoDVHbzGoJe90hS7v+1/91SxEGsWv
         TLxEYqdv+NN5aVmZOxH6e1Wp/31fpcYvsl0K8qyZP350/C6OUfSzLc/px3pEveJl+Rt8
         E55QDp9/e414mOHb762XgrgxpPytrQDDNG7naeDnCTLXYR0RMVbXnpf1gktWM+kt17XG
         dHTw==
X-Gm-Message-State: ANhLgQ3ryzcPVIpOUOOrOnHrK1t0/jTtDExliBqkgWLZfjT8op8q/ntn
        NtglGzBnD8g7VDCG9j0x0cQ6sg==
X-Google-Smtp-Source: ADFU+vtd22zCvQBt96HNv1FNfip491J3yg6bOcH1BHTeiIr8TJOxKRCIuR11VfvzANE3XDLrYVJOCw==
X-Received: by 2002:a1c:f009:: with SMTP id a9mr4167566wmb.73.1584008252629;
        Thu, 12 Mar 2020 03:17:32 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id f4sm18901766wrt.24.2020.03.12.03.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 03:17:31 -0700 (PDT)
Date:   Thu, 12 Mar 2020 10:17:29 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: power: supply: add cw2015_battery
 bindings
Message-ID: <20200312101729.ppqhco2j3p66dnqz@holly.lan>
References: <20200311093043.3636807-1-t.schramm@manjaro.org>
 <20200311093043.3636807-3-t.schramm@manjaro.org>
 <20200311172056.wjn3574zrfqxipw6@holly.lan>
 <bd1bea1c-e42b-8ccc-7fbb-2ed268f1b1a5@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd1bea1c-e42b-8ccc-7fbb-2ed268f1b1a5@manjaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 12:17:55AM +0100, Tobias Schramm wrote:
> Hi Daniel,
> 
> thanks for reviewing. The typo will be fixed for v4.
> 
> >> +  power-supplies:
> >> +    description:
> >> +      Specifies supplies used for charging the battery connected to this gauge
> >> +    allOf:
> >> +      - $ref: /schemas/types.yaml#/definitions/phandle-array
> >> +      - minItems: 1
> >> +        maxItems: 8 # Should be enough
> > 
> > Is it necessary to set a maximum? power_supply.txt is still a text file
> > but there is no mention of a maximum there.
> > 
> I think so? Removing maxItems and running dtbs_check on a dts with more
> than one supply phandle in the power-supplies property results in an error:
> linux/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dt.yaml:
> cw2015@62: power-supplies: [[142], [50]] is too long

Interesting. I saw the "Should be enough" comment replicated in several
YAML bindings (with varying degress of paranoia about how much "enough" is).
There are also several that simply set minItems without setting
maxItems, perhaps they have just never been any DTs that test those
bindings with more than one item.


Daniel.
