Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32E21B8FC7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 14:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408979AbfITM2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 08:28:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36558 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406113AbfITM2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 08:28:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so6605816wrd.3;
        Fri, 20 Sep 2019 05:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GA3pOvw9cvyvH9sQ+qekD5v2QhBspBBVn0FQG6OPUYU=;
        b=RxjJh/Tbs0notO6fx7MLNPTa/FabYt7579brB6eYll9t36KyZIpMjXvbO8G+yC6QtQ
         vh1wUMaAqqo4QUS1wgO6TIgh2u99ftffUvOmfH5l1dLP+7QYkacj/woGfB/6vyUJKOMU
         UAXnCYYVCTho1x3PgX0avo35EFW0cVB96nJ7CPU9p+GPOgQR8i2qU8xDh+DjYQ6wxJoV
         XNWOYzQ6aon+lGV8vdr/sPwTletI4rSIOCqEn+UGr8n5r1d6UgYX2IfzUIKI1eEaEYud
         JoZZ2hbH1G3+2QwJ2T6ZUvYUkSadWREwPyOA1q1XG/+kUn0KFu0U/FUIX/2Eq3WtpX4q
         II1w==
X-Gm-Message-State: APjAAAXkIY23MXNtRxMeD3Ra9hrlXBdz3jBOxrsrxfbP9IDi+QLxh9LT
        4BVgGi+IC7AGkKc2YGyTQOk=
X-Google-Smtp-Source: APXvYqxmnGq2oEEutMlmvckBo6TPiKxSSizcfXtvJxNZXc6nbSs9KT2dgYsJ0qwY1AyhJqAnzhcTjg==
X-Received: by 2002:a5d:430f:: with SMTP id h15mr11854947wrq.177.1568982499009;
        Fri, 20 Sep 2019 05:28:19 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id n8sm2186709wma.7.2019.09.20.05.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 05:28:18 -0700 (PDT)
Date:   Fri, 20 Sep 2019 14:28:15 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [PATCH 1/2] ARM: dts: exynos: split phandle in dmas property
Message-ID: <20190920122815.GB26862@pi3>
References: <CAL_JsqJ=QWk07y=h7dHFiRrKuE7NGoUr50bu3kiOC+YU8qS9jg@mail.gmail.com>
 <CGME20190920121525eucas1p27562c205c41200221540b720c9084fb4@eucas1p2.samsung.com>
 <20190920121431.31678-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190920121431.31678-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 02:14:30PM +0200, Marek Szyprowski wrote:
> From: Maciej Falkowski <m.falkowski@samsung.com>
> 
> Change representation of phandle array as then
> dt-schema counts number of its items properly.
> 
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi | 14 +++++++-------
>  arch/arm/boot/dts/exynos5410.dtsi |  6 +++---
>  arch/arm/boot/dts/exynos5420.dtsi | 14 +++++++-------
>  3 files changed, 17 insertions(+), 17 deletions(-)

Looks good, I'll take it after merge window but why this is in-reply-to
(inside thread) of completely different patchset?

Best regards,
Krzysztof

