Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA07F3671D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 23:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfFEV4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 17:56:25 -0400
Received: from gate.crashing.org ([63.228.1.57]:60670 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbfFEV4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 17:56:25 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x55LthpZ022953;
        Wed, 5 Jun 2019 16:55:44 -0500
Message-ID: <a81a46ef13273aa8c6ea87c8d3550e33650e27b6.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/3] irqchip: al-fic: Introduce Amazon's Annapurna Labs
 Fabric Interrupt Controller Driver
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Talel Shenhar <talel@amazon.com>
Cc:     nicolas.ferre@microchip.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, robh+dt@kernel.org,
        davem@davemloft.net, shawn.lin@rock-chips.com, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dwmw@amazon.co.uk, jonnyc@amazon.com, hhhawa@amazon.com,
        ronenk@amazon.com, hanochu@amazon.com, barakw@amazon.com
Date:   Thu, 06 Jun 2019 07:55:43 +1000
In-Reply-To: <20190605075927.GA9693@kroah.com>
References: <1559717653-11258-1-git-send-email-talel@amazon.com>
         <1559717653-11258-3-git-send-email-talel@amazon.com>
         <20190605075927.GA9693@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-05 at 09:59 +0200, Greg KH wrote:
> 
> > +struct irq_domain *al_fic_wire_get_domain(struct al_fic *fic);
> > +
> > +struct al_fic *al_fic_wire_init(struct device_node *node,
> > +				void __iomem *base,
> > +				const char *name,
> > +				unsigned int parent_irq);
> > +int al_fic_cleanup(struct al_fic *fic);
> 
> Who is using these new functions?  We don't add new apis that no one
> uses :(

They will be used by subsequent driver submissions but those aren't
quite ready yet, so we can hold onto patch 3 for now until they are.

Cheers,
Ben.


