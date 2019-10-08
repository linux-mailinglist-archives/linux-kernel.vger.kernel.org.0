Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4AA2CFE9B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 18:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfJHQMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 12:12:50 -0400
Received: from mga04.intel.com ([192.55.52.120]:42615 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfJHQMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 12:12:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 09:12:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,270,1566889200"; 
   d="scan'208";a="206667983"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 08 Oct 2019 09:12:47 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iHs6P-0003r1-Mi; Tue, 08 Oct 2019 19:12:45 +0300
Date:   Tue, 8 Oct 2019 19:12:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Tuowen Zhao <ztuowen@gmail.com>, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com,
        acelan.kao@canonical.com, bhelgaas@google.com,
        kai.heng.feng@canonical.com
Subject: Re: [PATCH v2] mfd: intel-lpss: use devm_ioremap_uc for MMIO
Message-ID: <20191008161245.GU32742@smile.fi.intel.com>
References: <20191007184231.13256-1-ztuowen@gmail.com>
 <20191008151628.GA16384@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008151628.GA16384@42.do-not-panic.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 03:16:28PM +0000, Luis Chamberlain wrote:
> On Mon, Oct 07, 2019 at 12:42:31PM -0600, Tuowen Zhao wrote:
> > +EXPORT_SYMBOL(devm_ioremap_uc);
> 
> EXPORT_SYMBOL_GPL() would be my preference.

Maybe we can even split this to two patches?

-- 
With Best Regards,
Andy Shevchenko


