Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFF665CE6D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 13:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfGBLcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 07:32:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45071 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfGBLcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 07:32:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id f9so17340029wre.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 04:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ap+4a0Iczs2F5AYldnDruok+IC5XLRQCduCYM6ff9V8=;
        b=hkYoSLYv9rxhk0vUNA1UELTrDwsnTyGSuQJ00IYvtkkn+hmVhLhMo+mEQFptemXrEs
         7km0Vcyyq7wEuXgTEWrQzM2zOsQdwzsEjKaTqA3DGr924uE193wd4OzpPX4ZF8kr3emQ
         ThYnX5Sub71jojOdKwn6CdBR6YG1S9FpBtAsud0ZnIcBBCIOcDw96aw/r8i2r8RQrsQU
         4RMBf3gQNpLmpYTeWhjbnZ84IE//j2PV4bZD6A2UWG0RKgynS8skKi8Qi0UVM9Tm34y8
         UqrUM7nqD8qOG+j9MMq7Y9wiJ17LlI75eDAy1D0v/xbI0dJSn7wFFvKf7Lqyk2lEqaOG
         kQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ap+4a0Iczs2F5AYldnDruok+IC5XLRQCduCYM6ff9V8=;
        b=o6vNXfBpigUiUuaL5MYQWkmMrWdNK8yT16vY0Puzcgpb/1rq22+YIJ+Os7Q/YdHheD
         9ZyKRVB6dnWHeJOLtlGKMX24RloSINBqARbb975U88AQWvcNDtGZZtRleVeGVU5F1t7y
         h0Qsm3/XLyfK6r+002aqnhHTJHJtqcGXg0wlz9XblKU06xF6Tled2yOb74fvergAOHJ8
         EEBFDiOKUPxKpVpAKV2iZ6nx4PtFXxZNWZYPsilcq7Jbm5w+1TWiVw1i65VJhc2M+k3v
         BEb2c+3n2cL7ShgzLjzuS/ox6TgxwCzv7odLTuLcwgGwTsKZ4dYw398h6Sh4LBJjxEAY
         0Tdg==
X-Gm-Message-State: APjAAAV9TxUZkpVsFE17wQd0VP8nU0qkTyPwflzPHqO982wfbJ1nUMYF
        KtWIkwluMwL7UlvXv9mwsbzGzg==
X-Google-Smtp-Source: APXvYqw/vmRV42ZW/ikSoURMeou4vdGUN9T4Vrpoi4jwHh6/eNJFws9zBf/O82M2ZZJBNM1IGmxMDg==
X-Received: by 2002:a5d:5706:: with SMTP id a6mr21824501wrv.224.1562067119610;
        Tue, 02 Jul 2019 04:31:59 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id q15sm11657804wrr.19.2019.07.02.04.31.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 04:31:59 -0700 (PDT)
Date:   Tue, 2 Jul 2019 12:31:57 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Mark Brown <broonie@kernel.org>, Keerthy <j-keerthy@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] regulator: lp87565: fix missing break in switch
 statement
Message-ID: <20190702113157.GG4652@dell>
References: <20190627131639.6394-1-colin.king@canonical.com>
 <20190628143628.GJ5379@sirena.org.uk>
 <4cb0e4ab-66c7-2b3d-27d3-fd5cfde8988f@canonical.com>
 <20190702104420.GD4652@dell>
 <4a0a50be-1465-0554-f787-dec72bc07a00@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a0a50be-1465-0554-f787-dec72bc07a00@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Jul 2019, Colin Ian King wrote:

> On 02/07/2019 11:44, Lee Jones wrote:
> > On Fri, 28 Jun 2019, Colin Ian King wrote:
> > 
> >> On 28/06/2019 15:36, Mark Brown wrote:
> >>> On Thu, Jun 27, 2019 at 02:16:39PM +0100, Colin King wrote:
> >>>> From: Colin Ian King <colin.king@canonical.com>
> >>>>
> >>>> Currently the LP87565_DEVICE_TYPE_LP87561_Q1 case does not have a
> >>>> break statement, causing it to fall through to a dev_err message.
> >>>> Fix this by adding in the missing break statement.
> >>>
> >>> This doesn't apply against current code, please check and resend.
> >>>
> >> So it applies cleanly against linux-next, I think the original code
> >> landed in mfd/for-mfd-next - c.f. https://lkml.org/lkml/2019/5/28/550
> > 
> > Applied, thanks Colin.
> > 
> I'm confused, who is the official maintainer of the regulator patches
> nowadays?

Mark.  But the patch you're fixing is currently in the MFD tree.

I sent him an updated pull-request.

Don't worry mate, you're in good hands. ;)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
