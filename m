Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 917526E732
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 16:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfGSOOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 10:14:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727717AbfGSOOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 10:14:43 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9F6B21852;
        Fri, 19 Jul 2019 14:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563545682;
        bh=HouTf0rdYLTSnjqZyT8kFGWdmcB/Edh2viRAAjb5BvM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jFQHJ46HfxLeX5mug34IOev47bDwSkI0gC6X1WpwSnvh/EuVsbBWcMBV9VQ63lRfU
         DMYYUFg/2OCf/IxChe6xdMo3mylF6ar18dhDkSYRLba6hemKkkz7nGfr/OFS08hEn7
         hVWV0j15Wjk2oz8Lr1I4g6I43LBToZ+OuOplHNN8=
Received: by mail-qt1-f178.google.com with SMTP id h21so31042903qtn.13;
        Fri, 19 Jul 2019 07:14:41 -0700 (PDT)
X-Gm-Message-State: APjAAAWvBLjisDYBqsjHE2fJiwKSwzbcMGAUlvubqoAsKAuAM7K+5LSB
        sSxX6FrH1UZN4Wukwwv9X+OXyoK+FxdT2Wbdrw==
X-Google-Smtp-Source: APXvYqyA3UuijcheBwbxYRInvMAtjX6DRagHSFfJNZjUTBbw3FP5/ZDMUKlAiXfMmEcLn5N+HSPr4YKvJIoUvYRh770=
X-Received: by 2002:a0c:baa1:: with SMTP id x33mr38651166qvf.200.1563545681179;
 Fri, 19 Jul 2019 07:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190719070926.29114-1-manivannan.sadhasivam@linaro.org> <20190719070926.29114-3-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190719070926.29114-3-manivannan.sadhasivam@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 19 Jul 2019 08:14:29 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLPWBG+3tPw9TTTcC0vn3-xjsqBtODV-KLPKMO8nUdT0A@mail.gmail.com>
Message-ID: <CAL_JsqLPWBG+3tPw9TTTcC0vn3-xjsqBtODV-KLPKMO8nUdT0A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: Document i.MX8QXP AI_ML board binding
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Darshak.Patel@einfochips.com, kinjan.patel@einfochips.com,
        prajose.john@einfochips.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 1:09 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Document devicetree binding of i.MX8QXP AI_ML board from Einfochips.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
