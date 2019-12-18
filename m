Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0F7124797
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 14:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfLRNFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 08:05:45 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33077 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfLRNFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 08:05:44 -0500
Received: by mail-io1-f65.google.com with SMTP id z8so1907791ioh.0;
        Wed, 18 Dec 2019 05:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jtI02BX3MhKCqZlbqoLQVhWQvEfC77FuEIUpdmy5BAY=;
        b=aBKakUm1IyTAdGLznrQ6P38rhuzcxBW8hJbBt9thj/VSUe8BS8U0qZy/3JTsM0Wp64
         Ii5UVUHm2seUE3Y1eaIaUMpTuUD//dQYSwn20SzwEzodAiRoBBt5e9lglOEp6KvpDZBd
         Z9MWT9BmNI1ajGsK4hdZXFA+fk647WBQ/Ib8JfWCviAS8HU8x65mfiGcR4cRK5KzjA/Q
         7nEdlAWQvd7mxEHiT8k+Gc5E6N961zRtsBOdkLVM4rsfWPnccC8AedWQr6mHlwSy6vX4
         MXIELFiacE6NpVIALXsUMDis5oTwELtouxvJPgQZT1G2zfX6e/xz/SArpHtdd1jC+YcU
         T5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jtI02BX3MhKCqZlbqoLQVhWQvEfC77FuEIUpdmy5BAY=;
        b=Iizzo/jPPXK+xuf55zItT4AAPur3V3IvSzXcNSe51tbxkLZ7vsQ433pOSBwhgdjVOP
         QxUMBESVgMNZitLg9l2uSncjmRQmhPb22GTDhr/dVxNsmTx6j06dPOmzXMrRCVfWiylN
         kq1181Rncvi9GYbqgs8W1bBRfC/dnCE75LE+TriVS+PPndlM8+8kFBYyN+ZhqVdjfvpb
         LWgQbrk4iiGi0A6pl0N+Hak+XCBoMHX7rsdCAHxzQ2pPVxIjnLwYHG4oWiw0MS7FHDT2
         jt9nOzajdtA1ntcuNnlvFHKpDgkgLU+wtPIsXJAZ9q2u0GSo0mwWZMBgaWmdcI4l7PJ2
         vHwg==
X-Gm-Message-State: APjAAAXi7vqFg+9jz3wMq13lowW910dbVd0NZTJWRouPTvaVcRgB+8Hx
        ovGzgm6g5g8JbE5l/bksEoUGW51eqRkUorsD5OA=
X-Google-Smtp-Source: APXvYqyNAwsARVArObXF0VfIKgBdiiW7WvQbMsAZzjqiVlMZu9krh0jZyV/7Nf2jXTjMZEovn1moXOEZSFAYxGNAIPg=
X-Received: by 2002:a6b:ee07:: with SMTP id i7mr1121712ioh.78.1576674343420;
 Wed, 18 Dec 2019 05:05:43 -0800 (PST)
MIME-Version: 1.0
References: <20191213153910.11235-1-aford173@gmail.com> <20191213153910.11235-3-aford173@gmail.com>
 <VI1PR0402MB3485AB1908AD6B6617CFC08C98500@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <CAHCN7xLrX0R7Uag2vc1qMp4z=1r3haCWrcp4qJT0H0eC3RiA4Q@mail.gmail.com> <CAOMZO5B_CCEf_cdAWs_FDC1c6t0RG1KjRjGidoDPmPmgxY=ebg@mail.gmail.com>
In-Reply-To: <CAOMZO5B_CCEf_cdAWs_FDC1c6t0RG1KjRjGidoDPmPmgxY=ebg@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 18 Dec 2019 07:05:32 -0600
Message-ID: <CAHCN7xLoScZ=b=eZHXnWt4U_Tr-N3XdNg6f9DHejQNc0kYvZUA@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] arm64: defconfig: Enable CRYPTO_DEV_FSL_CAAM
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Horia Geanta <horia.geanta@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 12:25 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Adam,
>
> On Tue, Dec 17, 2019 at 10:07 AM Adam Ford <aford173@gmail.com> wrote:
>
> > Out of curiosity, what is the rule for when things are 'm' vs 'y'?
> >
> > In the Code Aurora repo, it is set to 'y' and the mainline kernel for
> > the i.MX6/7, the imx_v6_v7_defconfig is also set to 'y' which is why I
> > used 'y' here.
> >
> > I can do a V3 to address the other items you noted, but I want to
> > understand the rules about the defconfig so I don't make the same
> > mistake again.
>
> In arch/arm64/configs/defconfig we try to select modules whenever possible.
>
> The exceptions are drivers that are vital for boot such as PMIC,
> pinctrl, clks, etc.
>
> The CAAM driver does not fall into this category, so selecting it as
> module is preferred here.

That makes sense.  Thank you for the clarification.  I'll keep that in
mind if I submit future updates.

adam
>
> Thanks
