Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD6536070
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 17:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbfFEPkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 11:40:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfFEPkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 11:40:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4746E2083E;
        Wed,  5 Jun 2019 15:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559749246;
        bh=CaL45T/bhO5CkVPjPrmO1rscN3Cs8zczhlRrC0/aOJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kpHl2mm2Q4YxQ0xTQ/FgZM+JZWwxSBDaaJ+rgKeyGffZU+Qv+HB9JjnxXam2dXPaq
         6YFvDLgwbVTgCzdaUoelumjKPPzK2NzerXdiiCpxLOeBTBUOebU2Pvft6vNiJ77/RQ
         T9n6YOKbvrwqU6IQVye3T8B43+un//Aum9A5wHlY=
Date:   Wed, 5 Jun 2019 17:40:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Shenhar, Talel" <talel@amazon.com>
Cc:     nicolas.ferre@microchip.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, robh+dt@kernel.org,
        davem@davemloft.net, shawn.lin@rock-chips.com, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dwmw@amazon.co.uk, benh@kernel.crashing.org, jonnyc@amazon.com,
        hhhawa@amazon.com, ronenk@amazon.com, hanochu@amazon.com,
        barakw@amazon.com
Subject: Re: [PATCH v2 2/2] irqchip: al-fic: Introduce Amazon's Annapurna
 Labs Fabric Interrupt Controller Driver
Message-ID: <20190605154044.GA21923@kroah.com>
References: <1559731921-14023-1-git-send-email-talel@amazon.com>
 <1559731921-14023-3-git-send-email-talel@amazon.com>
 <20190605125055.GA3184@kroah.com>
 <fb3f5f4d-26f4-8729-7370-f206369ab2b7@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb3f5f4d-26f4-8729-7370-f206369ab2b7@amazon.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 05:51:08PM +0300, Shenhar, Talel wrote:
> 
> On 6/5/2019 3:50 PM, Greg KH wrote:
> > On Wed, Jun 05, 2019 at 01:52:01PM +0300, Talel Shenhar wrote:
> > > --- /dev/null
> > > +++ b/drivers/irqchip/irq-al-fic.c
> > > @@ -0,0 +1,289 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/**
> > No need for kernel-doc format style here.
> done
> > 
> > > + * Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> > "or its affiliates"?  You know the answer to this, don't keep us in
> > suspense.  Put the proper copyright holder here please, otherwise this
> > is totally useless.
> > 
> > Well, copyright notices are technically useless anyway, but lawyers like
> > to cargo-cult with the best of them, so it should be correct at the
> > least.
> 
> This is the format we were asked to use and have been using.
> 
> I am pinging them with your comment but I am likely not to get immediate
> response so I'm publishing v3 without changing the "affiliates" for now.

If that is what your lawyers say to use, that's fine.  Gotta love being
vague in copyright lines, what could go wrong...

good luck!

greg k-h
