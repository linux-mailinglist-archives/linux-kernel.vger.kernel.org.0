Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97E4842654
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 14:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439186AbfFLMrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 08:47:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:52426 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439140AbfFLMrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:47:32 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 05:47:32 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga003.jf.intel.com with ESMTP; 12 Jun 2019 05:47:31 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hb2f4-0000uZ-LR; Wed, 12 Jun 2019 15:47:30 +0300
Date:   Wed, 12 Jun 2019 15:47:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] MAINAINERS: Swap words in INTEL PMIC MULTIFUNCTION
 DEVICE DRIVERS
Message-ID: <20190612124730.GH9224@smile.fi.intel.com>
References: <20190211105710.37800-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211105710.37800-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 12:57:10PM +0200, Andy Shevchenko wrote:
> Swap PMIC and MULTIFUNCTION words in the title to:
> - show that this is about Intel PMICs
> - keep MAINTAINERS properly sorted
> 

Any comment on this?

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9919840d54cd..918795d5eea6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7789,7 +7789,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-intel.git
>  F:	drivers/gpio/gpio-*cove.c
>  F:	drivers/gpio/gpio-msic.c
>  
> -INTEL MULTIFUNCTION PMIC DEVICE DRIVERS
> +INTEL PMIC MULTIFUNCTION DEVICE DRIVERS
>  R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>  S:	Maintained
>  F:	drivers/mfd/intel_msic.c
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


