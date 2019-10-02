Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADC12C494D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 10:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfJBIUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 04:20:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:52202 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726067AbfJBIUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 04:20:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EA74CACC6;
        Wed,  2 Oct 2019 08:20:14 +0000 (UTC)
Date:   Wed, 2 Oct 2019 10:20:06 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, alsa-devel@alsa-project.org,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: slave: Fix unused function warning on !ACPI
Message-ID: <20191002081717.GA4015@kitsune.suse.cz>
References: <20190830185212.25144-1-msuchanek@suse.de>
 <f8c58d45-e641-5071-33bf-2927a61cb419@infradead.org>
 <20190904093052.GQ2672@vkoul-mobl>
 <20190904124803.1700a65a@naga>
 <20190904114059.GU2672@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190904114059.GU2672@vkoul-mobl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 05:10:59PM +0530, Vinod Koul wrote:
> On 04-09-19, 12:48, Michal Suchánek wrote:
> > On Wed, 4 Sep 2019 15:00:52 +0530
> > Vinod Koul <vkoul@kernel.org> wrote:
> > 
> > > On 30-08-19, 11:56, Randy Dunlap wrote:
> > > > On 8/30/19 11:52 AM, Michal Suchanek wrote:  
> > > > > Fixes the following warning on !ACPI systems:
> > > > > 
> > > > > drivers/soundwire/slave.c:16:12: warning: ‘sdw_slave_add’ defined but
> > > > > not used [-Wunused-function]
> > > > >  static int sdw_slave_add(struct sdw_bus *bus,
> > > > >             ^~~~~~~~~~~~~
> > > > > 
> > > > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>  
> > > > 
> > > > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > > > 
> > > > I was about to send the same patch.  
> > > 
> > > So I have applied Srini's patches which add DT support and they use
> > > sdw_slave_add(). So next tomorrow should not see this error as it is now
> > > used by DT parts as well.
> > > 
> > > So dropping this patch
> > > 
> > 
> > That should fix the issue for me. I wonder if !ACPI !DT platforms are
> > still a thing.
> 
> Heh that should trigger this if we have one :D so should a lot more
> which depend on some firmware!

Actually s390x is built with !ACPI and !OF. While it supports PCI an
virtio in practice only sound devices emulated by qemu are available.
Also AFAICT the sounwire driver is useless without ACPI or OF so it
should depend on them.

Thanks

Michal
