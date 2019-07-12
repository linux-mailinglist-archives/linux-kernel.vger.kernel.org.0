Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57F7D66F7C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 15:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfGLNEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 09:04:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbfGLNEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 09:04:11 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83496216C4;
        Fri, 12 Jul 2019 13:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562936650;
        bh=j08i/yzt8yihm95wbKxIa8ANHeLTJGyB1LowMPZRoQs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tn4/f9n/k299HHdLN0F6ScJZKf/VYffpnnAYh+PPAzA7ZjRWQFYrqKf+oTQV+fuy4
         ACXtzrbqpM/naLe0Cz/a11svW1mUDqExyut4Wh/u8EXdbSDYghpYV5xdCObec1WWpU
         LNbCdcMo3gwFzWE9scGST+eZVaGIXGMXzio+pSbQ=
Received: by mail-qt1-f179.google.com with SMTP id k10so7990455qtq.1;
        Fri, 12 Jul 2019 06:04:10 -0700 (PDT)
X-Gm-Message-State: APjAAAVWKooERTk+d1Vgk3uqzGGJJaXeOFEhtduVtdPg6v8XdYb3lO6I
        GLlMnQ+v9OfBMw/UKxIVh3xi2QbMAyh1cDJyog==
X-Google-Smtp-Source: APXvYqy0Gw33CPTr5i9Ny8C1aCwNSn1BsAcArqdhs4L6Ao3k4lrTO3dV3h27CfJYvsBcR6H2d01/a3fqfjUcmFKloV0=
X-Received: by 2002:a0c:b786:: with SMTP id l6mr6598069qve.148.1562936649734;
 Fri, 12 Jul 2019 06:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190712033214.24713-1-andrew@aj.id.au> <20190712033214.24713-2-andrew@aj.id.au>
In-Reply-To: <20190712033214.24713-2-andrew@aj.id.au>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 12 Jul 2019 07:03:57 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq++J+K2goHiNrHJGnL6vrLjmKhM+vpYO=sTnmv6fm2sog@mail.gmail.com>
Message-ID: <CAL_Jsq++J+K2goHiNrHJGnL6vrLjmKhM+vpYO=sTnmv6fm2sog@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: Document Aspeed SD controller
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Adrian Hunter <adrian.hunter@intel.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ryan Chen <ryanchen.aspeed@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 9:32 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The ASPEED SD/SDIO/eMMC controller exposes two slots implementing the
> SDIO Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit
> data bus if only a single slot is enabled.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
> In v2:
>
> * Rename to aspeed,sdhci.yaml
> * Rename sd-controller compatible
> * Add `maxItems: 1` for reg properties
> * Move sdhci subnode description to patternProperties
> * Drop sdhci compatible requirement
> * #address-cells and #size-cells are required
> * Prevent additional properties
> * Implement explicit ranges in example
> * Remove slot property
>
>  .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
