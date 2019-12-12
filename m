Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E01D11D7D2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 21:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbfLLUVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 15:21:34 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45483 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730707AbfLLUVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 15:21:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so4121525wrj.12;
        Thu, 12 Dec 2019 12:21:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CPNUf9ZfNsHV45XZGqiBQJlUTUhc2MVRp6BnooBqqSc=;
        b=I49SI3JMgbdRmcSyXk+TmA97aoRu3zvvMUs0kL/WAdD/Mrv9aw3KtvpsFz/RmoaXZn
         6AmfJ8t1D8tRGgH+j1qfqxHW4gSIxPW5XAwvR3xdTzJwQ+PsOAPJbTRz7oqzjeLPdL6W
         ldUBE+4+jEoSTF56cnW//gHXmFWMeUrXtUkJN+2OUxpqkScMo1MG5uKlGst5lqaiak0g
         tg5xBOLAk92p+bP5sw0S/oBquvj2wKT8DSgupO68wkWgNPHDlcYiAYno5ktNwMox/y8A
         j15/oMipjfUrZn6XYfv4jmvkbDaJNNdVmFsdmpskEwjxUx3IRDb0xM0HMiyL7UdNMUqM
         xTWg==
X-Gm-Message-State: APjAAAXoLiXSoKA8mIBI7hpHu41k+ZS5h7kwPhFxjr/ZwN3sIyGXsM7c
        xaqv3QYrpLIQO3R7jiE3n0v2lTs+
X-Google-Smtp-Source: APXvYqzzbodyVYL3FNuaGg6Zp/U+21dUGiWWf3SbMNFJoJ0+vWDhCy4pxUgA9VjNMpaXXox/nvLRBw==
X-Received: by 2002:a17:906:3953:: with SMTP id g19mr11516560eje.227.1576182089998;
        Thu, 12 Dec 2019 12:21:29 -0800 (PST)
Received: from kozik-lap ([194.230.155.234])
        by smtp.googlemail.com with ESMTPSA id k36sm2772ede.57.2019.12.12.12.21.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Dec 2019 12:21:29 -0800 (PST)
Date:   Thu, 12 Dec 2019 21:21:26 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stefan Agner <stefan@agner.ch>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2 1/4] ARM: dts: exynos: Correct USB3503 GPIOs polarity
Message-ID: <20191212202126.GA3534@kozik-lap>
References: <20191211144638.24676-1-m.szyprowski@samsung.com>
 <CGME20191211144648eucas1p2065aac523ce190a5c0e6e2b5b11bd5ce@eucas1p2.samsung.com>
 <20191211144638.24676-2-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191211144638.24676-2-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 03:46:35PM +0100, Marek Szyprowski wrote:
> Current USB3503 driver ignores GPIO polarity and always operates as if the
> GPIO lines were flagged as ACTIVE_HIGH. Fix the polarity for the existing
> USB3503 chip applications to match the chip specification and common
> convention for naming the pins. The only pin, which has to be ACTIVE_LOW
> is the reset pin. The remaining are ACTIVE_HIGH. This change allows later
> to fix the USB3503 driver to properly use generic GPIO bindings and read
> polarity from DT.
> 

Thanks, applied (for v5.6).

Best regards,
Krzysztof

