Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2DBBD5ADC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 07:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfJNFlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 01:41:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37662 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfJNFlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 01:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AI8EfTeODgLvLyZXkT+wBeWstD/BS6tQHgRMlH3pY2k=; b=LuK3iUxUmZAB6J9sYijmNHSU2
        6Rrp6Rw+FIkUStG7/Lb8Jf13fRsZDSjH0PFVjTwxZpe7IaNvq6UXA/D2es8JQfrOGAW8WnYbDf/ZS
        nI0ELJQbZkbvTeJZsVVHPaHeXKVANzJy+N+qHEXIMzS2c0SoZjBbstvo+oHxCc8szD+kVRKPTIRzk
        XlQoIdGz3mERL7yP7ceE56QiLMG42TjQxZ+fbIhw0sjtzUlANxEq5yBGj4+8inMcjgeyfiiCCfYxw
        7Jx7ldxiaK7Ke5ue4ZC+1z9n2lP7z1O7cBqwvhF/R9zbaE6eiIKQbhpy2YPmmQNEcu8OdcLbsYp9K
        C6GZcYN/w==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iJt6S-0001Ax-Ej; Mon, 14 Oct 2019 05:41:08 +0000
Subject: Re: [PATCH v2 3/4] crypto: amlogic: Add crypto accelerator for
 amlogic GXL
To:     Corentin Labbe <clabbe@baylibre.com>, davem@davemloft.net,
        herbert@gondor.apana.org.au, khilman@baylibre.com,
        mark.rutland@arm.com, robh+dt@kernel.org,
        martin.blumenstingl@googlemail.com
Cc:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1571031104-6880-1-git-send-email-clabbe@baylibre.com>
 <1571031104-6880-4-git-send-email-clabbe@baylibre.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8f9be4a8-ed6c-a2bd-f3ba-df22752e7172@infradead.org>
Date:   Sun, 13 Oct 2019 22:41:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1571031104-6880-4-git-send-email-clabbe@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/13/19 10:31 PM, Corentin Labbe wrote:
> diff --git a/drivers/crypto/amlogic/Kconfig b/drivers/crypto/amlogic/Kconfig
> new file mode 100644
> index 000000000000..9c4bf96afeb3
> --- /dev/null
> +++ b/drivers/crypto/amlogic/Kconfig
> @@ -0,0 +1,24 @@
> +config CRYPTO_DEV_AMLOGIC_GXL
> +	tristate "Support for amlogic cryptographic offloader"
> +	default y if ARCH_MESON
> +	select CRYPTO_BLKCIPHER
> +	select CRYPTO_ENGINE
> +	select CRYPTO_ECB
> +	select CRYPTO_CBC
> +	select CRYPTO_AES
> +	help
> +	  Select y here for having support for the cryptographic offloader

	                to have support for

> +	  availlable on Amlogic GXL SoC.

	  available

> +	  This hardware handle AES ciphers in ECB/CBC mode.

	                handles

> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called amlogic-crypto.

That module name does not match the Makefile's name.

> +
> +config CRYPTO_DEV_AMLOGIC_GXL_DEBUG
> +	bool "Enabled amlogic stats"

	      Enable

> +	depends on CRYPTO_DEV_AMLOGIC_GXL
> +	depends on DEBUG_FS
> +	help
> +	  Say y to enabled amlogic-crypto debug stats.

	           enable

> +	  This will create /sys/kernel/debug/gxl-crypto/stats for displaying
> +	  the number of requests per flow and per algorithm.
> diff --git a/drivers/crypto/amlogic/Makefile b/drivers/crypto/amlogic/Makefile
> new file mode 100644
> index 000000000000..39057e62c13e
> --- /dev/null
> +++ b/drivers/crypto/amlogic/Makefile
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_CRYPTO_DEV_AMLOGIC_GXL) += amlogic-gxl-crypto.o
> +amlogic-gxl-crypto-y := amlogic-gxl-core.o amlogic-gxl-cipher.o


-- 
~Randy
