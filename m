Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE4BA5784
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 15:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbfIBNPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 09:15:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:31797 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729983AbfIBNPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:15:47 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 06:15:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,459,1559545200"; 
   d="scan'208";a="382795380"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 02 Sep 2019 06:15:45 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i4mBM-0002NJ-Ox; Mon, 02 Sep 2019 16:15:44 +0300
Date:   Mon, 2 Sep 2019 16:15:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v4] mfd: Add support for Merrifield Basin Cove PMIC
Message-ID: <20190902131544.GJ2680@smile.fi.intel.com>
References: <20190801190335.37726-1-andriy.shevchenko@linux.intel.com>
 <20190902083859.GQ4804@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902083859.GQ4804@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 09:38:59AM +0100, Lee Jones wrote:
> On Thu, 01 Aug 2019, Andy Shevchenko wrote:
> 
> > Add an MFD driver for Intel Merrifield Basin Cove PMIC.
> > 
> > Firmware on the platforms which are using Basin Cove PMIC is "smarter"
> > than on the rest supported by vanilla kernel. It handles first level
> > of interrupt itself, while others do it on OS level.
> > 
> > The driver is done in the same way as the rest of Intel PMIC MFD drivers
> > in the kernel to support the initial design. The design allows to use
> > one driver among few PMICs without knowing implementation details of
> > the each hardware version or generation.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > v4: elaborate in the commit message the design choice
> >  drivers/mfd/Kconfig                      |  11 ++
> >  drivers/mfd/Makefile                     |   1 +
> >  drivers/mfd/intel_soc_pmic_mrfld.c       | 157 +++++++++++++++++++++++
> >  include/linux/mfd/intel_soc_pmic_mrfld.h |  81 ++++++++++++
> >  4 files changed, 250 insertions(+)
> >  create mode 100644 drivers/mfd/intel_soc_pmic_mrfld.c
> >  create mode 100644 include/linux/mfd/intel_soc_pmic_mrfld.h
> 
> Reluctantly applied, thanks.

Thank you very much!

If any better solution comes to your mind in the future, I would be glad to
amend the driver.

Btw, can you provide an immutable branch for IIO subsystem to take individual
ADC driver?

-- 
With Best Regards,
Andy Shevchenko


