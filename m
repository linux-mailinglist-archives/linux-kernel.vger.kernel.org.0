Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6292E191784
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 18:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbgCXRUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 13:20:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:5971 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727267AbgCXRUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:20:51 -0400
IronPort-SDR: 4PdgFIVF14SSYOq2jw8ZVHBL2PMalwtc1OEJdKFiVa12mkIdEz8R3eFd5X6GKaYnJ6zeb0qmtK
 RkENSUZ6F3Cw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 10:20:44 -0700
IronPort-SDR: lTjJf7kd7Sdj3CbIltbwAxnUjZtH9FR8UIVGjLYmRCoQtJeTsFicEUboNADGq60Zmx3pxl3usE
 EzRwB6WgmhEw==
X-IronPort-AV: E=Sophos;i="5.72,301,1580803200"; 
   d="scan'208";a="240333667"
Received: from spandruv-mobl.amr.corp.intel.com ([10.134.90.138])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 10:20:42 -0700
Message-ID: <3166e472e0ef5c0db8da3ab7d846b47795e69057.camel@linux.intel.com>
Subject: Re: [PATCH v2] platform: x86: Add ACPI driver for ChromeOS
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, vbendeb@chromium.org,
        groeck@chromium.org, bleung@chromium.org, dtor@chromium.org,
        gwendal@chromium.org, andy@infradead.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeremy Soller <jeremy@system76.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org
Date:   Tue, 24 Mar 2020 10:20:41 -0700
In-Reply-To: <3444110c-d6c0-16df-9b5d-12578ed442c5@collabora.com>
References: <20200322094334.1872663-1-enric.balletbo@collabora.com>
         <20200322111022.GA72939@kroah.com>
         <c480f318-c326-d51c-e757-c65c2526ab4d@collabora.com>
         <20200324164956.GE2518746@kroah.com>
         <3444110c-d6c0-16df-9b5d-12578ed442c5@collabora.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-24 at 18:08 +0100, Enric Balletbo i Serra wrote:
> Hi Greg,
> 
> On 24/3/20 17:49, Greg Kroah-Hartman wrote:
> > On Tue, Mar 24, 2020 at 05:31:10PM +0100, Enric Balletbo i Serra
> > wrote:
> > > Hi Greg,
> > > 
> > > Many thanks for your quick answer, some comments below.
> > > 
[...]

> > Are you sure they aren't already there under
> > /sys/firmware/acpi/?  I
> > thought all tables and methods were exported there with no need to
> > do
> > anything special.
> > 
> 
> That's the first I did when I started to forward port this patch from
> chromeos
> kernel to mainline.
> 
> On my system I get:
> 
> /sys/firmware/acpi/tables#
> APIC  DSDT  FACP  FACS  HPET  MCFG  SSDT  data  dynamic
> 
> (data and dynamic are empty directories)
> 
> I quickly concluded (maybe wrong) that as there is no a MLST entry it
> was not
> exported, but maybe one of those already contains the info? Or,
> should I expect
> a MLST entry here?
> 
If the data you are reading doesn't depend on any runtime variable in
ACPI tables then you can read from firmware tables as is.

You can download acpica tools and run your method on acpi dump using
acpiexec tool. Once you can take dump, you can run on any Linux system.

If you can get what you need from running on the dump, then you can do
by directly reading from /sys/firmware/acpi/tables/ from user space
without kernel change. Sometimes it is enough as lots of config data
tend to be static.

Thanks,
Srinivas






> > What makes these attributes "special" from any other ACPI method?
> > 
> 
> I can't answer this question right now. I need to investigate more I
> guess ;-)
> 
> Thanks again for your answer,
> Enric
> 
> > > > > +static int __init chromeos_acpi_init(void)
> > > > > +{
> > > > > +	int ret;
> > > > > +
> > > > > +	chromeos_acpi.pdev =
> > > > > platform_device_register_simple("chromeos_acpi",
> > > > > +						PLATFORM_DEVID_
> > > > > NONE, NULL, 0);
> > > > > +	if (IS_ERR(chromeos_acpi.pdev)) {
> > > > > +		pr_err("unable to register chromeos_acpi
> > > > > platform device\n");
> > > > > +		return PTR_ERR(chromeos_acpi.pdev);
> > > > > +	}
> > > > 
> > > > Only use platform devices and drivers for things that are
> > > > actually
> > > > platform devices and drivers.  That's not what this is, it is
> > > > an ACPI
> > > > device and driver.  Don't abuse the platform interface please.
> > > > 
> > > 
> > > Ok. The purpose was to not break ChromeOS userspace since is
> > > looking for the
> > > attributes inside /sys/devices/platform/chromeos_acpi. Not a good
> > > reason, I
> > > know, and I assume we will need to change userspace instead, and
> > > convert this to
> > > a ACPI device and driver only, right?
> > 
> > How can any userspace be looking for anything that hasn't been
> > submitted
> > before?  That's nothing to worry about, we don't have to support
> > things
> > like that :)
> > 
> > > I'll investigate the different places in userspace where this is
> > > used and see
> > > how difficult it is to do the changes.
> > 
> > Look at /sys/firmware/acpi/ first please.
> > 
> > thanks,
> > 
> > greg k-h
> > 

