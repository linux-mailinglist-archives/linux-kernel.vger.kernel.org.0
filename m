Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1477915838B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 20:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbgBJT00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 14:26:26 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41522 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJT0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 14:26:25 -0500
Received: by mail-ed1-f66.google.com with SMTP id c26so1689324eds.8;
        Mon, 10 Feb 2020 11:26:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A9Cj+87fpHuJUDB5pTL1c5qUUiVRuZkzWGgHfyxXfd4=;
        b=Wg3kkPkxx7MBTAvKKjV3vTKg+kj70ANBz/vbEPUtKlVouF0kH/USz5UGWPW2pGqf3k
         d3FGieEcdUdRKpwzhOuclS43sXY0nqYpfI5C7jaCOB+PXCXoKH0tcWIkES6RvUIHhQ44
         0F5dXVJB4OIehRJFC5pzIJc6lQiWpDRHpwOFfEiUc3zoVv9lLDLgLvdRhTdli/7dPH2c
         TpZ/C1+72uuVd934uPEfji7CkXG+mTq8ASLfZL0xRrJVGxe4L4YvWi3W5x356P05lfCW
         LJDSkKzXwDYPSXfr/t5+pTIzU5tW3VXkNGrb4Vei4NsNFk10tSx2kz+ZJEg9u2AhL9y7
         dGsw==
X-Gm-Message-State: APjAAAWbkk8YiL+slIIX/jgAB0ttL7Fp9TQ+9KqTow96MCQr/+4nDeqS
        woCoZYVvUdBArALq4UeXAZ3rcHWNZCM=
X-Google-Smtp-Source: APXvYqyE6lihHWFDfgdtANnknAzo3u1h7XL/1rgXUN+exu2qPVkKC/1PeCKkHaXWWvmvWCTYLoHKcQ==
X-Received: by 2002:a05:6402:1755:: with SMTP id v21mr2522428edx.49.1581362782628;
        Mon, 10 Feb 2020 11:26:22 -0800 (PST)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id bs4sm79813edb.16.2020.02.10.11.26.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Feb 2020 11:26:21 -0800 (PST)
Date:   Mon, 10 Feb 2020 20:26:19 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2] ARM: dts: exynos: Add GPU thermal zone cooling maps
 for Odroid XU3/XU4/HC1
Message-ID: <20200210192619.GB27658@kozik-lap>
References: <CGME20200121070520eucas1p29587eed877efcf6e6b9433440f3c10da@eucas1p2.samsung.com>
 <20200121070510.31520-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200121070510.31520-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 08:05:10AM +0100, Marek Szyprowski wrote:
> Add trip points and cooling maps for GPU thermal zone for Odroid
> XU3/XU4/HC1 boards. Trip points are based on the CPU thermal zone for the
> those boards.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> v2:
> - removed polling-delay related properties for HC1 as requested by Krzysztof
> --
>  arch/arm/boot/dts/exynos5422-odroidhc1.dts    | 30 ++++++++++
>  .../boot/dts/exynos5422-odroidxu3-common.dtsi | 59 +++++++++++++++++++

Thanks, applied.

Best regards,
Krzysztof

