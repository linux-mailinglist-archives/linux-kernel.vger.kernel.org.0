Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98C221808B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 21:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfEHTgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 15:36:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727489AbfEHTgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 15:36:33 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 320DE21726;
        Wed,  8 May 2019 19:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557344193;
        bh=DqVTjE4LFJnnrk9vaK+F07bBDfW8tTZdklTQDCx5j/s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DtVkVeR2XO4S9y1KtHJyMJs/LPEnXHCUCylF1FahSO4+SsX1MEm3bmruobKY5qjHA
         ElstAieJuxqFGs/yCa/8Sr/fiUfoS+ugrc5qGaqVmg1v7kGp/lNSa7Pasl/c6qX9bY
         /WCRpVznsMcA3f7G36sG5yIFENrURdevVB0JQBQU=
Received: by mail-qt1-f179.google.com with SMTP id r3so14752991qtp.10;
        Wed, 08 May 2019 12:36:33 -0700 (PDT)
X-Gm-Message-State: APjAAAXlDDujVgWt6XB+85pGIHlHx+cETyHsrCO/aT5bN3Vh9BEMiAip
        7G70RsvAA7Xiphbchm4CiVMBcJCZIy0R2/tRmw==
X-Google-Smtp-Source: APXvYqyBw4JKTRiOyULiIz6yWl7y0bp4QJrtcZHDkc9UAdy+rmNa8gC3F9JKED6HRIGCOSF9cdvbndRh10zlX7jRsvM=
X-Received: by 2002:a0c:f68e:: with SMTP id p14mr3772541qvn.77.1557344192469;
 Wed, 08 May 2019 12:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190508135501.17578-1-pramod.kumar_1@nxp.com> <20190508135501.17578-2-pramod.kumar_1@nxp.com>
In-Reply-To: <20190508135501.17578-2-pramod.kumar_1@nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 8 May 2019 14:36:21 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ2Z7d-efhfND5jVgkWRvgtirKUT5_-wanprqfuyPPQwg@mail.gmail.com>
Message-ID: <CAL_JsqJ2Z7d-efhfND5jVgkWRvgtirKUT5_-wanprqfuyPPQwg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: Add device tree binding for
 ls1046a-frwy board
To:     Pramod Kumar <pramod.kumar_1@nxp.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "Michal.Vokac@ysoft.com" <Michal.Vokac@ysoft.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 8, 2019 at 8:53 AM Pramod Kumar <pramod.kumar_1@nxp.com> wrote:
>
> Add "fsl,ls1046a-frwy" bindings for ls1046afrwy board based on ls1046a SoC
>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Signed-off-by: Pramod Kumar <pramod.kumar_1@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
