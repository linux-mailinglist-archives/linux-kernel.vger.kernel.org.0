Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7DF155626
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 11:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgBGK4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Feb 2020 05:56:54 -0500
Received: from foss.arm.com ([217.140.110.172]:38842 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbgBGK4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 05:56:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B480930E;
        Fri,  7 Feb 2020 02:56:52 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A1D83F52E;
        Fri,  7 Feb 2020 02:56:51 -0800 (PST)
Date:   Fri, 7 Feb 2020 10:56:49 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     peng.fan@nxp.com, mark.rutland@arm.com, viresh.kumar@linaro.org,
        f.fainelli@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andre.przywara@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: arm,scmi: add smc/hvc transports
Message-ID: <20200207105649.GC36345@bogus>
References: <1580994086-17850-1-git-send-email-peng.fan@nxp.com>
 <1580994086-17850-2-git-send-email-peng.fan@nxp.com>
 <20200206215947.GA21514@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206215947.GA21514@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 02:59:47PM -0700, Rob Herring wrote:
> On Thu, Feb 06, 2020 at 09:01:25PM +0800, peng.fan@nxp.com wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > SCMI could use SMC/HVC as tranports, so add into devicetree
> > binding doc.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/arm/arm,scmi.txt | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > index f493d69e6194..03cff8b55a93 100644
> > --- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > +++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > @@ -14,7 +14,7 @@ Required properties:
> >
> >  The scmi node with the following properties shall be under the /firmware/ node.
> >
> > -- compatible : shall be "arm,scmi"
> > +- compatible : shall be "arm,scmi" or "arm,scmi-smc"
> >  - mboxes: List of phandle and mailbox channel specifiers. It should contain
> >  	  exactly one or two mailboxes, one for transmitting messages("tx")
> >  	  and another optional for receiving the notifications("rx") if
> > @@ -25,6 +25,8 @@ The scmi node with the following properties shall be under the /firmware/ node.
> >  	  protocol identifier for a given sub-node.
> >  - #size-cells : should be '0' as 'reg' property doesn't have any size
> >  	  associated with it.
> > +- arm,smc-id : SMC id required when using smc transports
> > +- arm,hvc-id : HVC id required when using hvc transports
>
> Don't the SMC ids get standardized?
>

Unfortunately no. Please don't ask me why ;) as there's no technical reason
to not standardize it. I pushed hard for it, but for this particular case the
SMC/HVC transport is considered to be outside the SCMI protocol standards as
it's transport related.

I completely agree it is total non-sense. I will try to convince them showing
this discussion as reference but can't guarantee anything.

--
Regards,
Sudeep
