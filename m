Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFF0429987
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 15:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404041AbfEXN5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 09:57:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:30660 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403843AbfEXN5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 09:57:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 06:57:44 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga007.jf.intel.com with ESMTP; 24 May 2019 06:57:43 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hUAha-0003ec-Oc; Fri, 24 May 2019 16:57:42 +0300
Date:   Fri, 24 May 2019 16:57:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 4/9] genirq/timings: Use the min kernel macro
Message-ID: <20190524135742.GX9224@smile.fi.intel.com>
References: <20190524111615.4891-1-daniel.lezcano@linaro.org>
 <20190524111615.4891-5-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524111615.4891-5-daniel.lezcano@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 01:16:10PM +0200, Daniel Lezcano wrote:
> The' min' is available as a kernel macro. Use it instead of writing
> the same code.

While it's technically correct...

>  	/*
>  	 * 'count' will depends if the circular buffer wrapped or not
>  	 */
> -	count = irqs->count < IRQ_TIMINGS_SIZE ?
> -		irqs->count : IRQ_TIMINGS_SIZE;
> +	count = min_t(int, irqs->count,  IRQ_TIMINGS_SIZE);
>  
>  	start = irqs->count < IRQ_TIMINGS_SIZE ?
>  		0 : (irqs->count & IRQ_TIMINGS_MASK);

...looking to the context I would leave as is to have a pattern.

-- 
With Best Regards,
Andy Shevchenko


