Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88C96159428
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 17:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbgBKQBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 11:01:53 -0500
Received: from mga18.intel.com ([134.134.136.126]:40178 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729405AbgBKQBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:01:53 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 08:01:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="227539539"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 11 Feb 2020 08:01:33 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j1Xyg-000lzA-0G; Tue, 11 Feb 2020 18:01:34 +0200
Date:   Tue, 11 Feb 2020 18:01:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 18/18] MAINTAINERS: Update entry for Intel Broxton PMC
 driver
Message-ID: <20200211160133.GI10400@smile.fi.intel.com>
References: <20200211132603.73509-1-mika.westerberg@linux.intel.com>
 <20200211132603.73509-19-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211132603.73509-19-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 04:26:03PM +0300, Mika Westerberg wrote:
> The driver lives now under MFD so split the current entry into two parts
> and add me as co-maintainer of the Intel Broxton PMC driver. While there
> correct formatting of Zha Qipeng's email address.

...

> -INTEL PMC/P-Unit IPC DRIVER
> -M:	Zha Qipeng<qipeng.zha@intel.com>
> +INTEL P-Unit IPC DRIVER
> +M:	Zha Qipeng <qipeng.zha@intel.com>
>  L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained
> -F:	arch/x86/include/asm/intel_pmc_ipc.h
>  F:	arch/x86/include/asm/intel_punit_ipc.h
> -F:	drivers/platform/x86/intel_pmc_ipc.c
>  F:	drivers/platform/x86/intel_punit_ipc.c
>  
>  INTEL PMIC GPIO DRIVERS

Does it stays at the same place after executing parse-maintainers.pl?

-- 
With Best Regards,
Andy Shevchenko


