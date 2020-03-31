Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E14E1988B8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 02:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbgCaAO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 20:14:26 -0400
Received: from kernel.crashing.org ([76.164.61.194]:33702 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbgCaAO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 20:14:26 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 02V0DJbF013894
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 30 Mar 2020 19:13:23 -0500
Message-ID: <4dc3ac910c79dcca398eb5161dde44e1cc50baca.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 6/6] dt-bindings: usb: document aspeed vhub device
 ID/string properties
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Rob Herring <robh@kernel.org>, rentao.bupt@gmail.com
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Date:   Tue, 31 Mar 2020 11:13:17 +1100
In-Reply-To: <20200330192347.GA6388@bogus>
References: <20200315191632.12536-1-rentao.bupt@gmail.com>
         <20200315191632.12536-7-rentao.bupt@gmail.com>
         <20200330192347.GA6388@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-30 at 13:23 -0600, Rob Herring wrote:
> On Sun, Mar 15, 2020 at 12:16:32PM -0700, rentao.bupt@gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> > 
> > Update device tree binding document for aspeed vhub's device IDs and
> > string properties.
> > 
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > ---
> >  No change in v2:
> >    - the patch is added into the series since v2.
> > 
> >  .../bindings/usb/aspeed,usb-vhub.yaml         | 68 +++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml b/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> > index 06399ba0d9e4..5b2e8d867219 100644
> > --- a/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> > +++ b/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> > @@ -52,6 +52,59 @@ properties:
> >          minimum: 1
> >          maximum: 21
> >  
> > +  vhub-vendor-id:
> > +    description: vhub Vendor ID
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > +      - maximum: 65535
> > +
> > +  vhub-product-id:
> > +    description: vhub Product ID
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > +      - maximum: 65535
> 
> There's already standard 'vendor-id' and 'device-id' properties. Use 
> those.

So yes and no... I don't fundamentally object but keep in mind that
traditionally, the properties are about matching with a physical
hardware.

In this case however, we are describing a virtual piece of HW and so
those IDs are going to be picked up to be exposed as the USB
vendor/device of the vhub on the USB bus.

Not necessarily an issue but it's more "configuration" than "matching"
and as such, it might make sense to expose that with a prefix, though I
would prefer something like usb-vendor-id or usb,vendor-id...

> > +
> > +  vhub-device-revision:
> 
> Specific to USB, not vhub.

Same as the above.

> > +    description: vhub Device Revision in binary-coded decimal
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > +      - maximum: 65535
> > +
> > +  vhub-strings:
> > +    type: object
> > +
> > +    properties:
> > +      '#address-cells':
> > +        const: 1
> > +
> > +      '#size-cells':
> > +        const: 0
> > +
> > +    patternProperties:
> > +      '^string@[0-9a-f]+$':
> > +        type: object
> > +        description: string descriptors of the specific language
> > +
> > +        properties:
> > +          reg:
> > +            maxItems: 1
> > +            description: 16-bit Language Identifier defined by USB-IF
> > +
> > +          manufacturer:
> > +            description: vhub manufacturer
> > +            allOf:
> > +              - $ref: /schemas/types.yaml#/definitions/string
> > +
> > +          product:
> > +            description: vhub product name
> > +            allOf:
> > +              - $ref: /schemas/types.yaml#/definitions/string
> > +
> > +          serial-number:
> > +            description: vhub device serial number
> > +            allOf:
> > +              - $ref: /schemas/types.yaml#/definitions/string
> 
> For all of this, it's USB specific, not vhub specific. I'm not sure this 
> is the right approach. It might be better to just define properties 
> which are just raw USB descriptors rather than inventing some DT format 
> that then has to be converted into USB descriptors.

Raw blob in the DT is rather annoying and leads to hard to parse stuff
for both humans and scripts. The main strenght of the DT is it's easy
to read and manipulate.

Also not the entire descriptor is configurable this way.

That said, it could be that using  the DT for the above is overkill and
instead, we should consider a configfs like the rest of USB gadget.
Though it isn't obvious how to do that, the current gadget stuff
doesn't really "fit" what we need here.

Maybe we could expose the port as UDCs but not actually expose them on
the bus until the hub is "activated" via a special configfs entry...

Cheers,
Ben.

> os the 
> Rob

