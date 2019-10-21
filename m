Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F01CDE4D6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 08:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfJUGws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 02:52:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:56731 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfJUGwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 02:52:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Oct 2019 23:52:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,322,1566889200"; 
   d="scan'208";a="398570957"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 20 Oct 2019 23:52:45 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iMRYb-0008CA-2b; Mon, 21 Oct 2019 09:52:45 +0300
Date:   Mon, 21 Oct 2019 09:52:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Anatol Belski <weltling@outlook.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        "trivial@kernel.org" <trivial@kernel.org>
Subject: Re: [PATCH] include/linux/byteorder/generic.h: fix signed/unsigned
 warnings
Message-ID: <20191021065245.GH32742@smile.fi.intel.com>
References: <AM0PR0502MB3668B1A0EC328690DA25E9C6BA6E0@AM0PR0502MB3668.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR0502MB3668B1A0EC328690DA25E9C6BA6E0@AM0PR0502MB3668.eurprd05.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2019 at 05:22:30PM +0000, Anatol Belski wrote:
> From: Anatol Belski <anbelski@microsoft.com>

Better to add commit message even for small patches like this.
Do you have compiler / sparse / etc warning? Cite it here as well!

-- 
With Best Regards,
Andy Shevchenko


