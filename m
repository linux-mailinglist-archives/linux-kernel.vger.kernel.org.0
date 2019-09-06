Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1BB6AB643
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 12:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388477AbfIFKpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 06:45:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730767AbfIFKpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:45:12 -0400
Received: from localhost (unknown [223.226.32.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2EFD2084F;
        Fri,  6 Sep 2019 10:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567766711;
        bh=8obvABzY456lelT+/+F0iiNkcUGvNaX0PoU7PvA7MHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IDxctFLgE85TE+lmarvW0ZhIpYuXdofqQrSBdKIrPm3CGWpNYJmjk2lLowearehq3
         3VMQmSIPx3QAsdwv2bl03ucelgJ+waAVxPmtJJCLjM0DNYYletYyjdRnztifkQ8Vws
         td1cL8xV+TWdvhE8RDn2cUIkMKPAs+2hb2vFccds=
Date:   Fri, 6 Sep 2019 16:14:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soundwire: add back ACPI dependency
Message-ID: <20190906104403.GH2672@vkoul-mobl>
References: <20190905203527.1478314-1-arnd@arndb.de>
 <20190906043805.GE2672@vkoul-mobl>
 <CAK8P3a38ywYFaGekbi6_idwrZvaVX8u8giUpK1r26QAbekLp8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a38ywYFaGekbi6_idwrZvaVX8u8giUpK1r26QAbekLp8Q@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-09-19, 12:02, Arnd Bergmann wrote:
> On Fri, Sep 6, 2019 at 6:39 AM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 05-09-19, 22:35, Arnd Bergmann wrote:
> > > Soundwire gained a warning for randconfig builds without
> > > CONFIG_ACPI during the linux-5.3-rc cycle:
> > >
> > > drivers/soundwire/slave.c:16:12: error: unused function 'sdw_slave_add' [-Werror,-Wunused-function]
> > >
> > > Add the CONFIG_ACPI dependency at the top level now.
> >
> > Did you run this yesterday or today. I have applied Srini's patches to
> > add DT support for Soundwire couple of days back so we should not see
> > this warning anymore
> 
> This is on the latest linux-next, which is dated 20190904. As Stephen is
> not releasing any more linux-next kernels until later this month, I'm
> missing anything that came in afterwards.

That is interesting as next-20190904 has the DT changes :) Can you share
the config you used to get this.

I have two instances of sdw_slave_add() in next-20190904:

drivers/soundwire/slave.c:              sdw_slave_add(bus, &id, acpi_fwnode_handle(adev));
drivers/soundwire/slave.c:              sdw_slave_add(bus, &id, of_fwnode_handle(node));

Thanks
-- 
~Vinod
