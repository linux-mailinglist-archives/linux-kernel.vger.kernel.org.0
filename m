Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD21C8D50
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 17:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbfJBPst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 11:48:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51661 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfJBPss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 11:48:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so7770115wme.1;
        Wed, 02 Oct 2019 08:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L+hxNaDSGun9WXAKThcVXAhiXWk+/gt73mQz7EUTjWo=;
        b=BqaLRTTncpF84Gsoz/HZErrAv5pXFEmj9k5QwkKYcLmnV3EsaaP05XRx5yD1rGh12e
         fcKKrdwpwqjGRKI7yr9/ef7BRmo6dIdh8gEJpYLSLDqV4cCyK7S84M9QuK++8/2hlkfr
         JWpze7jLEOdilE7ZO1KCzbUdjOfDE7cOewqzj0/2U/S2eV6Pw2w5ycbm2AMG+1VWNSeu
         IUGgcdocJR7U2xvhrkCqYk/+9CvUZJQR+OGm+tsrI6L6Cxp7WG1OVLriA8zNYRqqDD89
         zwuK/t1qNe8FOqZuXCA77xd/4/qQvOm5i8lFE7hN83rJdrkXhkcI5SI5geYNdGRT2vad
         O2fA==
X-Gm-Message-State: APjAAAVDaKmNlbEXct84nZYNSjPODn/6FddVpspfx1qd2YcauSdM2vla
        3EO7yeMrwDCXd7xFxzV8LcXkkuav
X-Google-Smtp-Source: APXvYqzw/rAoksd2h8xVjx1/aL0+itOfDm4AXqGRq+B96m/2GvsWHUhTmg85JDurWQYKSx+2fLR1AQ==
X-Received: by 2002:a7b:cf1a:: with SMTP id l26mr3644534wmg.38.1570031326159;
        Wed, 02 Oct 2019 08:48:46 -0700 (PDT)
Received: from kozik-lap ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id q15sm42255773wrg.65.2019.10.02.08.48.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Oct 2019 08:48:45 -0700 (PDT)
Date:   Wed, 2 Oct 2019 17:48:43 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Maciej Falkowski <m.falkowski@samsung.com>,
        mark.rutland@arm.com, robh@kernel.org, a.hajda@samsung.com
Subject: Re: [PATCH v2 resend] ARM: dts: exynos: remove obsolete IRQ lines
Message-ID: <20191002154843.GB4072@kozik-lap>
References: <CAJKOXPcs5K46U9mF8evCpbEap_j0Sd5kUk-xiWjwyihAL7te=Q@mail.gmail.com>
 <CGME20190919134622eucas1p1947abc201f86d414bd0b0635f2d91cfe@eucas1p1.samsung.com>
 <20190919134547.11671-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190919134547.11671-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 03:45:47PM +0200, Marek Szyprowski wrote:
> From: Maciej Falkowski <m.falkowski@samsung.com>
> 
> In commit 7222e8db2d50 ("iommu/exynos: Fix build errors") Exynos3250
> iommu driver stopped supporting two IRQ lines. The second IRQ line in DTS
> is ignored and is not needed.
> 
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos3250.dtsi | 9 +++------

Thanks, applied.

Best regards,
Krzysztof

