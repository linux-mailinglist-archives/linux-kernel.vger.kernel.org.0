Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5706BE8EC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 01:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731684AbfIYX3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 19:29:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfIYX3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 19:29:25 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53AFD21D7E;
        Wed, 25 Sep 2019 23:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569454163;
        bh=Ogg+uhTUXRNcF6bTJQEM/wrb2sVSMMLx7Q3Fdy6eWac=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0jz1v3MjS3mMCH8E6uViwYWmbwPNI1iTIFvCgg2g+HqOWPkCtIOwT01xXy6cy/+il
         keRrKEhT6RTgKwp14lw2Eo27EFSeq6flnQMyNKfJ3UqFtnZfyWPEkzwWxmIDzaMkSQ
         lRLbhLNprKDr74pstGkHjAsyUs3aUShzL9/yKEn0=
Received: by mail-qt1-f172.google.com with SMTP id c3so565995qtv.10;
        Wed, 25 Sep 2019 16:29:23 -0700 (PDT)
X-Gm-Message-State: APjAAAXwf0Jay7qCqhlkl094s/SAvIIu6c6L71afaRhWYx5VkEwZd8lL
        c76XSTDZzxAMSVrgJ0JJv2nWkzieldLLZTOW4Q==
X-Google-Smtp-Source: APXvYqyVnFfKD4/M5dyzxw92n4hx9dvyADlYPxaSGLejDMBQ+TSPDAwfcMApLzsyRir8CgdchHqVSeqSR5dpXSyyVWI=
X-Received: by 2002:ac8:444f:: with SMTP id m15mr1101854qtn.110.1569454162399;
 Wed, 25 Sep 2019 16:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190925131252.19359-1-robh@kernel.org> <mhng-c69fa4ff-9752-4ded-8a4f-ae86113bd9ae@palmer-si-x1e>
In-Reply-To: <mhng-c69fa4ff-9752-4ded-8a4f-ae86113bd9ae@palmer-si-x1e>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 25 Sep 2019 18:29:10 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJH59Hh6SkQyyAGkK21dR5DJxzja8GPYd3mg+kEVQ-0EQ@mail.gmail.com>
Message-ID: <CAL_JsqJH59Hh6SkQyyAGkK21dR5DJxzja8GPYd3mg+kEVQ-0EQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: riscv: Fix CPU schema errors
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 4:24 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Wed, 25 Sep 2019 06:12:52 PDT (-0700), robh@kernel.org wrote:
> > Fix the errors in the RiscV CPU DT schema:
> >
> > Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@0: 'timebase-frequency' is a required property
> > Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@1: 'timebase-frequency' is a required property
> > Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@0: compatible:0: 'riscv' is not one of ['sifive,rocket0', 'sifive,e5', 'sifive,e51', 'sifive,u54-mc', 'sifive,u54', 'sifive,u5']
> > Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@0: compatible: ['riscv'] is too short
> > Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@0: 'timebase-frequency' is a required property
> >
> > Fixes: 4fd669a8c487 ("dt-bindings: riscv: convert cpu binding to json-schema")
> > Cc: Paul Walmsley <paul.walmsley@sifive.com>
> > Cc: Palmer Dabbelt <palmer@sifive.com>
> > Cc: Albert Ou <aou@eecs.berkeley.edu>
> > Cc: linux-riscv@lists.infradead.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > v2:
> >  - Add timebase-frequency to simulator example.
> >
> >  .../devicetree/bindings/riscv/cpus.yaml       | 26 ++++++++++---------
> >  1 file changed, 14 insertions(+), 12 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > index b261a3015f84..eb0ef19829b6 100644
> > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > @@ -24,15 +24,17 @@ description: |
> >
> >  properties:
> >    compatible:
> > -    items:
> > -      - enum:
> > -          - sifive,rocket0
> > -          - sifive,e5
> > -          - sifive,e51
> > -          - sifive,u54-mc
> > -          - sifive,u54
> > -          - sifive,u5
> > -      - const: riscv
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - sifive,rocket0
> > +              - sifive,e5
> > +              - sifive,e51
> > +              - sifive,u54-mc
> > +              - sifive,u54
> > +              - sifive,u5
> > +          - const: riscv
> > +      - const: riscv    # Simulator only
> >      description:
> >        Identifies that the hart uses the RISC-V instruction set
> >        and identifies the type of the hart.
> > @@ -67,8 +69,6 @@ properties:
> >        lowercase to simplify parsing.
> >
> >    timebase-frequency:
> > -    type: integer
> > -    minimum: 1
> >      description:
> >        Specifies the clock frequency of the system timer in Hz.
> >        This value is common to all harts on a single system image.
> > @@ -102,9 +102,9 @@ examples:
> >      cpus {
> >          #address-cells = <1>;
> >          #size-cells = <0>;
> > -        timebase-frequency = <1000000>;
> >          cpu@0 {
> >                  clock-frequency = <0>;
> > +                timebase-frequency = <1000000>;
> >                  compatible = "sifive,rocket0", "riscv";
> >                  device_type = "cpu";
> >                  i-cache-block-size = <64>;
> > @@ -120,6 +120,7 @@ examples:
> >          };
> >          cpu@1 {
> >                  clock-frequency = <0>;
> > +                timebase-frequency = <1000000>;
> >                  compatible = "sifive,rocket0", "riscv";
> >                  d-cache-block-size = <64>;
> >                  d-cache-sets = <64>;
> > @@ -153,6 +154,7 @@ examples:
> >                  device_type = "cpu";
> >                  reg = <0>;
> >                  compatible = "riscv";
> > +                timebase-frequency = <1000000>;
> >                  riscv,isa = "rv64imafdc";
> >                  mmu-type = "riscv,sv48";
> >                  interrupt-controller {
>
> Looking at this spec
>
>     https://github.com/devicetree-org/devicetree-specification/releases/download/v0.2/devicetree-specification-v0.2.pdf
>
> section 3.7 says
>
>     Properties that have identical values across cpu nodes may be placed in the
>     /cpus node instead. A client program must
>     first examine a specific cpu node, but if an expected property is not found
>     then it should look at the parent /cpus node.
>     This results in a less verbose representation of properties which are
>     identical across all CPUs.

The cpu sections of the spec are certainly not perfect. They are
largely from PPC with only the most obviously things wrong fixed...

> I can never figure out if I'm looking at the right DT specifications so it's
> possible that is defunct,

Why? What's not clear which one to look at? If you start at
devicetree.org the above is where you end up.

> I just bring this up because we've got an outstanding
> bug in our port where we're not respecting what section 3.7 says and are only
> looking at /cpus/timebase-frequency instead of /cpus/cpu@*/timebase-frequency,
> and I'm wondering if the fix should allow for looking at
> /cpus/timebase-frequency or just not bother.

It's perfectly fine for some deviation for each arch or being more
restrictive. For Arm, we've generally gone the direction of everything
goes into the cpu nodes. So tell me what you want, I just need the
warnings gone.

Rob
