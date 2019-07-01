Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 271381136C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 08:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfEBGgi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 2 May 2019 02:36:38 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38560 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbfEBGgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 02:36:37 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 604792607B5;
        Thu,  2 May 2019 07:36:35 +0100 (BST)
Date:   Thu, 2 May 2019 08:36:32 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Tomasz Figa <tomasz.figa@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        =?UTF-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        bbrezillon@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        David Woodhouse <dwmw2@infradead.org>,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        linux-mtd@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH 4/5] dt-binding: mtd: onenand/samsung: Add device tree
 support
Message-ID: <20190502083632.0ec0fb4e@collabora.com>
In-Reply-To: <CA+Ln22HLqnbbY37FG6CwjZvZH7G35Z+0kNq7XFU4WtZyk_EqZQ@mail.gmail.com>
References: <20190426164224.11327-1-pawel.mikolaj.chmiel@gmail.com>
        <20190426164224.11327-5-pawel.mikolaj.chmiel@gmail.com>
        <20190502015408.GA11612@bogus>
        <CA+Ln22HLqnbbY37FG6CwjZvZH7G35Z+0kNq7XFU4WtZyk_EqZQ@mail.gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

On Thu, 2 May 2019 15:23:33 +0900
Tomasz Figa <tomasz.figa@gmail.com> wrote:

> 2019年5月2日(木) 10:54 Rob Herring <robh@kernel.org>:
> >
> > On Fri, Apr 26, 2019 at 06:42:23PM +0200, Paweł Chmiel wrote:  
> > > From: Tomasz Figa <tomasz.figa@gmail.com>
> > >
> > > This patch adds dt-bindings for Samsung OneNAND driver.
> > >
> > > Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> > > Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > > ---
> > >  .../bindings/mtd/samsung-onenand.txt          | 46 +++++++++++++++++++
> > >  1 file changed, 46 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mtd/samsung-onenand.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/mtd/samsung-onenand.txt b/Documentation/devicetree/bindings/mtd/samsung-onenand.txt
> > > new file mode 100644
> > > index 000000000000..341d97cc1513
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mtd/samsung-onenand.txt
> > > @@ -0,0 +1,46 @@
> > > +Device tree bindings for Samsung SoC OneNAND controller
> > > +
> > > +Required properties:
> > > + - compatible : value should be either of the following.
> > > +   (a) "samsung,s3c6400-onenand" - for onenand controller compatible with
> > > +       S3C6400 SoC,
> > > +   (b) "samsung,s3c6410-onenand" - for onenand controller compatible with
> > > +       S3C6410 SoC,
> > > +   (c) "samsung,s5pc100-onenand" - for onenand controller compatible with
> > > +       S5PC100 SoC,
> > > +   (d) "samsung,s5pv210-onenand" - for onenand controller compatible with
> > > +       S5PC110/S5PV210 SoCs.
> > > +
> > > + - reg : two memory mapped register regions:
> > > +   - first entry: control registers.
> > > +   - second and next entries: memory windows of particular OneNAND chips;
> > > +     for variants a), b) and c) only one is allowed, in case of d) up to
> > > +     two chips can be supported.
> > > +
> > > + - interrupt-parent : phandle of interrupt controller to which the OneNAND
> > > +   controller is wired,  
> >
> > This is implied and can be removed.
> >  
> > > + - interrupts : specifier of interrupt signal to which the OneNAND controller
> > > +   is wired; should contain just one entry.
> > > + - clock-names : should contain two entries:
> > > +   - "bus" - bus clock of the controller,
> > > +   - "onenand" - clock supplied to OneNAND memory.  
> >
> > If the clock just goes to the OneNAND device, then it should be in the
> > nand device node rather than the controller node.
> >  
> 
> (Trying hard to recall the details about this hardware.)
> AFAIR the clock goes to the controller and the controller then feeds
> it to the memory chips.
> 
> Also I don't think we should have any nand device nodes here, since
> the memory itself is only exposed via the controller, which offers
> various queries to probe the memory at runtime, so there is no need to
> describe it in DT.

It's probably true, though not providing this controller/device
separation for NAND controller/devices has proven to be a mistake for
raw NAND controllers (some props apply to the controllers and others to
the NAND device, not to mention that some controllers support
interacting with several chips), so, if that's a new binding, I'd
recommend having this separation even if it's not strictly required.

> 
> > > + - clock: should contain list of phandles and specifiers for all clocks listed
> > > +   in clock-names property.
> > > + - #address-cells : must be 1,
> > > + - #size-cells : must be 1.  
> >
> > This implies some child nodes. What are the child nodes?
> >  
> 
> I can't recall the reason for this unfortunately.

Defining partitions I guess, but we ask people to use the new
representation with a 'partitions' sub-node now, so this should
probably be dropped.

Regards,

Boris
