Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F87B8278B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 00:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbfHEWVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 18:21:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728851AbfHEWVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 18:21:18 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99C1D216B7;
        Mon,  5 Aug 2019 22:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565043677;
        bh=Y+a5+dRoi0YVw6gPz9RVozw6iDMpBq9OZh+AXfZi5Is=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=z/afeF4DRV9zUHEkPb+3qW3XLRei+MecL3vBZUcAqIZnRVD3TzEdFABt9R7Gyx8+2
         mC4ULdgCWDa0KHGMotuto6AT7glPsJk8Gi4J1S9XTjokZW1S8RGbjpGIhEFQH2mQAx
         3owQagg6CtWhorEXMf6owMkDj/bpNJ8iOYzIe//g=
Received: by mail-qt1-f181.google.com with SMTP id x22so9210201qtp.12;
        Mon, 05 Aug 2019 15:21:17 -0700 (PDT)
X-Gm-Message-State: APjAAAX4ooGQlttR+BNBw5VqcxvAjhGAj2dqu019gT/5H/JKjMg7EFX+
        RLNsZRwFBJqg0Ym7lsHyorSDOZmEDHg1Lx6j8g==
X-Google-Smtp-Source: APXvYqyG5ow10xlO87/4O5/N0US5x/vWmMvRNW7227/h0HIqSzUYZ0L7Wk/nO+vhCYUgRIXKhM/9We9oSL2w6AZTwf8=
X-Received: by 2002:a0c:8a43:: with SMTP id 3mr283692qvu.138.1565043676810;
 Mon, 05 Aug 2019 15:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190731124000.22072-1-narmstrong@baylibre.com>
 <20190731124000.22072-3-narmstrong@baylibre.com> <7hblx3gua3.fsf@baylibre.com>
In-Reply-To: <7hblx3gua3.fsf@baylibre.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 5 Aug 2019 16:21:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL_L2qHe334sB57hR_coRhawKiqXYjKAQDJt_DHfBamBQ@mail.gmail.com>
Message-ID: <CAL_JsqL_L2qHe334sB57hR_coRhawKiqXYjKAQDJt_DHfBamBQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: arm: amlogic: add bindings for G12B
 based S922X SoC
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 5, 2019 at 3:46 PM Kevin Hilman <khilman@baylibre.com> wrote:
>
> Neil Armstrong <narmstrong@baylibre.com> writes:
>
> > Add a specific compatible for the Amlogic G12B family based S922X SoC
> > to differentiate with the A311D SoC from the same family.
> >
> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> > ---
> >  Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
> > index 325c6fd3566d..3c3bc806cd23 100644
> > --- a/Documentation/devicetree/bindings/arm/amlogic.yaml
> > +++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
> > @@ -139,6 +139,7 @@ properties:
> >          items:
> >            - enum:
> >                - hardkernel,odroid-n2
> > +          - const: amlogic,s922x
> >            - const: amlogic,g12b
>
> nit: in previous binding docs, we were trying to keep these sorted
> alphabetically.  I'll reorder the new "s922x" after "g12b" when
> applying.

No, this is not documentation ordering. It's the order compatible
strings must be in.

Rob
