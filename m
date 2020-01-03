Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8529D12F746
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 12:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbgACLb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 06:31:59 -0500
Received: from foss.arm.com ([217.140.110.172]:54830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727453AbgACLb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 06:31:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E5001FB;
        Fri,  3 Jan 2020 03:31:58 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 847E83F703;
        Fri,  3 Jan 2020 03:31:56 -0800 (PST)
Date:   Fri, 3 Jan 2020 11:31:51 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jolly Shah <JOLLYS@xilinx.com>
Cc:     "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 0/5] firmware: xilinx: Add xilinx specific sysfs interface
Message-ID: <20200103113151.GA19390@bogus>
References: <1575502159-11327-1-git-send-email-jolly.shah@xilinx.com>
 <20191218144555.GA12525@bogus>
 <BYAPR02MB5992099D8B87745DB7661C13B8200@BYAPR02MB5992.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR02MB5992099D8B87745DB7661C13B8200@BYAPR02MB5992.namprd02.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 09:01:58PM +0000, Jolly Shah wrote:
> Hi Sudeep,
>
> Thanks for the review.
>
> > -----Original Message-----
> > From: Sudeep Holla <sudeep.holla@arm.com>
> > Sent: Wednesday, December 18, 2019 6:46 AM
> > To: Jolly Shah <JOLLYS@xilinx.com>
> > Cc: ard.biesheuvel@linaro.org; mingo@kernel.org;
> > gregkh@linuxfoundation.org; matt@codeblueprint.co.uk;
> > hkallweit1@gmail.com; keescook@chromium.org;
> > dmitry.torokhov@gmail.com; Michal Simek <michals@xilinx.com>; Rajan Vaja
> > <RAJANV@xilinx.com>; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; Sudeep Holla <sudeep.holla@arm.com>
> > Subject: Re: [PATCH 0/5] firmware: xilinx: Add xilinx specific sysfs interface
> >
> > On Wed, Dec 04, 2019 at 03:29:14PM -0800, Jolly Shah wrote:
> > > This patch series adds xilinx specific sysfs interface for below
> > > purposes:
> > > - Register access
> > > - Set shutdown scope
> > > - Set boot health status bit
> >
> > This series defeats the whole abstraction EEMI provides. By providing
> > direct register accesses, you are allowing user-space to do whatever it
> > wants. I had NACKed this idea before. Has anything changed ?
> >
>
> Firmware checks for allowed accesses only and rejects rest.
>

If that is always the case, why not abstract them and remove this direct
register access completely. It must go or we must remove EEMI abstraction
and just provide direct register access to the entire space. I really
don't like this mix-n-match approach here.

> > If you need it for testing firmware, better put them in debugfs which is
> > off on production builds.
>
> Sure. Will reanalyze use cases and move to debugfs only if that suffices.
>

Thanks.

--
Regards,
Sudeep
