Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C07D13D97B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 13:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgAPMBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 07:01:01 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37789 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgAPMBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 07:01:00 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so3513078wmf.2;
        Thu, 16 Jan 2020 04:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K45x8SHvjhN/SqzbB8kaaG/ZwA6tE8xnF2TMFaLqgWo=;
        b=qCzhhL1fyhuF4uJ30kAHFGAgukb2dvuIkZZpSFnV9Bvopy1uHd2JmGaTH/DeCT9jyv
         zEUV7VfHwdLK6lkcDTsPPilyk7vBAk66Hv5ZqEtNm5rvhSmQFJNwXylpl/1Bzs0Imv54
         Rql4Hhs2Qoq6nyXXVoyhzL+DHoBZKRWba01HL4UK/mcUTyOescWybJpHAQgDx/pXVWSy
         sJYb4yzMCfKhh+CdyHvrc37xdZ2akspJyGCpvLnT7IdhY/SV04oZpEBReXF04SJJVP6x
         J28UY9KUlAdKPgt5lH0M4MEw2dkG7DX7hH3Y0T5ZXy89bOP8Cr4xXFmOEGzUCW/onAH+
         sjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K45x8SHvjhN/SqzbB8kaaG/ZwA6tE8xnF2TMFaLqgWo=;
        b=IL5RZwnGKf5k5RqpSNUUj6fwEXdi3p/8leqEZtlTIYw5L/yKdUhCNaWXlF+NdiknrQ
         3qqkeLcJSAt42pKIJwpGoSoQKsDMDToxuNJLDiUcXl3xxZ8HYIr1aaQkFPeZkffDo4zB
         SGhZKljaYP2ucbidq7Zz1OJL50c0QsWZlM9aEYhjJKNKeij5OwcQ++GJcb8teYBNYPXs
         INBjiSzCO41wD1iP2qTyNWOciFD1oMgPj6GBaWjJr1lUW9Tj2NRDkA9moREkxCeXPZCl
         q7jhY2pZSYrq3DRJ85SR1is8lSfCqrxmlep8+xTUR2ro2Z3aIBSkJed7f5EGG9Nb8UzD
         3djg==
X-Gm-Message-State: APjAAAWKaNL9NS927ThJUawuLg/CbnUfFv/YDXnEUBvxSJIEGizrQCAo
        3sc1ZuJbzWKEXosCmEMufbs=
X-Google-Smtp-Source: APXvYqxSG6XX0qeAUXiXclajDgAqCIR4Vw2T5QnvgyIxq5EiuPtxzO1/xghNLthqCFKePTImdZDOOg==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr5686130wmi.51.1579176057805;
        Thu, 16 Jan 2020 04:00:57 -0800 (PST)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id n8sm28902799wrx.42.2020.01.16.04.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 04:00:57 -0800 (PST)
Subject: Re: [RFC PATCH v1 2/3] dt-bindings: mmc: convert synopsys dw-mshc
 bindings to yaml
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
References: <20200114213809.27166-1-jbx6244@gmail.com>
 <20200114213809.27166-2-jbx6244@gmail.com>
 <CAL_JsqJ0QJ9uG9NY7vMGG00G4Jfk2mXS4OPdUzEaRVaCP++GzQ@mail.gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <203e9217-9aa8-b65e-4411-2d9b23c1362a@gmail.com>
Date:   Thu, 16 Jan 2020 13:00:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJ0QJ9uG9NY7vMGG00G4Jfk2mXS4OPdUzEaRVaCP++GzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

See below.

On 1/15/20 4:18 PM, Rob Herring wrote:
> On Tue, Jan 14, 2020 at 3:38 PM Johan Jonker <jbx6244@gmail.com> wrote:
>>

> [...]
> 
>> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
>> new file mode 100644
>> index 000000000..6f85a21d0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
>> @@ -0,0 +1,88 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mmc/synopsys-dw-mshc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Synopsys Designware Mobile Storage Host Controller Binding

[..]

>> +examples:
>> +  # The MSHC controller node can be split into two portions, SoC specific and
>> +  # board specific portions as listed below.
> 


> This split doesn't work because the examples are built and validated
> now. It may happen to because all the props are optional, but the
> board hunk goes unchecked. So please combine.
> 

Hi,

I have no knowledge about this particular hardware to give a realistic
example. Could someone advise here? Or should I just use the first
example for now?

Thanks

>> +  - |
>> +    dwmmc0@12200000 {
>> +      compatible = "snps,dw-mshc";
>> +      clocks = <&clock 351>, <&clock 132>;
>> +      clock-names = "biu", "ciu";
>> +      reg = <0x12200000 0x1000>;
>> +      interrupts = <0 75 0>;
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +      data-addr = <0x200>;
>> +      fifo-watermark-aligned;
>> +      resets = <&rst 20>;
>> +      reset-names = "reset";
>> +    };
>> +  # [board specific internal DMA resources]
>> +  - |
>> +    dwmmc0@12200000 {
>> +      clock-frequency = <400000000>;
>> +      clock-freq-min-max = <400000 200000000>;
>> +      broken-cd;
>> +      fifo-depth = <0x80>;
>> +      card-detect-delay = <200>;
>> +      vmmc-supply = <&buck8>;
>> +      bus-width = <8>;
>> +      cap-mmc-highspeed;
>> +      cap-sd-highspeed;
>> +    };
>> +  # [board specific generic DMA request binding]
>> +  - |
>> +    dwmmc0@12200000 {
>> +      clock-frequency = <400000000>;
>> +      clock-freq-min-max = <400000 200000000>;
>> +      broken-cd;
>> +      fifo-depth = <0x80>;
>> +      card-detect-delay = <200>;
>> +      vmmc-supply = <&buck8>;
>> +      bus-width = <8>;
>> +      cap-mmc-highspeed;
>> +      cap-sd-highspeed;
>> +      dmas = <&pdma 12>;
>> +      dma-names = "rx-tx";
>> +    };
>> --
>> 2.11.0
>>

