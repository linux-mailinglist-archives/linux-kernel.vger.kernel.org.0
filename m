Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAEC8122AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 12:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfLQL5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 06:57:04 -0500
Received: from mga06.intel.com ([134.134.136.31]:39190 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfLQL5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:57:04 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 03:57:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,325,1571727600"; 
   d="scan'208";a="209669421"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 17 Dec 2019 03:57:02 -0800
Received: from andy by smile with local (Exim 4.93-RC7)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ihBTL-0001vv-1g; Tue, 17 Dec 2019 13:57:03 +0200
Date:   Tue, 17 Dec 2019 13:57:03 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Cc:     Coly Li <colyli@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib: crc64: include <linux/crc64.h> for 'crc64_be'
Message-ID: <20191217115703.GZ32742@smile.fi.intel.com>
References: <20191217112633.2108845-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217112633.2108845-1-ben.dooks@codethink.co.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 11:26:33AM +0000, Ben Dooks (Codethink) wrote:
> The crc64_be() is declared in <linux/crc64.h> so include
> this where the symbol is defined to avoid the following
> warning:
> 
> lib/crc64.c:43:12: warning: symbol 'crc64_be' was not declared. Should it be static?

Thanks!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
> ---
> Cc: Coly Li <colyli@suse.de>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: linux-kernel@vger.kernel.org
> ---
>  lib/crc64.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/crc64.c b/lib/crc64.c
> index 0ef8ae6ac047..f8928ce28280 100644
> --- a/lib/crc64.c
> +++ b/lib/crc64.c
> @@ -28,6 +28,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/types.h>
> +#include <linux/crc64.h>
>  #include "crc64table.h"
>  
>  MODULE_DESCRIPTION("CRC64 calculations");
> -- 
> 2.24.0
> 

-- 
With Best Regards,
Andy Shevchenko


