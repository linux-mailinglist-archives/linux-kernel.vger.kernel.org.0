Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5BB9146408
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 10:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgAWJCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 04:02:16 -0500
Received: from mga02.intel.com ([134.134.136.20]:42400 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgAWJCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 04:02:16 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2020 00:56:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,353,1574150400"; 
   d="scan'208";a="287240587"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 23 Jan 2020 00:56:17 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 23 Jan 2020 10:56:16 +0200
Date:   Thu, 23 Jan 2020 10:56:16 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Brown <broonie@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 37/38] platform/x86: intel_pmc_ipc: Convert to MFD
Message-ID: <20200123085616.GF2665@lahna.fi.intel.com>
References: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
 <20200121160114.60007-38-mika.westerberg@linux.intel.com>
 <20200122123454.GL15507@dell>
 <20200122125300.GO2665@lahna.fi.intel.com>
 <20200122132757.GM15507@dell>
 <20200122144523.GX2665@lahna.fi.intel.com>
 <20200123080142.GP15507@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123080142.GP15507@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 08:01:42AM +0000, Lee Jones wrote:
> On Wed, 22 Jan 2020, Mika Westerberg wrote:
> 
> > On Wed, Jan 22, 2020 at 01:27:57PM +0000, Lee Jones wrote:
> > > > Which type of device you suggest here? And which bus it should be
> > > > registered to? I think we can make this create a platform_device but
> > > > then we would need to do that from the PCI driver as well which seems
> > > > unnecessary since we already have the struct pci_dev.
> > > 
> > > What kind of device is it?
> > 
> > It is either part of an ACPI device (platform_device) or a PCI device
> > depending on the platform.
> > 
> > > Refrain from using platform device, unless it is one please.
> > 
> > OK.
> > 
> > Greg suggested making the SCU IPC functionality a class and I think it
> > fits here nicely so I'm going to try that next if nobody objects. I'll
> > send the first cleanup patches separately.
> 
> Sounds good.

FYI, I the cleanup patch series can be found here:

https://www.spinics.net/lists/platform-driver-x86/msg20728.html
https://www.spinics.net/lists/platform-driver-x86/msg20729.html
https://www.spinics.net/lists/platform-driver-x86/msg20734.html
https://www.spinics.net/lists/platform-driver-x86/msg20750.html
