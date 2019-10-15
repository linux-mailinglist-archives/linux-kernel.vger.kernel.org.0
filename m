Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4F8D751C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 13:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbfJOLfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 07:35:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728061AbfJOLfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:35:12 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEC5F21D71;
        Tue, 15 Oct 2019 11:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571139312;
        bh=RmwTSDIV8FwauP/TKSSY3ZDlw7e1niXdhbfrZ3cn/3U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G0WeyfkMI8DUD6k61eGb9P15FohcAbMve2CgAE71mA3q0NuhSFaIOCYWT+ANYz48D
         j7UQl8M4Uc8QXB/vzKMB3Uu3pUcir3dR6wceFeR5ZYk5hNrvxA7JsCU/pOj6LX1Ft8
         EsI3IjAGOKwQBxelIRslQ/SWxt142ZO17244Iohg=
Received: by mail-qt1-f173.google.com with SMTP id 3so30074954qta.1;
        Tue, 15 Oct 2019 04:35:11 -0700 (PDT)
X-Gm-Message-State: APjAAAU4EcrbLmnmNHiyYJKgkzxFtnr0vtcRFDQ+CbcSLXB8VGVhdBjF
        2MWkZp0j2wSyyM+ZfX9Sp7EGruyKB1sjvTL0uQ==
X-Google-Smtp-Source: APXvYqwV4ka+h8Ai6FzlPXTB/SteBHk/rshSYgJyQG3n6WwcEMODovifEQMVxtQT5VJ5SFVHSgIdavwnJcXTiUug4Fg=
X-Received: by 2002:ac8:44d9:: with SMTP id b25mr39135730qto.300.1571139311121;
 Tue, 15 Oct 2019 04:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <20191011154423.2506-1-srinivas.kandagatla@linaro.org>
 <20191011154423.2506-2-srinivas.kandagatla@linaro.org> <20191014171241.GA24989@bogus>
 <76be1a0d-43ea-44c3-ef6c-9f9a2025c7a2@linaro.org>
In-Reply-To: <76be1a0d-43ea-44c3-ef6c-9f9a2025c7a2@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 15 Oct 2019 06:35:00 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+ZBhh2A3yLtOyReHHAET_bvM-ygBtRXeFihAxf0jvDKQ@mail.gmail.com>
Message-ID: <CAL_Jsq+ZBhh2A3yLtOyReHHAET_bvM-ygBtRXeFihAxf0jvDKQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: soundwire: add bindings for Qcom controller
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Vinod <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        spapothi@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 12:34 PM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> Thanks Rob for taking time to review,
>
> On 14/10/2019 18:12, Rob Herring wrote:
> > On Fri, Oct 11, 2019 at 04:44:22PM +0100, Srinivas Kandagatla wrote:
> >> This patch adds bindings for Qualcomm soundwire controller.
> >>
> >> Qualcomm SoundWire Master controller is present in most Qualcomm SoCs
> >> either integrated as part of WCD audio codecs via slimbus or
> >> as part of SOC I/O.
> >>
> >> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> >> ---
> >>   .../bindings/soundwire/qcom,sdw.txt           | 167 ++++++++++++++++++
> >>   1 file changed, 167 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
> >
> > Next time, do a DT schema.
> >
> Sure! I can do that in next version!

I meant the next binding you write, not v4. However, ...

[...]

> >> += SoundWire devices
> >> +Each subnode of the bus represents SoundWire device attached to it.
> >> +The properties of these nodes are defined by the individual bindings.
> >
> > Is there some sort of addressing that needs to be defined?
> >
> Thanks, Looks like I missed that here.
>
> it should be something like this,
>
> #address-cells = <2>;
> #size-cells = <0>;
>
> Will add the in next version.

You need a common soundwire binding for this. You also need to define
the format of 'reg' and unit addresses. And it needs to be a schema.
So perhaps this binding too should be.

Rob
