Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02F49DE847
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 11:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfJUJio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 05:38:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:10541 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbfJUJio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:38:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 02:38:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,323,1566889200"; 
   d="scan'208";a="200379705"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 21 Oct 2019 02:38:40 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iMU99-0002Ct-TE; Mon, 21 Oct 2019 12:38:39 +0300
Date:   Mon, 21 Oct 2019 12:38:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Anatol Belski <weltling@outlook.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Michael Jamet <michael.jamet@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        "trivial@kernel.org" <trivial@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] include/linux/byteorder/generic.h: fix
 signed/unsigned warnings
Message-ID: <20191021093839.GM32742@smile.fi.intel.com>
References: <AM0PR0502MB366860AC878296E4E76DD223BA690@AM0PR0502MB3668.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR0502MB366860AC878296E4E76DD223BA690@AM0PR0502MB3668.eurprd05.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 09:27:37AM +0000, Anatol Belski wrote:
> From: Anatol Belski <anbelski@microsoft.com>
> 
> This fixes the warnings like below, thrown by GCC
> 
> warning: comparison of integer expressions of different signedness: \
> ‘int’ and ‘size_t’ {aka ‘long unsigned int’} [-Wsign-compare]
>   195 |  for (i = 0; i < len; i++)
>       |                ^

We have explicitly disabled this warnings in the kernel Makefile.
How did you achieve this? (yes, I know the possible answer, perhaps
this has to be mentioned as well)

Now I see some inconsistency with this warning between GCC and Clang. Add
related people to the discussion.

> Signed-off-by: Anatol Belski <anbelski@microsoft.com>
> ---

Changelog is missing.
(No need to resend just for this, it's for your future contributions)

-- 
With Best Regards,
Andy Shevchenko


