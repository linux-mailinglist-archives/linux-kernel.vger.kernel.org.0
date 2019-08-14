Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5EDB8D872
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 18:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfHNQvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 12:51:44 -0400
Received: from foss.arm.com ([217.140.110.172]:57346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfHNQvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 12:51:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6676344;
        Wed, 14 Aug 2019 09:51:42 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 621593F694;
        Wed, 14 Aug 2019 09:51:41 -0700 (PDT)
Date:   Wed, 14 Aug 2019 17:51:33 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Morten Borup Petersen <morten_bp@live.dk>,
        Tushar Khandelwal <tushar.khandelwal@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tushar.2nov@gmail.com" <tushar.2nov@gmail.com>,
        "nd@arm.com" <nd@arm.com>,
        Morten Borup Petersen <morten.petersen@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/4] mailbox: arm_mhuv2: add device tree binding
 documentation
Message-ID: <20190814165133.GA8346@e107155-lin>
References: <20190717192616.1731-1-tushar.khandelwal@arm.com>
 <20190717192616.1731-2-tushar.khandelwal@arm.com>
 <CABb+yY04vW-i35N6P57KSKgmMAYkrA2CDyUvA-bLCZMxiZaocw@mail.gmail.com>
 <CABb+yY1SeHTgZQNAHJW+dZG=khah5c5igtKy+MrjADnZF29Aow@mail.gmail.com>
 <VI1PR0601MB21113C48E719B2C79EC2FE508FC20@VI1PR0601MB2111.eurprd06.prod.outlook.com>
 <CABb+yY3yMWbUiQnJgfQhwnW1OM3aoFL3ZFc018E-fxGichi-4Q@mail.gmail.com>
 <VI1PR0601MB2111A5A4E951F011D389A8978FD90@VI1PR0601MB2111.eurprd06.prod.outlook.com>
 <CABb+yY3Ni7wV+ui1LO7TERWQH_BoakZbPq961wdRPB4X-nwS2A@mail.gmail.com>
 <20190814100518.GA21898@e107155-lin>
 <CABb+yY1jZs0OU-oi86iNNHiqBTjaY6ixFPMoUPkU6MCH_YrwLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY1jZs0OU-oi86iNNHiqBTjaY6ixFPMoUPkU6MCH_YrwLg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 09:52:25AM -0500, Jassi Brar wrote:
> On Wed, Aug 14, 2019 at 5:05 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Tue, Aug 13, 2019 at 11:36:56AM -0500, Jassi Brar wrote:
> > [...]
> >
> > > > >>
> > > > >> As mentioned in the response to your initial comment, the driver does
> > > > >> not currently support mixing protocols.
> > > > >>
> > > > > Thanks for acknowledging that limitation. But lets also address it.
> > > > >
> > > >
> > > > We are hesitant to dedicate time to developing mixing protocols given
> > > > that we don't have any current usecase nor any current platform which
> > > > would support this.
> > > >
> > > Can you please share the client code against which you tested this driver?
> > > From my past experience, I realise it is much more efficient to tidyup
> > > the code myself, than endlessly trying to explain the benefits.
> > >
> >
> > Thanks for the patience and offer.
> >
> Ok, but the offer is to Morten for MHUv2 driver.
> 
> > Can we try the same with MHUv1 and SCMI
> > upstream driver.
> >
> MHUv1 driver is fine as it is.
> I did try my best to keep you from messing the SCMI driver, without success
> https://lkml.org/lkml/2017/8/7/924

I disagree, you haven't told me how to address the usecase which I mentioned
with the abstraction/multiplexer on top of MHU as you have been suggesting.

I am sure MHUv2 will have the same usecase.

--
Regards,
Sudeep
