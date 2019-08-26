Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D14709CE11
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 13:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731120AbfHZLX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 07:23:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730205AbfHZLX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:23:27 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF3CD2184D;
        Mon, 26 Aug 2019 11:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566818605;
        bh=P3wzm05rklhbN75hOLq/WjiIzXuCt+spUv+QP+9z/pY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KZ/IXMGCWMKpcHykahvq3T4l3sFQfMa8VXXkcMIc1V0EdMsIi6H3N/Nxk3sWReVXj
         F+evKbO/9my8qHMCwzXi0wx8pMEvzfclLSpYCr6frOnERtQ0+6y9vj2YGeKul9B1cy
         O7+dNc4sGLRDvy+5L5i3UgZlTBIILJfaNbyc+tVc=
Received: by mail-qt1-f182.google.com with SMTP id q64so5760030qtd.5;
        Mon, 26 Aug 2019 04:23:25 -0700 (PDT)
X-Gm-Message-State: APjAAAWDDjxMK72X66ExWkVFaCUJmRLVkcWcjGPtdg1vGyPnvbPDCKwj
        ltbQ7wyiw8r3VHuDSYhy0ZJJeYcv5/1uU1WD0A==
X-Google-Smtp-Source: APXvYqwG9J6og3J0xjCmmC/WIHvxWBq981aqz9OEYjrmYbfV8U+mQ+VvoKo6ppCXc5KSsAQCvNacYiV0++dI2LrnDxQ=
X-Received: by 2002:ac8:44c4:: with SMTP id b4mr16841292qto.224.1566818604932;
 Mon, 26 Aug 2019 04:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <42039170811f798b8edc66bf85166aefe7dbc903.1566531960.git.eswara.kota@linux.intel.com>
 <CAL_JsqJxh5TzDb8kOFm+F5Gs4WXF6BP5uaNPLcyx+srtaDisMw@mail.gmail.com> <746ed130-a1ae-0cc2-5060-70de95cdf2fe@linux.intel.com>
In-Reply-To: <746ed130-a1ae-0cc2-5060-70de95cdf2fe@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 26 Aug 2019 06:23:13 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLSU6+5umYeVmh1NYTcpUcpJKMt7d4d+5E+Ni5rqKJvxQ@mail.gmail.com>
Message-ID: <CAL_JsqLSU6+5umYeVmh1NYTcpUcpJKMt7d4d+5E+Ni5rqKJvxQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: reset: Add YAML schemas for the Intel
 Reset controller
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 4:52 AM Dilip Kota <eswara.kota@linux.intel.com> wrote:
>
> Hi Rob,
>
> On 8/23/2019 8:25 PM, Rob Herring wrote:
> > On Fri, Aug 23, 2019 at 12:28 AM Dilip Kota <eswara.kota@linux.intel.com> wrote:
> >> Add YAML schemas for the reset controller on Intel
> >> Lightening Mountain (LGM) SoC.
> >>
> >> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> >> ---
> >> Changes on v2:
> >>      Address review comments
> >>        Update the compatible property definition
> >>        Add description for reset-cells
> >>        Add 'additionalProperties: false' property
> >>
> >>   .../bindings/reset/intel,syscon-reset.yaml         | 53 ++++++++++++++++++++++
> >>   1 file changed, 53 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/reset/intel,syscon-reset.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/reset/intel,syscon-reset.yaml b/Documentation/devicetree/bindings/reset/intel,syscon-reset.yaml
> >> new file mode 100644
> >> index 000000000000..3403a967190a
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/reset/intel,syscon-reset.yaml
> >> @@ -0,0 +1,53 @@
> >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/reset/intel,syscon-reset.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Intel Lightening Mountain SoC System Reset Controller
> >> +
> >> +maintainers:
> >> +  - Dilip Kota <eswara.kota@linux.intel.com>
> >> +
> >> +properties:
> >> +  compatible:
> >> +    items:
> >> +      - const: intel,rcu-lgm
> >> +      - const: syscon
> >> +
> >> +  reg:
> >> +    description: Reset controller register base address and size
> >> +
> >> +  intel,global-reset:
> >> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> >> +    description: Global reset register offset and bit offset.
> >> +
> >> +  "#reset-cells":
> >> +    const: 2
> >> +    description: |
> >> +      The 1st cell is the register offset.
> >> +      The 2nd cell is the bit offset in the register.
> >> +
> >> +required:
> >> +  - compatible
> >> +  - reg
> >> +  - intel,global-reset
> >> +  - "#reset-cells"
> >> +
> >> +additionalProperties: false
> >> +
> >> +examples:
> >> +  - |
> >> +    rcu0: reset-controller@00000000 {
> >> +        compatible = "intel,rcu-lgm", "syscon";
> >> +        reg = <0x000000 0x80000>;
> >> +        intel,global-reset = <0x10 30>;
> >> +        #reset-cells = <2>;
> >> +    };
> >> +
> >> +    pcie_phy0: pciephy@... {
> >> +        ...
> > You need to run 'make dt_binding_check' and fix the warnings. The
> > example has to be buildable and it is not.
>
> Sure, i  will correct this pcie_phy0 node. But i didn't get any warnings
> for make dt_binding_check
>
>    CHKDT Documentation/devicetree/bindings/reset/intel,syscon-reset.yaml
> DTC Documentation/devicetree/bindings/arm/renesas.example.dt.yaml
> FATAL ERROR: Unknown output format "yaml"
>
> Will DTC report about the example node errors? But, DTC is failing with
> FATAL_ERROR.
> I tried it even after installing libyaml and headers in my local
> directory and export the path, but no luck.(ref:
> https://lkml.org/lkml/2018/12/3/951)
> Could you please let me know if i miss anything and help me to proceed
> further.

See Documentation/devicetree/writing-schema.md

Rob
