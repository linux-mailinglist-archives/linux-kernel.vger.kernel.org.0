Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 347E2126F77
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 22:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfLSVMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 16:12:25 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:36977 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726967AbfLSVMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 16:12:25 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3923122614;
        Thu, 19 Dec 2019 16:12:24 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Thu, 19 Dec 2019 16:12:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=eznQB8qUZinkMYctriI1OeMIbCpVh3R
        vgB+uxFjKcWw=; b=e+qOP6LoW0qwuw9Uy2AdChYbjp/8fd4FmeD+84lql6Nzysg
        Q5EEtzLFgHTT4ZLHh61HJ3qfKWvstLoYMaQrkZDYYqDwd+/zKtbxRnfqHZvssd91
        sa37bQFA3ZnScxeTGmW9ZjFJJ6S6BUXGfzGwne2LNEp2+t39dMIey0l/kcEqJ/jf
        KuoHCdqSRnnlSJE6K2MO0oGjIlnYwDst1a6oCn20bsFT7pkrRDNexhBRPrYEp4pF
        AeUu0E7nVJPmFPYwutsxS2gCIpHJQ1LEeEeNPgqn9lu21kUEwM2L/Dtg8atJzYcx
        rXLZ8tlvkMR91AXdifiCjEFsx63JqF1zjoUPimg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=eznQB8
        qUZinkMYctriI1OeMIbCpVh3RvgB+uxFjKcWw=; b=vsijnZkHJ3FMzCkUiKcL/U
        9L2QM7/PfasuZQQGhBbkj6zuYKUg9J4j6/FtNjCRMvQgwzsHNR+mgyg4WOr/3+6D
        jroxkgIdapQ337qTg8dFfeorONhrceuRpKegqiNJ/CGVUasNQJJgxjhrTTf1Ouas
        0yf4CYMM66dvboAwxoJbnEVpsfoH/8vTuyZQfw9K+Ooa1cW02iYSsar+rNxoYkvH
        uyLPbv2DjLJ6PvMf234WqpBZ7KQjTnwHnFyDRugNHU/6Hzt0CFHp8fvxABEf+jRt
        2wwRdtzJQHdlw5nrI7fojEYgc43hr6xs6XrySKUtfa6OVS0ih8duOsQrRFJqVjrQ
        ==
X-ME-Sender: <xms:tuf7XUAaIrlSc6I45LWw2QxR5lOYMlGrotBtz_xGl7gxiUHW-ruOfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdduuddgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrg
    hrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushht
    vghrufhiiigvpedt
X-ME-Proxy: <xmx:tuf7Xa3aCNRbF3LPHQcfxXsNjuVdhABKVgQG6pYJLc7jD4ZpzNcPOw>
    <xmx:tuf7XSeMGytFWFt3f20NPqk0cXpG8bYoHcBsQ0c8CiCX_zuuSy3JcQ>
    <xmx:tuf7XV9O5L_xCSl87Fbmbikz6JmWYGgydNveAvZ7CmNcKyvdi0F13Q>
    <xmx:uOf7XWcf9HHjmavtyrAGPWnGqeSSywyNzMQrvAK59HtZIT99pec4FA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A5516E00A3; Thu, 19 Dec 2019 16:12:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-694-gd5bab98-fmstable-20191218v1
Mime-Version: 1.0
Message-Id: <a0b5728c-4022-4cfb-bcd1-8816e4d80e4a@www.fastmail.com>
In-Reply-To: <45cabf88-063d-aea1-6c2b-fa8cc0d8cbd3@linux.ibm.com>
References: <1576681778-18737-1-git-send-email-eajames@linux.ibm.com>
 <1576681778-18737-6-git-send-email-eajames@linux.ibm.com>
 <73cbffea-89f1-4212-99af-10c32968cf15@www.fastmail.com>
 <45cabf88-063d-aea1-6c2b-fa8cc0d8cbd3@linux.ibm.com>
Date:   Fri, 20 Dec 2019 07:44:05 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>,
        linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, "Jason Cooper" <jason@lakedaemon.net>,
        "Marc Zyngier" <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, tglx@linutronix.de,
        "Joel Stanley" <joel@jms.id.au>
Subject: Re: [PATCH v3 05/12] dt-bindings: soc: Add Aspeed XDMA Engine
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Dec 2019, at 02:18, Eddie James wrote:
> 
> On 12/18/19 5:12 PM, Andrew Jeffery wrote:
> >
> > On Thu, 19 Dec 2019, at 01:39, Eddie James wrote:
> >> Document the bindings for the Aspeed AST25XX and AST26XX XDMA engine.
> >>
> >> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> >> Reviewed-by: Rob Herring <robh@kernel.org>
> >> ---
> >> Changes since v2:
> >>   - Remove 'sdmc', rename 'vga-mem' to 'memory'
> >>
> >>   .../devicetree/bindings/soc/aspeed/xdma.txt   | 40 +++++++++++++++++++
> >>   MAINTAINERS                                   |  6 +++
> >>   2 files changed, 46 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> >> b/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> >> new file mode 100644
> >> index 000000000000..58253ea1587b
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> >> @@ -0,0 +1,40 @@
> >> +Aspeed AST25XX and AST26XX XDMA Engine
> >> +
> >> +The XDMA Engine embedded in the AST2500 and AST2600 SOCs can perform
> >> automatic
> >> +DMA operations over PCI between the SOC (acting as a BMC) and a host
> >> processor.
> >> +
> >> +Required properties:
> >> + - compatible		: must be "aspeed,ast2500-xdma" or
> >> +			  "aspeed,ast2600-xdma"
> >> + - reg			: contains the address and size of the memory region
> >> +			  associated with the XDMA engine registers
> >> + - clocks		: clock specifier for the clock associated with the
> >> +			  XDMA engine
> >> + - resets		: reset specifier for the syscon reset associated with
> >> +			  the XDMA engine
> >> + - interrupts-extended	: two interrupt cells; the first specifies the
> >> global
> >> +			  interrupt for the XDMA engine and the second
> >> +			  specifies the PCI-E reset or PERST interrupt.
> >> + - scu			: a phandle to the syscon node for the system control
> >> +			  unit of the SOC
> > I think this should be aspeed,scu.
> 
> 
> Sure.
> 
> 
> >
> >> + - memory		: contains the address and size of the memory area to
> >> +			  be used by the XDMA engine for DMA operations
> > Hmm, I was thinking more like a phandle to a reserved memory region,
> > like we have in the aspeed-lpc-ctrl binding.
> 
> 
> I think I mentioned before, but that doesn't work with the VGA memory. 
> Linux can't reserve it. I haven't quite understood what happens in the 
> memory system but I've tried it and it didn't work.
> 

Yeah, I think you have mentioned that before, sorry for the noise.

Andrew
