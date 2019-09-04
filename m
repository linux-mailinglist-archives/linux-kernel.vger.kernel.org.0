Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43CE9A8145
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 13:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbfIDLmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 07:42:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfIDLmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:42:08 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAC4720820;
        Wed,  4 Sep 2019 11:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567597327;
        bh=Iu1vh+UB2UTe/P8T2CkcUAMYlHAR9Uq0TtPWxda2pqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HpDusYLy+uvhV4rv0L+uXxG5hVwlSOCOoihvmRGmo0YMM1lesw1xfGTKuATz1aHee
         djikE5xbk2y8Bf3BabxlRiGlQiDggItPbT/vIESI9SdfrO75il7LkEghSDKZXeyjAp
         a2shKS1pDwU9wwXgaVpNNI/aogkbvbXt7hP3FipE=
Date:   Wed, 4 Sep 2019 17:10:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>, alsa-devel@alsa-project.org,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: slave: Fix unused function warning on !ACPI
Message-ID: <20190904114059.GU2672@vkoul-mobl>
References: <20190830185212.25144-1-msuchanek@suse.de>
 <f8c58d45-e641-5071-33bf-2927a61cb419@infradead.org>
 <20190904093052.GQ2672@vkoul-mobl>
 <20190904124803.1700a65a@naga>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190904124803.1700a65a@naga>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-09-19, 12:48, Michal Suchánek wrote:
> On Wed, 4 Sep 2019 15:00:52 +0530
> Vinod Koul <vkoul@kernel.org> wrote:
> 
> > On 30-08-19, 11:56, Randy Dunlap wrote:
> > > On 8/30/19 11:52 AM, Michal Suchanek wrote:  
> > > > Fixes the following warning on !ACPI systems:
> > > > 
> > > > drivers/soundwire/slave.c:16:12: warning: ‘sdw_slave_add’ defined but
> > > > not used [-Wunused-function]
> > > >  static int sdw_slave_add(struct sdw_bus *bus,
> > > >             ^~~~~~~~~~~~~
> > > > 
> > > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>  
> > > 
> > > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > > 
> > > I was about to send the same patch.  
> > 
> > So I have applied Srini's patches which add DT support and they use
> > sdw_slave_add(). So next tomorrow should not see this error as it is now
> > used by DT parts as well.
> > 
> > So dropping this patch
> > 
> 
> That should fix the issue for me. I wonder if !ACPI !DT platforms are
> still a thing.

Heh that should trigger this if we have one :D so should a lot more
which depend on some firmware!

-- 
~Vinod
