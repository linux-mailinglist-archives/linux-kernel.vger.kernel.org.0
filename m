Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE4E89F95
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 15:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbfHLNYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 09:24:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35710 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728695AbfHLNYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 09:24:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id k2so18706409wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 06:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nC0XBOiWbAbQwJIvttLNUSDXZEWVPgrZEH9kYI4ESEg=;
        b=KdowPy/ZBvnwn/HSU7gjkVq9UrYpR3h4Rz7yrxwQA3ohuwT4La1YEbafzwTQiyGbB3
         6QonaqtKmwTvQvVAkUuXqhFlDfDjkaXKQ7zpwE7eGxhuj1ceYyytsva8K5UQ8S9Sxa1l
         0Y1oon8rOVVaf+boODQgVUswo8xgye+BoTn+yDsiXWTW/NS6IQsn/plpM4JQaaNP4O6B
         TqZTxR3XHrKVwJXd9XdY0hqFqBNW8M1q45w82I966F/alSFqF39B+Nsz1nWQEnNynAc4
         A2YNPddK8smYE3BcVulLdkdiz+QMZyywgQdjm7O4meR9DNvs9jp6Y3XjTE1cuP7rEBBJ
         1TgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nC0XBOiWbAbQwJIvttLNUSDXZEWVPgrZEH9kYI4ESEg=;
        b=qhUy0TSQ89IjqKBDMBDup7036ki6ovCt/HQoQErySTbNH0Zdnj8p8YNxeWo1hnzOnH
         EK3uPo72ZbEQRn7IqIthVNXPpPzz658F2py6+DC7givrSRW2/kpFJ3BnYeS+P0gjJSoJ
         ujXFwDVaFZkkcvTNcuF8OZfGsapU0yhCIAqgdf3T74WSxge+hB3uCXsTx/yipR3Dp+KE
         /qRCzADhKzZD7cUjivnwIIXxPfOSj+gkRsG39Y1dYXzhYxF2owG0PvqUyKN0107TyVYn
         X3+LbXSFgHxrEe0UOEZESOt75/H8YEdzpNzv+TLuRP2hBNENoY4D0Sy8rLRZQWuqbNZq
         1cTw==
X-Gm-Message-State: APjAAAWWGViWk0OTIWPJ23QVG37x+jXFKb/VQxrLj1CKn1pNctUFzFB/
        2rVEC38Di6On+KvC8hXr2x1d4w==
X-Google-Smtp-Source: APXvYqzLO2AY4MikUonMGWLbUw1cnzGTo7DsP/PsiUuAIcFjooUQxIKV9Ku81rDgvyEOx2q7Cg6gpA==
X-Received: by 2002:adf:8364:: with SMTP id 91mr40735060wrd.13.1565616239967;
        Mon, 12 Aug 2019 06:23:59 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id g7sm25060681wmg.8.2019.08.12.06.23.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 06:23:59 -0700 (PDT)
Date:   Mon, 12 Aug 2019 14:23:57 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allison Randal <allison@lohutok.net>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Eddie Huang <eddie.huang@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Richard Fontana <rfontana@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Tianping . Fang" <tianping.fang@mediatek.com>,
        Josef Friedl <josef.friedl@speed.at>
Subject: Re: [PATCH v5 08/10] power: reset: add driver for mt6323 poweroff
Message-ID: <20190812132357.GU26727@dell>
References: <20190812121511.4169-1-frank-w@public-files.de>
 <20190812121511.4169-9-frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190812121511.4169-9-frank-w@public-files.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2019, Frank Wunderlich wrote:

> From: Josef Friedl <josef.friedl@speed.at>
> 
> add poweroff driver for mt6323 and make Makefile and Kconfig-Entries
> 
> Suggested-by: Frank Wunderlich <frank-w@public-files.de>
> Signed-off-by: Josef Friedl <josef.friedl@speed.at>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> changes since v4: none
> changes since v3: none
> changes since v2: none (=v2 part 5)
> ---
>  drivers/power/reset/Kconfig           | 10 +++
>  drivers/power/reset/Makefile          |  1 +
>  drivers/power/reset/mt6323-poweroff.c | 97 +++++++++++++++++++++++++++

>  include/linux/mfd/mt6397/core.h       |  2 +

This looks like an unrelated change.

Please separate it out.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
