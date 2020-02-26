Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD9516FC47
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 11:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgBZKcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 05:32:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52220 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgBZKcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 05:32:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id t23so2394058wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 02:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=w59D/LVQiWX2kMmXZwRywK/7r0DCCnLO8yLj1pspTDM=;
        b=Bbq+sfrSy+mPrK43DZyZF7brUtmbLoK2mr0li4wr2PXtYF8yDGOGIDJzDlvFo/Fwm6
         RgI2jxodLEhCOFcR5bmcQ5cZIAtGVWIiYhaMzGIAbTBK9Uttow1cKv19MS6rTLrApLnn
         2JkQah7TtthyJ4XZJAZiL1UZXH1V/vfxijOPhKnmkNc8RB97nGGKTOpbEXRmHHxvudbq
         7f7xKFFJMfpI3EuemXUayXrstfb8MG4uxIGEO7B/i6Zaqq8u0WjXC92uxFwxh5X2+3kx
         ePcH2vQMVIepb4eyy6G+w4rYEEqbv7JfvJCeFg82AWSwSfn/cHO5DiZC5zvyOcdzFWhg
         vwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=w59D/LVQiWX2kMmXZwRywK/7r0DCCnLO8yLj1pspTDM=;
        b=o7rBvMhuJd8CQy0cUq+N4dfZfsiM6rDOezARPBJP7wJwPIOaiCGvHvDx+8o7oiS22l
         XKqeLJs6FXqTT6ywnV9pGRiu3Ek9EK4cNILFjDesu6BImWFDrDVLy5+BRtnLipcwSV/x
         N0hkABEaEdOVaR8qojYNHkNo8sMmIq3cfC9ilTn1MwotuOIMobpeNOW5HOUCSpgjFHn1
         KFeOyRznd9fhcp9I+a8m5wmsekaRTtfR6LK3lALQo4Ebf2tZzCODSi6l8IGRRMmCZ57n
         oLMoLVp1W+UN/EjKai//3JYiNEajsF1hkyDZIFaTgrE19Ew8CTh2K+tycp4dBCjc4WGH
         7Y4A==
X-Gm-Message-State: APjAAAVDdOzYikDOiSzjBvRsECvEiHu3Fma4axCSeF0DkSJCYkrT7Oxk
        MFKB25zR3ZqNDlza983VoK0BvjcioAs=
X-Google-Smtp-Source: APXvYqw+6JzPd0GKqk4Ny40w87NETlhuo5LnVkzXtMB4r8NPlDMsYZopsIKzOzizRosRMrVwZaZFCQ==
X-Received: by 2002:a1c:9811:: with SMTP id a17mr2297141wme.8.1582713123080;
        Wed, 26 Feb 2020 02:32:03 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id n13sm2412184wmd.21.2020.02.26.02.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 02:32:02 -0800 (PST)
Date:   Wed, 26 Feb 2020 10:32:34 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, smoch@web.de
Subject: Re: [PATCH v2 2/5] mfd: rk808: Ensure suspend/resume hooks always
 work
Message-ID: <20200226103234.GF3494@dell>
References: <cover.1578789410.git.robin.murphy@arm.com>
 <e2cd9aa88c96f69fd931d606e0e70784c3020551.1578789410.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2cd9aa88c96f69fd931d606e0e70784c3020551.1578789410.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jan 2020, Robin Murphy wrote:

> The RK809/RK817 suspend/resume hooks should not have to depend on
> whether this driver owns the pm_power_off hook, and thus the global
> rk808_i2c_client is set - indeed, the GPIO-based control is really
> only relevant when PSCI firmware is in charge of power rather than
> the kernel. As driver model callbacks, they have an appropriate
> device argument to hand, so can just always use that.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/mfd/rk808.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
