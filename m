Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5EC1290C8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 02:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfLWByp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Dec 2019 20:54:45 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55983 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfLWByp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 20:54:45 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so14441850wmj.5;
        Sun, 22 Dec 2019 17:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UycTJelMMnQoQnSt8tUJ3gK37AUwhncdDUQlcICcFHE=;
        b=PMftAKrW0bFXeq2DS7PAWQokPSxWby6IPAJcs2hckRkxuT9JmBUYGIIwfAidLPiwyH
         7JdB0QFFaNCxPuyfqlZK8yRczIZlFrGJiG1cnNMGFpKO6Hy/toHiPoZz5ulI5kEXl4J+
         nZDKkaKr3IMiBtpTSYO+ARml2LDxYxklZmf3qSlppkm3G7LczPMFsro+SkpWfa7O/Pek
         AMcNiXdxAHc2oBezsUaZs4+MFCkncX2DoIzEaTH7pBakMDunBYtnvcbTtt7PRaYTkhC7
         KWydKtjKzU/Th2Yh8sgTwP5iLswVBvyePOZkUTUX2B1E3Rpry2b2J9fd5bOfeF/YRe2M
         0nKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UycTJelMMnQoQnSt8tUJ3gK37AUwhncdDUQlcICcFHE=;
        b=g7u7V32sl4iite6py/y+2AW8agJrgq5unJ7kRwlZcEW5FB9F7qvDkGRf1nzru6qP7o
         /5HZPeSujqNYXRhLApcDoCZnZLEfjVjbL6fzGgoAVopLVNZvSvjknLaSZNkbTwWxcaY6
         VpPEBodOnVo3fwb2lLtteDAg6jUrIapCTNv80ip1I03UOkyI/xP7s8M9TSd18PfOmn5g
         Jdsxp2uL7yBmFmIVKin8NswHjia4uvvy97KO0gMQbgWii9cGcnVwpEvgmLOWPhycU6/l
         kTvUmbRbSK4gJpmUEVhRMfKibfDhL/BGR79/Tjj7ybKI2U8lMdAFvfU4ZYaNVe5UC0nQ
         uqVQ==
X-Gm-Message-State: APjAAAWnE3PbfvNNB8i7m1cl2t3+dvE4A9sR59p9kNmUNE8VxNydhyY4
        yT2n+HA49R8JkmWILK8lKGyT2QAss+McE7r2Ra4=
X-Google-Smtp-Source: APXvYqyMYg7Mj5U7nXpe2YvVa0qwhG6Vrt8BtHQT6yLV+0sCK8yA0oRPLRFECm+cHHE8qEY0vB1mq7hFNwdeOSncr3U=
X-Received: by 2002:a7b:c74c:: with SMTP id w12mr28607567wmk.1.1577066082723;
 Sun, 22 Dec 2019 17:54:42 -0800 (PST)
MIME-Version: 1.0
References: <20191209114404.22483-1-zhang.lyra@gmail.com> <20191209114404.22483-4-zhang.lyra@gmail.com>
 <20191219183602.GA31035@bogus>
In-Reply-To: <20191219183602.GA31035@bogus>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 23 Dec 2019 09:54:06 +0800
Message-ID: <CAAfSe-uhvyo+7ND8m5=EB+B3A855p345CyNwfwjy5pvhvCC1Vg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] arm64: dts: Add Unisoc's SC9863A SoC support
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Dec 2019 at 02:36, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Dec 09, 2019 at 07:44:04PM +0800, Chunyan Zhang wrote:
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > Add basic DT to support Unisoc's SC9863A, with this patch,
> > the board sp9863a-1h10 can run into console.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> >  arch/arm64/boot/dts/sprd/Makefile         |   3 +-
> >  arch/arm64/boot/dts/sprd/sc9863a.dtsi     | 523 ++++++++++++++++++++++
> >  arch/arm64/boot/dts/sprd/sharkl3.dtsi     | 148 ++++++
> >  arch/arm64/boot/dts/sprd/sp9863a-1h10.dts |  39 ++
> >  4 files changed, 712 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm64/boot/dts/sprd/sc9863a.dtsi
> >  create mode 100644 arch/arm64/boot/dts/sprd/sharkl3.dtsi
> >  create mode 100644 arch/arm64/boot/dts/sprd/sp9863a-1h10.dts
>
>
> > diff --git a/arch/arm64/boot/dts/sprd/sharkl3.dtsi b/arch/arm64/boot/dts/sprd/sharkl3.dtsi
> > new file mode 100644
> > index 000000000000..3b5a94560481
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/sprd/sharkl3.dtsi
> > @@ -0,0 +1,148 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Unisoc Sharkl3 platform DTS file
> > + *
> > + * Copyright (C) 2019, Unisoc Inc.
> > + */
> > +
> > +/ {
> > +     interrupt-parent = <&gic>;
> > +     #address-cells = <2>;
> > +     #size-cells = <2>;
> > +
> > +     soc: soc {
> > +             compatible = "simple-bus";
> > +             #address-cells = <2>;
> > +             #size-cells = <2>;
> > +             ranges;
> > +
> > +             ap_ahb_regs: syscon@20e00000 {
> > +                     compatible = "sprd,sc9863a-glbregs", "syscon";
> > +                     reg = <0 0x20e00000 0 0x4000>;
> > +             };
> > +
> > +             pub_ctrl_regs: syscon@300e0000 {
> > +                     compatible = "sprd,sc9863a-glbregs", "syscon";
>
> Having a bunch of the same compatible doesn't look right. I assume by
> the label names each of these are a different set of registers. The
> compatible should be specific enough the OS can match to a driver that
> knows the register details.
>
> Doesn't look like you use all these, so maybe drop until you do and/or

Ok, I'll drop them in this patchset, and add back when adding clock
nodes which need these syscon nodes.
Let's discuss if these syscons can have the same compatible string then.

Thanks,
Chunyan
