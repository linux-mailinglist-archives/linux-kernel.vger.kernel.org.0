Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 031D6F239E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 01:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732920AbfKGAww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 19:52:52 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39017 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbfKGAww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 19:52:52 -0500
Received: by mail-oi1-f193.google.com with SMTP id v138so447627oif.6;
        Wed, 06 Nov 2019 16:52:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bNBnmiV/O0F2tV/c5hmPcF5IquwvqitpsBpHKXWwdd8=;
        b=Xz1hY8bYn3i9UofkB6Aba9Anh9wofnHa4abTfqH1ED526rUfFjfuLOSzbfWwJgaBMy
         IlPIonQ/DDoKlZwMJ4leS0r9ghZzdWtpQ29dlszXhkMRPm+b8ywK3gcFeuNfoydNz9Za
         wzlJL5z2qoJpzyDZR3UMfy1qoy5vPQb1eOv6UD4MvWEckwY3jFKx49SoBY/fTDeN8AVL
         wDK2jYuzLkXP6R0Eb5y0pOicK/xV6nL9xt7zDE+7kLXx9Ctm7ufCJeA9KKBmTle6vuob
         PXv9Z7WIs4WniKNzRh1BCxJBDa7YDctxqBXZ54Jfo+CumX4i6t11nxr9lLY/YL+AzyF8
         AQsA==
X-Gm-Message-State: APjAAAUXS6MSPqoS4/lfKDbIY8YbubgdDmnEfn2UVQn2aHWeN61jUjmm
        pgM5aGWu/we72JY5DLgefg==
X-Google-Smtp-Source: APXvYqyCY4nQynNp+n6/6pCwXxB4zCgESl1l11DWbSH0BoeflOM/MjfcnsL93dCEW+0DsG7lf8PZsw==
X-Received: by 2002:aca:5b89:: with SMTP id p131mr856276oib.52.1573087970613;
        Wed, 06 Nov 2019 16:52:50 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w33sm214006otb.68.2019.11.06.16.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 16:52:49 -0800 (PST)
Date:   Wed, 6 Nov 2019 18:52:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 2/6] dt-bindings: phy: socionext: Add Pro5 support and
 remove Pro4 from usb3-hsphy
Message-ID: <20191107005249.GA26022@bogus>
References: <1573035979-32200-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1573035979-32200-3-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573035979-32200-3-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Nov 2019 19:26:15 +0900, Kunihiko Hayashi wrote:
> This adds compatible string for Pro5 SoC that needs to manage gio clock
> and reset. And Pro4 SoC uses USB2 PHY instead of USB3 HS-PHY, so this
> removes Pro4 description from usb3-hsphy.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  Documentation/devicetree/bindings/phy/uniphier-pcie-phy.txt | 13 +++++++++----
>  .../devicetree/bindings/phy/uniphier-usb3-hsphy.txt         |  6 +++---
>  .../devicetree/bindings/phy/uniphier-usb3-ssphy.txt         |  5 +++--
>  3 files changed, 15 insertions(+), 9 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
