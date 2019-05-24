Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91EBD29997
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 16:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404026AbfEXOAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 10:00:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:30871 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403876AbfEXOAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 10:00:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 07:00:50 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga001.fm.intel.com with ESMTP; 24 May 2019 07:00:47 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hUAkX-0003gA-M2; Fri, 24 May 2019 17:00:45 +0300
Date:   Fri, 24 May 2019 17:00:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Petr Mladek <pmladek@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Changbin Du <changbin.du@intel.com>
Subject: Re: [PATCH V2 7/9] genirq/timings: Add selftest for circular array
Message-ID: <20190524140045.GY9224@smile.fi.intel.com>
References: <20190524111615.4891-1-daniel.lezcano@linaro.org>
 <20190524111615.4891-8-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524111615.4891-8-daniel.lezcano@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 01:16:13PM +0200, Daniel Lezcano wrote:
> Due to the complexity of the code and the difficulty to debug it,
> let's add some selftests to the framework in order to spot issues or
> regression at boot time when the runtime testing is enabled for this
> subsystem.
> 
> This tests the circular buffer at the limits and validates:
>  - the encoding / decoding of the values
>  - the macro to browse the irq timings circular buffer
>  - the function to push data in the circular buffer

Can it use kselftest infrastructure?


-- 
With Best Regards,
Andy Shevchenko


