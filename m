Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA84137592
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 18:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgAJR4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 12:56:55 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44162 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbgAJR4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:56:53 -0500
Received: by mail-pg1-f194.google.com with SMTP id x7so1324614pgl.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 09:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LV3ZO51UnSzYbU8f+RohedOpPRRnxaXUWqjrXj7/zLM=;
        b=VDHTmh4NJXlsjOFE5IoHJv3DrkRBok8rss1fiJ9kXXBecuqVneoYsDwCBg/7UrtgPM
         xMjDR0Fi96n2+BXJ/8G6QdB/yH6F6RWyoChp0jcFlqbTVHQxEsvAx+VrZ+PBUjpIFngo
         Za3M7rTYCVMXPxKMd2lJg98qOb4vqF8ITLRcvTbCYDMbr3iyZCYce/iE+e1I5guzo+cy
         QbMdc4zB52dtQpsdtQVsatZrCuj10My3Wkqhv7htMeXkYbeXMGYD/9QX7hO95R84bpva
         Px4RUa7DYKRjZ2nh1Xz6qL3v71YyB/uBxpAlkBWOTHwgFfkxhU5hknhxqHl4a+p0Hi0v
         iNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=LV3ZO51UnSzYbU8f+RohedOpPRRnxaXUWqjrXj7/zLM=;
        b=E6eWSmyvLQaAynizZ7GlJTFhPbH2xPqkTzyhM3mO42fRwvzJQT3yrVuqmIsvPMSHkW
         aQJpdNiBu8/yCcB3SukLNlQ/TA+q0gTuLHRt5e7vXBgzF5420O5OyZN90rBTK53dlycq
         +vFuJKOLXgeWatfDkZTFlkjWdc4nmUdAiC9xo4QBZeTyPFqh2PAZb9Npaiz0kq3eORTf
         e0fqtrDBkfsnXdPGCUJVgvt+HXkr+Z6Dd/16xduy3K7SkariVlUGJxPfnXX9wbLZRjDM
         rx2e4jJMMA0ILVqoyUM5kVpSwYmIE8aTK+7JUhDu+dph+hJt5LrxlEZvDyjFCAq+9axY
         dGjA==
X-Gm-Message-State: APjAAAWLB7GxAFnLYAHvfxyL8PyOTnREC+Zi2yyxSvxc4FyB1xEfKTeI
        bqzRcc11pIDJ76IxSmPcGHu26v7c
X-Google-Smtp-Source: APXvYqzfBxUGFYn3Yc+VhTxmob3vaFEXrFDjxvlMIPBq2Skh3j5kLcfSwJffLEhLdcGLfofkSGsh8g==
X-Received: by 2002:a65:5788:: with SMTP id b8mr5813123pgr.324.1578679012342;
        Fri, 10 Jan 2020 09:56:52 -0800 (PST)
