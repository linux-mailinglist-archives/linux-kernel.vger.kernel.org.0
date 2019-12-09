Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5238C117207
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 17:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfLIQmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 11:42:15 -0500
Received: from mga17.intel.com ([192.55.52.151]:52175 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfLIQmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:42:14 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 08:42:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,296,1571727600"; 
   d="scan'208";a="215272459"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 09 Dec 2019 08:42:13 -0800
Received: from andy by smile with local (Exim 4.93-RC5)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ieM6v-00015B-6B; Mon, 09 Dec 2019 18:42:13 +0200
Date:   Mon, 9 Dec 2019 18:42:13 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matt Porter <mporter@kernel.crashing.org>,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Bounine <alexandre.bounine@idt.com>
Subject: Re: [PATCH v1] rapidio: Make it dependent to DMADEVICES
Message-ID: <20191209164213.GN32742@smile.fi.intel.com>
References: <20190813143906.9865-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813143906.9865-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 05:39:06PM +0300, Andy Shevchenko wrote:
> DMADEVICES option depends on HAS_DMA, and this dependency is ignored
> when DMADEVICES is being selected.
> 
> Replace 'select' by 'depends on' in Kconfig for RAPIDIO_DMA_ENGINE.

Anybody to comment on this?

> 
> Fixes: e42d98ebe7d7 ("rapidio: add DMA engine support for RIO data transfers")
> Cc: Alexandre Bounine <alexandre.bounine@idt.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/rapidio/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rapidio/Kconfig b/drivers/rapidio/Kconfig
> index 677d1aff61b7..788e7830771b 100644
> --- a/drivers/rapidio/Kconfig
> +++ b/drivers/rapidio/Kconfig
> @@ -37,7 +37,7 @@ config RAPIDIO_ENABLE_RX_TX_PORTS
>  config RAPIDIO_DMA_ENGINE
>  	bool "DMA Engine support for RapidIO"
>  	depends on RAPIDIO
> -	select DMADEVICES
> +	depends on DMADEVICES
>  	select DMA_ENGINE
>  	help
>  	  Say Y here if you want to use DMA Engine frameork for RapidIO data
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


