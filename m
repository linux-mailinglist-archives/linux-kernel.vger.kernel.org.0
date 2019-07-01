Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C04E04CA6F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 11:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbfFTJOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 05:14:45 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:48203 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfFTJOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 05:14:44 -0400
Received: from localhost (alyon-656-1-672-152.w92-137.abo.wanadoo.fr [92.137.69.152])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 3E5B2200004;
        Thu, 20 Jun 2019 09:14:42 +0000 (UTC)
Date:   Thu, 20 Jun 2019 11:14:41 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] dt-bindings: arm: Convert Atmel board/soc bindings to
 json-schema
Message-ID: <20190620091441.GW23549@piout.net>
References: <20190517153911.19545-1-robh@kernel.org>
 <20190601214050.GG3558@piout.net>
 <20190613224652.GB5119@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613224652.GB5119@bogus>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2019 16:46:52-0600, Rob Herring wrote:
> On Sat, Jun 01, 2019 at 11:40:50PM +0200, Alexandre Belloni wrote:
> > On 17/05/2019 10:39:11-0500, Rob Herring wrote:
> > > Convert Atmel SoC bindings to DT schema format using json-schema.
> > > 
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> > > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > Cc: devicetree@vger.kernel.org
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> Is someone going to apply this?
> 

I applied it now, I had to fix the missing sam9x60 though.

> Rob

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
