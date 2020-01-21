Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12BE4144809
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 00:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgAUXIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 18:08:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:50644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbgAUXIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 18:08:36 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC09524672;
        Tue, 21 Jan 2020 23:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579648116;
        bh=isyJcTtmLqQY5h7KGj6x7ryAw2JabEkSkewbTWLPkqI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TIHRX+PHjjNRSMOtnjbGuGVcseY9vip3xj4afElS8NZWdyJhL0t5iMH1/zbZ4n7Xq
         SocBH7nxq6j9a3R0gN20ug5W+gbVbmqk3wx9IoWLHCQfN48oxqNMJ1VdT+Flj6DWZ5
         Eb5hn8Jyvue6vBUxFJSTGf+jUoOLMsr88O3yJjcI=
Received: by mail-qt1-f171.google.com with SMTP id e5so4156349qtm.6;
        Tue, 21 Jan 2020 15:08:35 -0800 (PST)
X-Gm-Message-State: APjAAAVZ7p3hjaGGS7dnN3GffDjY/DhHIkgnaMhBih9Moo040iyQlPuT
        GMhoC5XEqYP/GXwk7I6njPxv10bLiVK+x2OSNQ==
X-Google-Smtp-Source: APXvYqwC/GoCff9pALlwjNcY5bRH4J0nuKhoikFBbQMufVBHG5zsv+j5mLtvw7EZee6cFsjyrV5aX0XhEmMo8ukFmmk=
X-Received: by 2002:ac8:59:: with SMTP id i25mr7223067qtg.110.1579648115077;
 Tue, 21 Jan 2020 15:08:35 -0800 (PST)
MIME-Version: 1.0
References: <20200115122908.16954-1-repk@triplefau.lt> <20200115122908.16954-3-repk@triplefau.lt>
 <20200121230512.GA4486@bogus>
In-Reply-To: <20200121230512.GA4486@bogus>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 21 Jan 2020 17:08:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKE09177p6n3a5o2E9s73bSg6MJUo5eJVwKvE8gr3i-=A@mail.gmail.com>
Message-ID: <CAL_JsqKE09177p6n3a5o2E9s73bSg6MJUo5eJVwKvE8gr3i-=A@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] dt-bindings: Add AXG shared MIPI/PCIE PHY bindings
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 5:05 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jan 15, 2020 at 01:29:03PM +0100, Remi Pommarel wrote:
> > Add documentation for the shared MIPI/PCIE PHYs found in AXG SoCs.
> >
> > Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> > ---
> >  .../phy/amlogic,meson-axg-mipi-pcie.yaml      | 34 +++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie.yaml
> > new file mode 100644
> > index 000000000000..3184146318cf
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie.yaml
> > @@ -0,0 +1,34 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright 2019 BayLibre, SAS
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/phy/amlogic,meson-axg-mipi-pcie.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Amlogic AXG shared MIPI/PCIE PHY
> > +
> > +maintainers:
> > +  - Remi Pommarel <repk@triplefau.lt>
> > +
> > +properties:
> > +  compatible:
> > +    const: amlogic,axg-mipi-pcie-phy
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#phy-cells":
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#phy-cells"
>
> Add:
>
> additionalProperties: false
>
>
> With that,
>
> Reviewed-by: Rob Herring <robh@kernel.org>

I missed that I already ack'ed v5, but looks like the same comment
applies to both DT patches.

Rob
