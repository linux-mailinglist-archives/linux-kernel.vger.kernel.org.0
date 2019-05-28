Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 092C82D045
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 22:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfE1U3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 16:29:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44525 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfE1U3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 16:29:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id g9so12180001pfo.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 13:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CH0uDuCm1IZlUutTSqd9yHCBwqxTh5kY/MOarp++qiU=;
        b=Ba1Cm97vb6ARxJQgfFXGjdotGsHAP99t/791OfuTEFhQFlnonFvYATsLPtmM952cBb
         ajhyIOeCIEH27PBz35HtzQmv3gJxOblUx4CDV+xaaHSLjF9wB9h5iRcgoBr1N3KZ0TQ7
         DALG2D46yz9XpmIQQwMbvthZxrRnlJkstuZII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CH0uDuCm1IZlUutTSqd9yHCBwqxTh5kY/MOarp++qiU=;
        b=Ui8oCLi6bmqpQlATfqGRsQ3hXWayH5mxCa5lVBrt8b+3TsPKKY1qC3hBW/p0PVrrmO
         8afZ8WuakXnETl2k70L9rSdU3ttNUA+UYOze0vjNNMprFq5lcMAOUg98CNikgKe375nE
         h7FRjATmlq9ATtCzihhpudaEjSaC5VNkW3ZaUS3kKWPJly/OAKE9d3LLpADNF5o8ZWFu
         Ge3r/Th4cs8RLN9mywQ1iM6i3MtrAfnDfnIM6Rb4o3lFyEwNE2DoHVVBz6KQu0ZtuPGE
         6m6IFzJRSCd8QxCv4FdhkF95cI/CYtmB1GOpHaakSPJ1nO+BA0o+GfJbZ7dhWnQiQgIV
         K42A==
X-Gm-Message-State: APjAAAXAaM4ecdloUMin7fSEXnjfpRkexebqlFKvX9VWV5PrQbgYmbLf
        XxnjJSe260KNobEEz8MXd0fnEQ==
X-Google-Smtp-Source: APXvYqyJR8ErjR2+NyhyJOJUsta+0OAa1/KNcVcMUt+b3JS9GeD6tSPYwwARr6LFNFDtWBcPhMCA2w==
X-Received: by 2002:a63:ff23:: with SMTP id k35mr103694764pgi.139.1559075388740;
        Tue, 28 May 2019 13:29:48 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id f29sm23276944pfq.11.2019.05.28.13.29.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 13:29:47 -0700 (PDT)
Date:   Tue, 28 May 2019 13:29:47 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, briannorris@chromium.org,
        ryandcase@chromium.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: rockchip: Add pin names for rk3288-veyron jaq,
 mickey, speedy
Message-ID: <20190528202947.GL40515@google.com>
References: <20190524233309.45420-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190524233309.45420-1-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 04:33:09PM -0700, Douglas Anderson wrote:
> This is like commit 0ca87bd5baa6 ("ARM: dts: rockchip: Add pin names
> for rk3288-veyron-jerry") and commit ca3516b32cd9 ("ARM: dts:
> rockchip: Add pin names for rk3288-veyron-minnie") but for 3 more
> veyron boards.
> 
> A few notes:
> - While there is most certainly duplication between all the veyron
>   boards, it still feels like it is sane to just have each board have
>   a full list of its pin names.  The format of "gpio-line-names" does
>   not lend itself to one-off overriding and besides it seems sane to
>   more fully match schematic names.  Also note that the extra
>   duplication here is only in source code and is unlikely to ever
>   change (since these boards are shipped).  Duplication in the .dtb
>   files is unavoidable.
> - veyron-jaq and veyron-mighty are very closely related and so I have
>   shared a single list for them both with comments on how they are
>   different.  This is just a typo fix on one of the boards, a possible
>   missing signal on one of the boards (or perhaps I was never given
>   the most recent schematics?) and dealing with the fact that one of
>   the two boards has full sized SD.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org
