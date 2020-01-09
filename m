Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEFC1362C2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 22:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbgAIVlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 16:41:32 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:59947 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgAIVlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 16:41:32 -0500
X-Originating-IP: 90.65.92.102
Received: from localhost (lfbn-lyo-1-1913-102.w90-65.abo.wanadoo.fr [90.65.92.102])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id B26101C0003;
        Thu,  9 Jan 2020 21:41:29 +0000 (UTC)
Date:   Thu, 9 Jan 2020 22:41:28 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: at91: add sama5d3 pmc driver
Message-ID: <20200109214128.GB1027187@piout.net>
References: <20191229202907.335931-1-alexandre.belloni@bootlin.com>
 <20200106030905.8643221582@mail.kernel.org>
 <20200108110218.GT3040@piout.net>
 <20200109181910.59B2B206ED@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109181910.59B2B206ED@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2020 10:19:09-0800, Stephen Boyd wrote:
> Quoting Alexandre Belloni (2020-01-08 03:02:18)
> > On 05/01/2020 19:09:04-0800, Stephen Boyd wrote:
> > > > +       return;
> > > > +
> > > > +err_free:
> > > > +       pmc_data_free(sama5d3_pmc);
> > > > +}
> > > > +CLK_OF_DECLARE_DRIVER(sama5d3_pmc, "atmel,sama5d3-pmc", sama5d3_pmc_setup);
> > > 
> > > Any reason this can't be a platform driver?
> > > 
> > 
> > As for the other PMC driver, we need a few of the peripheral clocks very
> > early which means that we would have to register most of the clock tree
> > registered early leaving only a few clocks to be registered by a
> > platform driver.
> > 
> 
> What peripheral clks? Can you add a comment to the code?
> 

The TCB is used as the clocksource so its clock is needed. Its parent is
the master clock which has UTMI, PLLA, the mainclock and the slow clock
as parents so by that point, most of the tree is registered.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
