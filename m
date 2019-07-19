Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3986E730
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 16:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbfGSOO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 10:14:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727717AbfGSOO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 10:14:26 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EC5521849;
        Fri, 19 Jul 2019 14:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563545665;
        bh=kF4C0rLKo/+VHRKsgi27GKIkFYRreK1n2xTBXnIo9gc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ykkNOiFKx4G8uPPplOyDIFgxgyOL3Cn4pEeXQNdvrx1SuECY1T4+kl7+1erZBMHit
         4poC0dcozMMWNRTjBHHois+rhADbfvnCixa/sQ0EVEoWgmXBPRVznhT2I9lHVSML5P
         UoY/wyNyp9FywRjNuib4aaaN/6vPQpCtocnq+7Yg=
Received: by mail-qt1-f181.google.com with SMTP id 44so72721qtg.11;
        Fri, 19 Jul 2019 07:14:25 -0700 (PDT)
X-Gm-Message-State: APjAAAX6Qr11PAPXK554ISj9TneX/hJFt3n0zqCNKENG/pL9aDaXAzdl
        368fU4cRfEvHUfsOXZvX0AoHdvY0iXy57wwlGQ==
X-Google-Smtp-Source: APXvYqwdoLGbezC/uAf+2Ab30hXChXI///34VWXLnkSvpI9C8M/7R1bDtxX97JliY9U+1ZkAm89c18Jmjzp24uxAW7M=
X-Received: by 2002:aed:3f10:: with SMTP id p16mr37222244qtf.110.1563545664593;
 Fri, 19 Jul 2019 07:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190719070926.29114-1-manivannan.sadhasivam@linaro.org> <20190719070926.29114-2-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190719070926.29114-2-manivannan.sadhasivam@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 19 Jul 2019 08:14:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL5_czQVQbFiiDCEbJH1L0Ov0Jf7WuWSNjJTKdgF5mA+A@mail.gmail.com>
Message-ID: <CAL_JsqL5_czQVQbFiiDCEbJH1L0Ov0Jf7WuWSNjJTKdgF5mA+A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: Add Vendor prefix for Einfochips
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
> Add devicetree vendor prefix for Einfochips.
> https://www.einfochips.com/
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