Received: from [10.67.50.41] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 144sm3995871pfc.124.2020.01.10.09.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 09:56:51 -0800 (PST)
Subject: Re: [RFC] ARM: add multi_v7_lpae_defconfig
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Russell King <linux@armlinux.org.uk>
Cc:     phil@raspberrypi.org, wahrenst@gmx.net,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200110173425.21895-1-nsaenzjulienne@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 xsDiBEjPuBIRBACW9MxSJU9fvEOCTnRNqG/13rAGsj+vJqontvoDSNxRgmafP8d3nesnqPyR
 xGlkaOSDuu09rxuW+69Y2f1TzjFuGpBk4ysWOR85O2Nx8AJ6fYGCoeTbovrNlGT1M9obSFGQ
 X3IzRnWoqlfudjTO5TKoqkbOgpYqIo5n1QbEjCCwCwCg3DOH/4ug2AUUlcIT9/l3pGvoRJ0E
 AICDzi3l7pmC5IWn2n1mvP5247urtHFs/uusE827DDj3K8Upn2vYiOFMBhGsxAk6YKV6IP0d
 ZdWX6fqkJJlu9cSDvWtO1hXeHIfQIE/xcqvlRH783KrihLcsmnBqOiS6rJDO2x1eAgC8meAX
 SAgsrBhcgGl2Rl5gh/jkeA5ykwbxA/9u1eEuL70Qzt5APJmqVXR+kWvrqdBVPoUNy/tQ8mYc
 nzJJ63ng3tHhnwHXZOu8hL4nqwlYHRa9eeglXYhBqja4ZvIvCEqSmEukfivk+DlIgVoOAJbh
 qIWgvr3SIEuR6ayY3f5j0f2ejUMYlYYnKdiHXFlF9uXm1ELrb0YX4GMHz80nRmxvcmlhbiBG
 YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+wmYEExECACYCGyMGCwkIBwMCBBUCCAME
 FgIDAQIeAQIXgAUCVF/S8QUJHlwd3wAKCRBhV5kVtWN2DvCVAJ4u4/bPF4P3jxb4qEY8I2gS
 6hG0gACffNWlqJ2T4wSSn+3o7CCZNd7SLSDOwU0EVxvH8AEQAOqv6agYuT4x3DgFIJNv9i0e
 S443rCudGwmg+CbjXGA4RUe1bNdPHYgbbIaN8PFkXfb4jqg64SyU66FXJJJO+DmPK/t7dRNA
 3eMB1h0GbAHlLzsAzD0DKk1ARbjIusnc02aRQNsAUfceqH5fAMfs2hgXBa0ZUJ4bLly5zNbr
 r0t/fqZsyI2rGQT9h1D5OYn4oF3KXpSpo+orJD93PEDeseho1EpmMfsVH7PxjVUlNVzmZ+tc
 IDw24CDSXf0xxnaojoicQi7kzKpUrJodfhNXUnX2JAm/d0f9GR7zClpQMezJ2hYAX7BvBajb
 Wbtzwi34s8lWGI121VjtQNt64mSqsK0iQAE6OYk0uuQbmMaxbBTT63+04rTPBO+gRAWZNDmQ
 b2cTLjrOmdaiPGClSlKx1RhatzW7j1gnUbpfUl91Xzrp6/Rr9BgAZydBE/iu57KWsdMaqu84
 JzO9UBGomh9eyBWBkrBt+Fe1qN78kM7JO6i3/QI56NA4SflV+N4PPgI8TjDVaxgrfUTV0gVa
 cr9gDE5VgnSeSiOleChM1jOByZu0JTShOkT6AcSVW0kCz3fUrd4e5sS3J3uJezSvXjYDZ53k
 +0GS/Hy//7PSvDbNVretLkDWL24Sgxu/v8i3JiYIxe+F5Br8QpkwNa1tm7FK4jOd95xvYADl
 BUI1EZMCPI7zABEBAAHCwagEGBECAAkFAlcbx/ACGwICKQkQYVeZFbVjdg7BXSAEGQECAAYF
 Alcbx/AACgkQh9CWnEQHBwSJBw//Z5n6IO19mVzMy/ZLU/vu8flv0Aa0kwk5qvDyvuvfiDTd
 WQzq2PLs+obX0y1ffntluhvP+8yLzg7h5O6/skOfOV26ZYD9FeV3PIgR3QYF26p2Ocwa3B/k
 P6ENkk2pRL2hh6jaA1Bsi0P34iqC2UzzLq+exctXPa07ioknTIJ09BT31lQ36Udg7NIKalnj
 5UbkRjqApZ+Rp0RAP9jFtq1n/gjvZGyEfuuo/G+EVCaiCt3Vp/cWxDYf2qsX6JxkwmUNswuL
 C3duQ0AOMNYrT6Pn+Vf0kMboZ5UJEzgnSe2/5m8v6TUc9ZbC5I517niyC4+4DY8E2m2V2LS9
 es9uKpA0yNcd4PfEf8bp29/30MEfBWOf80b1yaubrP5y7yLzplcGRZMF3PgBfi0iGo6kM/V2
 13iD/wQ45QTV0WTXaHVbklOdRDXDHIpT69hFJ6hAKnnM7AhqZ70Qi31UHkma9i/TeLLzYYXz
 zhLHGIYaR04dFT8sSKTwTSqvm8rmDzMpN54/NeDSoSJitDuIE8givW/oGQFb0HGAF70qLgp0
 2XiUazRyRU4E4LuhNHGsUxoHOc80B3l+u3jM6xqJht2ZyMZndbAG4LyVA2g9hq2JbpX8BlsF
 skzW1kbzIoIVXT5EhelxYEGqLFsZFdDhCy8tjePOWK069lKuuFSssaZ3C4edHtkZ8gCfWWtA
 8dMsqeOIg9Trx7ZBCDOZGNAAnjYQmSb2eYOAti3PX3Ex7vI8ZhJCzsNNBEjPuBIQEAC/6NPW
 6EfQ91ZNU7e/oKWK91kOoYGFTjfdOatp3RKANidHUMSTUcN7J2mxww80AQHKjr3Yu2InXwVX
 SotMMR4UrkQX7jqabqXV5G+88bj0Lkr3gi6qmVkUPgnNkIBe0gaoM523ujYKLreal2OQ3GoJ
 PS6hTRoSUM1BhwLCLIWqdX9AdT6FMlDXhCJ1ffA/F3f3nTN5oTvZ0aVF0SvQb7eIhGVFxrlb
 WS0+dpyulr9hGdU4kzoqmZX9T/r8WCwcfXipmmz3Zt8o2pYWPMq9Utby9IEgPwultaP06MHY
 nhda1jfzGB5ZKco/XEaXNvNYADtAD91dRtNGMwRHWMotIGiWwhEJ6vFc9bw1xcR88oYBs+7p
 gbFSpmMGYAPA66wdDKGj9+cLhkd0SXGht9AJyaRA5AWB85yNmqcXXLkzzh2chIpSEawRsw8B
 rQIZXc5QaAcBN2dzGN9UzqQArtWaTTjMrGesYhN+aVpMHNCmJuISQORhX5lkjeg54oplt6Zn
 QyIsOCH3MfG95ha0TgWwyFtdxOdY/UY2zv5wGivZ3WeS0TtQf/BcGre2y85rAohFziWOzTaS
 BKZKDaBFHwnGcJi61Pnjkz82hena8OmsnsBIucsz4N0wE+hVd6AbDYN8ZcFNIDyt7+oGD1+c
 PfqLz2df6qjXzq27BBUboklbGUObNwADBQ//V45Z51Q4fRl/6/+oY5q+FPbRLDPlUF2lV6mb
 hymkpqIzi1Aj/2FUKOyImGjbLAkuBQj3uMqy+BSSXyQLG3sg8pDDe8AJwXDpG2fQTyTzQm6l
 OnaMCzosvALk2EOPJryMkOCI52+hk67cSFA0HjgTbkAv4Mssd52y/5VZR28a+LW+mJIZDurI
 Y14UIe50G99xYxjuD1lNdTa/Yv6qFfEAqNdjEBKNuOEUQOlTLndOsvxOOPa1mRUk8Bqm9BUt
 LHk3GDb8bfDwdos1/h2QPEi+eI+O/bm8YX7qE7uZ13bRWBY+S4+cd+Cyj8ezKYAJo9B+0g4a
 RVhdhc3AtW44lvZo1h2iml9twMLfewKkGV3oG35CcF9mOd7n6vDad3teeNpYd/5qYhkopQrG
 k2oRBqxyvpSLrJepsyaIpfrt5NNaH7yTCtGXcxlGf2jzGdei6H4xQPjDcVq2Ra5GJohnb/ix
 uOc0pWciL80ohtpSspLlWoPiIowiKJu/D/Y0bQdatUOZcGadkywCZc/dg5hcAYNYchc8AwA4
 2dp6w8SlIsm1yIGafWlNnfvqbRBglSTnxFuKqVggiz2zk+1wa/oP+B96lm7N4/3Aw6uy7lWC
 HvsHIcv4lxCWkFXkwsuWqzEKK6kxVpRDoEQPDj+Oy/ZJ5fYuMbkdHrlegwoQ64LrqdmiVVPC
 TwQYEQIADwIbDAUCVF/S8QUJHlwd3wAKCRBhV5kVtWN2Do+FAJ956xSz2XpDHql+Wg/2qv3b
 G10n8gCguORqNGMsVRxrlLs7/himep7MrCc=
