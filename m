Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85F0815167C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 08:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgBDHgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 02:36:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:59078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgBDHgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 02:36:36 -0500
Received: from localhost (unknown [167.98.85.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 215DE2087E;
        Tue,  4 Feb 2020 07:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580801794;
        bh=WUFEjfexfAn28sJ9AUp2kzluNRF9714XTUnJnecywJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pjoZ2s4RFWiWcb+Nq7LFFuCdqj2UypIjt4yVH5O3VdEpBTSFXD/4MflI22sejvDLy
         JF8TLK1qCRaNDPw2aHpoH7nt2FMy7MnPRSXB5J99BwczgSR6H/J/GNDxMQwtCaSFsZ
         NMHXGJm0iKRYf1tMbbdh3DaVmxJSmt0WH5suF59U=
Date:   Tue, 4 Feb 2020 07:36:32 +0000
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wambui.karugax@gmail.com" <wambui.karugax@gmail.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "julia.lawall@lip6.fr" <julia.lawall@lip6.fr>
Subject: Re: [PATCH] staging/octeon: Mark Ethernet driver as BROKEN
Message-ID: <20200204073632.GB1085438@kroah.com>
References: <20191202141836.9363-1-linux@roeck-us.net>
 <20191202165231.GA728202@kroah.com>
 <20191202173620.GA29323@roeck-us.net>
 <20191202181505.GA732872@kroah.com>
 <8168627a60e9e851860f8cc295498423828401c9.camel@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8168627a60e9e851860f8cc295498423828401c9.camel@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 12:54:26AM +0000, Chris Packham wrote:
> Hi Greg & All,
> 
> On Mon, 2019-12-02 at 19:15 +0100, Greg Kroah-Hartman wrote:
> > On Mon, Dec 02, 2019 at 09:36:20AM -0800, Guenter Roeck wrote:
> > > On Mon, Dec 02, 2019 at 05:52:31PM +0100, Greg Kroah-Hartman wrote:
> > > > On Mon, Dec 02, 2019 at 06:18:36AM -0800, Guenter Roeck wrote:
> > > > > The code doesn't compile due to incompatible pointer errors
> > > > > such as
> > > > > 
> > > > > drivers/staging/octeon/ethernet-tx.c:649:50: error:
> > > > > 	passing argument 1 of 'cvmx_wqe_get_grp' from
> > > > > incompatible pointer type
> > > > > 
> > > > > This is due to mixing, for example, cvmx_wqe_t with 'struct
> > > > > cvmx_wqe'.
> > > > > 
> > > > > Unfortunately, one can not just revert the primary offending
> > > > > commit, as doing so
> > > > > results in secondary errors. This is made worse by the fact
> > > > > that the "removed"
> > > > > typedefs still exist and are used widely outside the staging
> > > > > directory,
> > > > > making the entire set of "remove typedef" changes pointless and
> > > > > wrong.
> > > > 
> > > > Ugh, sorry about that.
> > > > 
> > > > > Reflect reality and mark the driver as BROKEN.
> > > > 
> > > > Should I just delete this thing?  No one seems to be using it and
> > > > there
> > > > is no move to get it out of staging at all.
> > > > 
> > > > Will anyone actually miss it?  It can always come back of someone
> > > > does...
> > > > 
> > > 
> > > All it does is causing trouble and misguided attempts to clean it
> > > up.
> > > If anything, the whole thing goes into the wrong direction (declare
> > > a
> > > complete set of dummy functions just to be able to build the driver
> > > with COMPILE_TEST ? Seriously ?).
> > > 
> > > I second the motion to drop it. This has been in staging for 10
> > > years.
> > > Don't we have some kind of time limit for code in staging ? If not,
> > > should we ? If anyone really needs it, that person or group should
> > > really invest the time to get it out of staging for good.
> > 
> > 10 years?  Ugh, yes, it's time to drop the thing, I'll do so after
> > -rc1
> > is out.
> > 
> 
> As a long suffering Cavium MIPs customer could I request that this
> isn't dropped. I'll get someone here to take a look at fixing the build
> issues.
> 
> Given our platform isn't upstream I'm not sure that we'll be able to
> meet the criteria for getting it out of staging.
> 

Can't you push this onto Cavium as you are paying them for hardware and
support?

thanks,

greg k-h
