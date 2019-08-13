Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48B0D8C429
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 00:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfHMWOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 18:14:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbfHMWOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 18:14:35 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 368582070D;
        Tue, 13 Aug 2019 22:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565734474;
        bh=6wCizBaaZT2k/09mFrNXRExfBAwJv2YLSMnChPGtw4g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0uaRXv8D5HRtmKK3R9sZVd0gtdGEAJy9OAYrUbynXlMjib/y//8/8b1GMIl0koAge
         zvdeq5RXKS0RUpLgqM+wsU8tmSLaxzBvsjGnlrjpFHlq8frKD/7T7Y1NciVDfSwTpC
         34kSkZyb8+4NWRxQuPpvthHnzOYQkdnd6haJ4Kwc=
Received: by mail-qk1-f178.google.com with SMTP id r4so80901244qkm.13;
        Tue, 13 Aug 2019 15:14:34 -0700 (PDT)
X-Gm-Message-State: APjAAAUmVma8FonAfubrxl1pv6qK7mtjv2TnRGvqIaf5bBr5R15kfheQ
        ObUnbYYi5KqWJY4GJBP6fGEGgMVef9/axznA9g==
X-Google-Smtp-Source: APXvYqwk126OivmGjH6r+ni/zAgOht3m3QXJodkzCFH+TUHs2iVPGSLnoqVVTdkeSVJkGVzE/d/O+3TNCBaPTI7BGz4=
X-Received: by 2002:a37:a48e:: with SMTP id n136mr36131378qke.223.1565734473435;
 Tue, 13 Aug 2019 15:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190807003629.2974-1-andrew@aj.id.au> <20190807003629.2974-2-andrew@aj.id.au>
In-Reply-To: <20190807003629.2974-2-andrew@aj.id.au>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 13 Aug 2019 16:14:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKXda7f43=ZdtTsyrdhdqn+H4L=7zQXtB_EEfHdi=rHLg@mail.gmail.com>
Message-ID: <CAL_JsqKXda7f43=ZdtTsyrdhdqn+H4L=7zQXtB_EEfHdi=rHLg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: mmc: Document Aspeed SD controller
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

On Tue, Aug 6, 2019 at 6:38 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The ASPEED SD/SDIO/MMC controller exposes two slots implementing the
> SDIO Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit
> data bus if only a single slot is enabled.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>
> ---
> v4:
> * Make use of mmc-controller.yaml
> * Document sdhci,auto-cmd12
>
> v2:
> * Fix compatible enums
> * Add AST2600 compatibles
> * Describe #address-cells / #size-cells
> ---
>  .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
