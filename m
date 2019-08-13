Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B44E8B596
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 12:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbfHMKa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 06:30:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51844 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbfHMKa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 06:30:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so1013605wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 03:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FpaQRzjjHieM2ZwGQ/GdoyebOrmSoenQLDvTG9Qi6yI=;
        b=ECIOfaMx8Etdcuaur37ndWisVmkutpI1rFJEIHjhiDwicrUiGrpbpAh/VAWiR4/mk6
         Jys94C59P6dLWKu5BQICoe2FRE77l28OSivWG+JTNpgd8WKtGSQfWBBZVZAd/6GBPYIR
         N7QAM4bNCEBuL4EZ341aigqm61rNC6SklbSxux6Dl/RDvx5m6NoOoWU5WkAo1sULWlGP
         rmInauOV0CaASOC/reQNrVHz2DmC5lwG4koVfD/zwf/6tujmdf9hlG0GpGX3wZHW5mgA
         uLPW4z83TGAcn7qk9nhCXCd2q3i2VQmGjIrY9gblReoQWkp3QwSKnXXrrq/4ZMdLTfKj
         FjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FpaQRzjjHieM2ZwGQ/GdoyebOrmSoenQLDvTG9Qi6yI=;
        b=pVL3i5F6DLj7Ojwk8INNOTGwlqb83qWBpB10ApCZ6xtkPQlp1bbW5iWdqCrdCX7vCS
         RD3ZPrLHYm8WXCXWXf5qGjvQvobiOLivHuRHb/cdmw3nNRMTM5bwy8BatyicqCI82ZJg
         pmnJw8iffkTs6BeRqm3IGeyhrnCAMj2p5iPIQZREiUpGPLakmoUcsVv6yUbifPA+2KAF
         a+uKEIy27tlLAJmI37/yQ7EnWb0KFznl25b80fDB7KhXCsYVUTbP80mArGIs/bcMTuuj
         RJMD3QvhGTBBY+EJWWFS5cjOqeVLcfII1UdNhVw5mlMxA+rY/PBL1n/0ItgCrrwMTEJ5
         Fd9g==
X-Gm-Message-State: APjAAAU8/y0sVOOM5UmAJbYXZj0irh7ojyOziO7fboqq/0FaGcIwBMQp
        m02F59Ov8dmLUOVvX05NqTGYXg==
X-Google-Smtp-Source: APXvYqyN4qrmzO2fFtNWQoBH44tqgLmmkrAsTcojaeG2fQxm4ZfxnFrHwjr1JBuy4GY1YNPhUuoqgg==
X-Received: by 2002:a1c:790b:: with SMTP id l11mr2384506wme.3.1565692225238;
        Tue, 13 Aug 2019 03:30:25 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id a11sm10103044wrx.59.2019.08.13.03.30.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Aug 2019 03:30:24 -0700 (PDT)
Date:   Tue, 13 Aug 2019 11:30:22 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Sebastian Reichel <sre@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, od@zcrc.me,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org,
        Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH 10/11] mfd: Drop obsolete JZ4740 driver
Message-ID: <20190813103022.GB26727@dell>
References: <20190725220215.460-1-paul@crapouillou.net>
 <20190725220215.460-11-paul@crapouillou.net>
 <20190812081640.GA26727@dell>
 <4b48e597-951e-45fd-dfb2-4a1292a8b067@amsat.org>
 <1565690508.1856.0@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1565690508.1856.0@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2019, Paul Cercueil wrote:

> Hi Philippe,
> 
> 
> Le mar. 13 août 2019 à 10:44, Philippe =?iso-8859-1?q?Mathieu-Daud=E9?=
> <f4bug@amsat.org> a écrit :
> > Hi Lee,
> > 
> > On 8/12/19 10:16 AM, Lee Jones wrote:
> > >  On Thu, 25 Jul 2019, Paul Cercueil wrote:
> > > 
> > > >  It has been replaced with the ingenic-iio driver for the ADC.
> > > > 
> > > >  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > > >  Tested-by: Artur Rojek <contact@artur-rojek.eu>
> > > >  ---
> > > >   drivers/mfd/Kconfig      |   9 --
> > > >   drivers/mfd/Makefile     |   1 -
> > > >   drivers/mfd/jz4740-adc.c | 324
> > > > ---------------------------------------
> > > >   3 files changed, 334 deletions(-)
> > > >   delete mode 100644 drivers/mfd/jz4740-adc.c
> > > 
> > >  Applied, thanks.
> > 
> > It seems the replacement is done in "MIPS: qi_lb60: Migrate to
> > devicetree" which is not yet merged.
> 
> It's merged in the MIPS tree, though, so it'll blend together just
> fine in linux-next.

Wonderful.  Thanks Paul.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
