Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9988636DA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 15:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfGINXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 09:23:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfGINXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 09:23:43 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D732E2173C;
        Tue,  9 Jul 2019 13:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562678622;
        bh=K7H1kEUToWNqvM6GLzxoMPgmsavZghV7Gk4tE8OMVuA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BMDvnli6kkiXG+ngJr/QOV7eoM99Hj56OcHJIEUrUFmG5HT9iPtmHOb3f4jaUUOdB
         6bcLtZIUyyA3naNGTvV1BmfvGlhCG80bw3aJqEqbX4/nH0Zd9G4CSmxd656opdvTZA
         9np2sdud2/WALbjhVRHIZAyUfI6it+NR58rTd3U4=
Received: by mail-qt1-f181.google.com with SMTP id k10so13945404qtq.1;
        Tue, 09 Jul 2019 06:23:41 -0700 (PDT)
X-Gm-Message-State: APjAAAWSupyHVpRUccpoEB5eMXyGyi+YS/UIzCqtZHa6gCVKAytABE3H
        OjiCbTepfPGJ12uYrkKtuBzT1Gt+mbFnaOKxBA==
X-Google-Smtp-Source: APXvYqwXw5rsZaC1EdkcqRuJXMS+UsK1zZ4XUkzCc/lt0tG51VKABx6vaV1j0L/3LfwLXwfv1LiayIC8AnFrYJIOq/s=
X-Received: by 2002:ac8:36b9:: with SMTP id a54mr19096579qtc.300.1562678621129;
 Tue, 09 Jul 2019 06:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <1559835388-2578-1-git-send-email-luis.oliveira@synopsys.com>
 <1559835388-2578-3-git-send-email-luis.oliveira@synopsys.com>
 <20190709015220.GA18239@bogus> <MN2PR12MB371095ABA70D43398ABF982CCBF10@MN2PR12MB3710.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB371095ABA70D43398ABF982CCBF10@MN2PR12MB3710.namprd12.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 9 Jul 2019 07:23:28 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKmWNfmsSqe9mTyVGC14LoyKDYONokAxdqoP_5_0ZTKNg@mail.gmail.com>
Message-ID: <CAL_JsqKmWNfmsSqe9mTyVGC14LoyKDYONokAxdqoP_5_0ZTKNg@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] dt-bindings: Document the DesignWare IP reset bindings
To:     Luis de Oliveira <Luis.Oliveira@synopsys.com>
Cc:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 4:33 AM Luis de Oliveira
<Luis.Oliveira@synopsys.com> wrote:
>
> Hi Rob,
>
> Thank you for the comments,
>
> From: Rob Herring <robh@kernel.org>
> Date: Tue, Jul 09, 2019 at 02:52:20
>
> > On Thu, Jun 06, 2019 at 05:36:28PM +0200, Luis Oliveira wrote:
> > > This adds documentation of device tree bindings for the
> > > DesignWare IP reset controller.
> > >
> > > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > > Signed-off-by: Luis Oliveira <luis.oliveira@synopsys.com>
> > > ---
> > > Changelog
> > > - Add active low configuration example
> > > - Fix compatible string in the active high example
> > >
> > >  .../devicetree/bindings/reset/snps,dw-reset.txt    | 30 ++++++++++++++++++++++
> > >  1 file changed, 30 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/reset/snps,dw-reset.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/reset/snps,dw-reset.txt b/Documentation/devicetree/bindings/reset/snps,dw-reset.txt
> > > new file mode 100644
> > > index 0000000..85f3301
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/reset/snps,dw-reset.txt
> > > @@ -0,0 +1,30 @@
> > > +Synopsys DesignWare Reset controller
> > > +=======================================
> > > +
> > > +Please also refer to reset.txt in this directory for common reset
> > > +controller binding usage.
> > > +
> > > +Required properties:
> > > +
> > > +- compatible: should be one of the following.
> > > +   "snps,dw-high-reset" - for active high configuration
> > > +   "snps,dw-low-reset" - for active low configuration
> >
> > This is really a standalone block?
> >
> > Are there versions of IP?
> >
>
> We use this block because is is very simple. The Verilog is autogenerated
> after an simple input configuration (APB config, reset pin number, active
> high/low, etc) so it does not need versioning.
> We use it in almost all our testchips and prototyping, and it is a
> standalone block.

Okay.

Reviewed-by: Rob Herring <robh@kernel.org>