Message-ID: <28c80303-1476-a9ce-32f5-15e0148167b7@gmail.com>
Date:   Fri, 10 Jan 2020 09:56:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200110173425.21895-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/20 9:34 AM, Nicolas Saenz Julienne wrote:
> The only missing configuration option preventing us from using
> multi_v7_defconfig with the RPi4 is ARM_LPAE. It's needed as the PCIe
> controller found on the SoC depends on 64bit addressing, yet can't be
> included as not all v7 boards support LPAE.

You might still be able to map the PCIe space above 4GB by using a super
section though I am not sure how easy that would be to do with
__map_init_section for instance and for the 4GB Pi4, we would not be
able to address the entire DRAM space anyway.

Besides, having a LPAE variant of the multi_v7_defconfig has a lot of
value given that there are a few ARMv7 platforms that support LPAE.

> 
> Introduce multi_v7_lpae_defconfig, built off multi_v7_defconfig, which will
> avoid us having to duplicate and maintain multiple similar configurations.
> 
> Note that merge_into_defconfig was taken from arch/powerpc/Makefile.

Would it make sense to move that make macro to scripts and keep just the
multi_v7_lape_defconfig make target under arch/arm/Makefile?

> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  arch/arm/Makefile            | 14 ++++++++++++++
>  arch/arm/configs/lpae.config |  1 +
>  2 files changed, 15 insertions(+)
>  create mode 100644 arch/arm/configs/lpae.config
> 
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index db857d07114f..3d157777a465 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -356,6 +356,20 @@ archclean:
>  # My testing targets (bypasses dependencies)
>  bp:;	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/bootpImage
>  
> +# Used to create 'merged defconfigs'
> +# To use it $(call) it with the first argument as the base defconfig
> +# and the second argument as a space separated list of .config files to merge,
> +# without the .config suffix.
> +define merge_into_defconfig
> +	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh \
> +		-m -O $(objtree) $(srctree)/arch/$(ARCH)/configs/$(1) \
> +		$(foreach config,$(2),$(srctree)/arch/$(ARCH)/configs/$(config).config)
> +	+$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
> +endef
> +
> +PHONY += multi_v7_lpae_defconfig
> +multi_v7_lpae_defconfig:
> +	$(call merge_into_defconfig,multi_v7_defconfig,lpae)
>  
>  define archhelp
>    echo  '* zImage        - Compressed kernel image (arch/$(ARCH)/boot/zImage)'
> diff --git a/arch/arm/configs/lpae.config b/arch/arm/configs/lpae.config
> new file mode 100644
> index 000000000000..19bab134e014
> --- /dev/null
> +++ b/arch/arm/configs/lpae.config
> @@ -0,0 +1 @@
> +CONFIG_ARM_LPAE=y
> 


-- 
Florian
