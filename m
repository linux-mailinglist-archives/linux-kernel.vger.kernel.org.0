Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E71534D301
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 18:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732320AbfFTQN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 12:13:26 -0400
Received: from foss.arm.com ([217.140.110.172]:46806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732246AbfFTQNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 12:13:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DDF42B;
        Thu, 20 Jun 2019 09:13:24 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E3563F246;
        Thu, 20 Jun 2019 09:13:22 -0700 (PDT)
Date:   Thu, 20 Jun 2019 17:13:19 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     <peng.fan@nxp.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jassisinghbrar@gmail.com>, <f.fainelli@gmail.com>,
        <kernel@pengutronix.de>, <linux-imx@nxp.com>,
        <shawnguo@kernel.org>, <festevam@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <van.freenix@gmail.com>
Subject: Re: [PATCH V2 1/2] DT: mailbox: add binding doc for the ARM SMC
 mailbox
Message-ID: <20190620171319.13dae226@donnerap.cambridge.arm.com>
In-Reply-To: <20190620092241.GC1248@e107155-lin>
References: <20190603083005.4304-1-peng.fan@nxp.com>
        <20190603083005.4304-2-peng.fan@nxp.com>
        <20190620092241.GC1248@e107155-lin>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jun 2019 10:22:41 +0100
Sudeep Holla <sudeep.holla@arm.com> wrote:

> On Mon, Jun 03, 2019 at 04:30:04PM +0800, peng.fan@nxp.com wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> > 
> > The ARM SMC mailbox binding describes a firmware interface to trigger
> > actions in software layers running in the EL2 or EL3 exception levels.
> > The term "ARM" here relates to the SMC instruction as part of the ARM
> > instruction set, not as a standard endorsed by ARM Ltd.
> > 
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> > 
> > V2:
> > Introduce interrupts as a property.
> > 
> > V1:
> > arm,func-ids is still kept as an optional property, because there is no
> > defined SMC funciton id passed from SCMI. So in my test, I still use
> > arm,func-ids for ARM SIP service.
> > 
> >  .../devicetree/bindings/mailbox/arm-smc.txt        | 101 +++++++++++++++++++++
> >  1 file changed, 101 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mailbox/arm-smc.txt b/Documentation/devicetree/bindings/mailbox/arm-smc.txt
> > new file mode 100644
> > index 000000000000..401887118c09
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mailbox/arm-smc.txt
> > @@ -0,0 +1,101 @@
> > +ARM SMC Mailbox Interface
> > +=========================
> > +
> > +This mailbox uses the ARM smc (secure monitor call) instruction to trigger
> > +a mailbox-connected activity in firmware, executing on the very same core
> > +as the caller. By nature this operation is synchronous and this mailbox
> > +provides no way for asynchronous messages to be delivered the other way
> > +round, from firmware to the OS, but asynchronous notification could also
> > +be supported. However the value of r0/w0/x0 the firmware returns after
> > +the smc call is delivered as a received message to the mailbox framework,
> > +so a synchronous communication can be established, for a asynchronous
> > +notification, no value will be returned. The exact meaning of both the
> > +action the mailbox triggers as well as the return value is defined by
> > +their users and is not subject to this binding.
> > +
> > +One use case of this mailbox is the SCMI interface, which uses shared memory
> > +to transfer commands and parameters, and a mailbox to trigger a function
> > +call. This allows SoCs without a separate management processor (or when
> > +such a processor is not available or used) to use this standardized
> > +interface anyway.
> > +
> > +This binding describes no hardware, but establishes a firmware interface.
> > +Upon receiving an SMC using one of the described SMC function identifiers,
> > +the firmware is expected to trigger some mailbox connected functionality.
> > +The communication follows the ARM SMC calling convention[1].
> > +Firmware expects an SMC function identifier in r0 or w0. The supported
> > +identifiers are passed from consumers, or listed in the the arm,func-ids
> > +properties as described below. The firmware can return one value in
> > +the first SMC result register, it is expected to be an error value,
> > +which shall be propagated to the mailbox client.
> > +
> > +Any core which supports the SMC or HVC instruction can be used, as long as
> > +a firmware component running in EL3 or EL2 is handling these calls.
> > +
> > +Mailbox Device Node:
> > +====================
> > +
> > +This node is expected to be a child of the /firmware node.
> > +
> > +Required properties:
> > +--------------------
> > +- compatible:		Shall be "arm,smc-mbox"
> > +- #mbox-cells		Shall be 1 - the index of the channel needed.
> > +- arm,num-chans		The number of channels supported.
> > +- method:		A string, either:
> > +			"hvc": if the driver shall use an HVC call, or
> > +			"smc": if the driver shall use an SMC call.
> > +
> > +Optional properties:
> > +- arm,func-ids		An array of 32-bit values specifying the function
> > +			IDs used by each mailbox channel. Those function IDs
> > +			follow the ARM SMC calling convention standard [1].
> > +			There is one identifier per channel and the number
> > +			of supported channels is determined by the length
> > +			of this array.
> > +- interrupts		SPI interrupts may be listed for notification,
> > +			each channel should use a dedicated interrupt
> > +			line.
> > +  
> 
> I think SMC mailbox as mostly unidirectional/Tx only channel. And the
> interrupts here as stated are for notifications, so I prefer to keep
> them separate channel. I assume SMC call return indicates completion.
> Or do you plan to use these interrupts as the indication for completion
> of the command? I see in patch 2/2 the absence of IRQ is anyway dealt
> the way I mention above.
> 
> Does it make sense or am I missing something here ?

I think you are right. From a mailbox point of view "completion" means
that the trigger has reached the other side. A returning smc call is a
perfect indication of this fact. Whether the action triggered by this
mailbox command has completed is a totally separate question and out of
the scope of the mailbox. This should be handled by a higher level
protocol (SCPI in this case). Which could mean that this employs a
separate return mailbox channel, which is RX only and implemented by
interrupts. Which could or could not be part of this driver.

Cheers,
Andre
