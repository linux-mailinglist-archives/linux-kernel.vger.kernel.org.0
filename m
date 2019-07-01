Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5A5D1789E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 13:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfEHLpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 07:45:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39747 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbfEHLpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 07:45:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id v10so1545878wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 04:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tlwX1TwlUBY6Z37kB2EJ5w9WiIHcYvXReYxAo3ZK/QU=;
        b=aLFaoXIJBRIIYYQi6a34dUkmQ3Qxn+QdslldTwFr/3TeRmdWtnkEXUKnt5cwI64iyS
         E3Z/VyxNSChE4jryrWHmG9WxOPHJyFgX8PCVGm9FkCw0FK/48uk+vFoodfeyXH6xh3dC
         ECnGN20wkM9Aw+TLnn07DGMMyPxOQ07qHmHHS741REuApklwsX5NSnVskZXnzaDWBajC
         yA2DQxXY3Fcn7VQXf3vYtY7BQDtZ+oH3JuF0tz9n3GThksESTNyRgsnqyWVcHm8/VeAf
         H4mEWWWZKDUkGf+FVTX5HnAI2ggA2oYgwa3+zT+xydKTnsftnA6Sc7gQDrtTuhxV/L+C
         YeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tlwX1TwlUBY6Z37kB2EJ5w9WiIHcYvXReYxAo3ZK/QU=;
        b=Fqwoejxv/bLgcQeB110ABItmE1pJJGF2OzPcSCo+uFT0pqsF7gPrRcO3W+k9xCHm4A
         nXpWtLxL/ju3ozcWglIOm2mueBhJy7/qCCMAmpxbhitTL/R5GG6YuBr2QxI2AK8bA4bG
         zEkQqnFCUXqHQLevIFz6mWu2/WbIwfGVIviWYPFPgAfepxgTZw+AinvEoRDv5KCeXaLk
         Jk1Bdsp7rdy1Fnd0EkyKVOwIfOf7S1p2lzixLC0M0C5AP0N40/KAM9CdItcHyXPfDUYO
         kbodVzJDXsjauZEKfbeg0TEcU7WGRnNcW5UcBH6wLuv9AizHZCTsrENWxMpQIn6lQOlT
         N6zQ==
X-Gm-Message-State: APjAAAXhCBaPxq648MG3G0OLL10NG5cY5dKu+geg+PGL7yWcUC3HBc7J
        Q9kKmA1v8ubO3qug8RGHWKXaIw==
X-Google-Smtp-Source: APXvYqykdlP88xzgMGKDUs4qkEmodZQT12LFcXefUZay/XBaDwzQZGh3E3/CFHN5zN+W7WJ3Pyni6A==
X-Received: by 2002:a5d:6249:: with SMTP id m9mr9799370wrv.255.1557315935670;
        Wed, 08 May 2019 04:45:35 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id k67sm2055362wmb.34.2019.05.08.04.45.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 04:45:35 -0700 (PDT)
Date:   Wed, 8 May 2019 12:45:33 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 6/7] iio: adc: sun4i-gpadc-iio: add support for H6
 thermal sensor
Message-ID: <20190508114533.GG31645@dell>
References: <20190503072813.2719-1-tiny.windzz@gmail.com>
 <20190503072813.2719-7-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190503072813.2719-7-tiny.windzz@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 May 2019, Yangtao Li wrote:

> This patch adds support for the H6 ths sensor.
> 
> TODO: calibrate thermal sensor by using information from sid.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c | 65 +++++++++++++++++++++++++++++++
>  include/linux/mfd/sun4i-gpadc.h   |  9 +++++

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
