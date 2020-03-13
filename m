Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77584184EC5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 19:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgCMSi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 14:38:57 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45809 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgCMSi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 14:38:57 -0400
Received: by mail-io1-f68.google.com with SMTP id w9so10508955iob.12;
        Fri, 13 Mar 2020 11:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=cUuLSwZPrJiRgANKoLpU4cPUGPy0b1zzEtLmRHixawM=;
        b=pdQfPVjVSSOD59vLUiszT2k4KPe/kCBMeiZthSOeCrEeeOkRG8ORIuJ1tYwaFCwj7u
         mXd5jKvuHQ/shmhWkwEj9Fk0eZaWbfn+DzvqSmOOog5LZr/U6DbKJEEj+3Y/IiOHpmvS
         RtKijyA3OxrinDMGSFixNsJjU5MTktY8LhoUPjYhNpsRBEWp/IOgqdm0054pahtufaBK
         A8+jD31s69s+r8vC8XtTkqdjQEYSRmUdF0dP2tZeMxQ7dfB6ha/rWpsmmPCsneTN2ABc
         sP6XarxcnXmSWfkKOoqav5la81uCFB1uFNpM+B09YTSNR5M9LwVh2Nkvf6Lxw7vODIRr
         UNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cUuLSwZPrJiRgANKoLpU4cPUGPy0b1zzEtLmRHixawM=;
        b=pPMAFPpJCpWGwcZp33QPiqFuPBbF13g0aZLx1SOdsWJp/aUqcDKsw+/l5Zm1HN2+QD
         22Wmny8sL/sWGwiHQ/f3bxA7tP0lQqUZWvZlgt811WQVG2JXXTfiS0vmiCv8r3ED53zf
         8GT5xIXsyAwHemAe1F8Gl5FMHBG3D/f+qjNUqqIGUUYOim5ZQsSEm4q2/LXiIPfqWjwb
         evwZLqJMTUvAFjAVyppD8U1AQggL/0qEm9JDO90Os4u8kUxOiNlAYoIA+o5mrrCLvTre
         3bLofl6wEjF/+5tGIpo4vxyeJ41oJ+MtrlWuGhADzdU+B0tupc73GQgff+OlaFjYvZkz
         Qaew==
X-Gm-Message-State: ANhLgQ1WscTdVIwxigkVsLnyV/3RoO5uyKIBGfThikd7qPEVUBy6sMb1
        safKwIm/4hSHbWYXQMuCanw=
X-Google-Smtp-Source: ADFU+vtdsZ5CoLT8VEqVJq5gzOg+u0Z6Cy0SMBjXfTDYMAWxmxvUIJQyio7XZupCGfrbMwfmlLrgyA==
X-Received: by 2002:a02:5489:: with SMTP id t131mr14297947jaa.134.1584124735873;
        Fri, 13 Mar 2020 11:38:55 -0700 (PDT)
Received: from [10.30.196.58] ([204.77.163.55])
        by smtp.gmail.com with ESMTPSA id i82sm9783468ilf.32.2020.03.13.11.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 11:38:54 -0700 (PDT)
From:   Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
Subject: Re: [PATCH] ARM: dts: rockchip: Keep rk3288-tinker SD card IO powered
 during reboot
To:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20200219204224.34154-1-JPEWhacker@gmail.com>
Message-ID: <ed50e114-5efd-edcc-a287-3cacc4a28161@gmail.com>
Date:   Fri, 13 Mar 2020 13:38:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219204224.34154-1-JPEWhacker@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/19/20 2:42 PM, Joshua Watt wrote:
> IO voltage regulator for the SD card must be kept on all the time,
> otherwise when the board reboots the SD card can't be read by the
> bootloader.

Ping?

>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>   arch/arm/boot/dts/rk3288-tinker.dtsi | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
> index 312582c1bd37..acfaa12ec239 100644
> --- a/arch/arm/boot/dts/rk3288-tinker.dtsi
> +++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
> @@ -276,6 +276,7 @@
>   			};
>   
>   			vccio_sd: LDO_REG5 {
> +				regulator-always-on;
>   				regulator-boot-on;
>   				regulator-min-microvolt = <1800000>;
>   				regulator-max-microvolt = <3300000>;
