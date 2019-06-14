Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F41FC464E3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 18:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfFNQrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 12:47:06 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43188 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfFNQrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:47:06 -0400
Received: by mail-qk1-f193.google.com with SMTP id m14so2065369qka.10;
        Fri, 14 Jun 2019 09:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IOo1pvRWjmacOSCq3ogqjxZuWWdGzC13ArgyKbSDaEM=;
        b=pIgqRVu/5opph7p8aRo9Y1JBiXGzTFmXQS7AOCqWN7MuJ9BxdXsrK3IhqV0mF9CC/b
         zbwmhJCBAd7My2fRWcHHedV/BTzjJHBFuqQysr1KPvLyquszP8PwMLC8Nazk4YKmcHhS
         3732X4UcxbO+2wflc7vy/I1qi+HdJRhR45bK/2wAt1LXkepUs6YxjAVZS2XrE7EIKAbB
         emRN14Rbu9dtwZ3upM8vXuKBm5KMnctL8CIrcaRsN7Um34E+aXy5CN9xt7cRfZ9l9DIa
         +Mg2VqLChBJhWfoXqz1cojTki1EefYj3Zm3KfCP9es/7g/SqWjQsCuHzX/ZFEQeDORoU
         9C1w==
X-Gm-Message-State: APjAAAUG8ZM1owNy9eh15xxXvCBNyMB1uLiMgScj+/wX1PFyL9TPcC0O
        4CgeBcOLOb/buc0nmc+fTw==
X-Google-Smtp-Source: APXvYqwI93cayeCpqkq1zgPJZnyXYH8EbxpzVgERa0diD8d8GwuLWqKf0sVGvoLXazEVSJSYS9lgBg==
X-Received: by 2002:a37:d8e:: with SMTP id 136mr63465224qkn.259.1560530825285;
        Fri, 14 Jun 2019 09:47:05 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id j184sm1878283qkc.65.2019.06.14.09.47.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 09:47:04 -0700 (PDT)
Date:   Fri, 14 Jun 2019 10:47:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Justin Swartz <justin.swartz@risingedge.co.za>
Cc:     Sandy Huang <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Justin Swartz <justin.swartz@risingedge.co.za>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: dw_hdmi: add basic rk3228 support
Message-ID: <20190614164702.GA20322@bogus>
References: <20190522224631.25164-1-justin.swartz@risingedge.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522224631.25164-1-justin.swartz@risingedge.co.za>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019 22:46:29 +0000, Justin Swartz wrote:
> Like the RK3328, RK322x SoCs offer a Synopsis DesignWare HDMI transmitter
> and an Innosilicon HDMI PHY.
> 
> Add a new dw_hdmi_plat_data struct, rk3228_hdmi_drv_data.
> Assign a set of mostly generic rk3228_hdmi_phy_ops functions.
> Add dw_hdmi_rk3228_setup_hpd() to enable the HDMI HPD and DDC lines.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
> ---
>  .../bindings/display/rockchip/dw_hdmi-rockchip.txt |  1 +
>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        | 53 ++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
