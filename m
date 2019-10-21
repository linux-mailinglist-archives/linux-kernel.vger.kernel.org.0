Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7DBCDE813
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 11:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfJUJbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 05:31:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:7457 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbfJUJbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:31:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 02:31:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,323,1566889200"; 
   d="scan'208";a="203289636"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Oct 2019 02:31:31 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iMU2E-00028z-OJ; Mon, 21 Oct 2019 12:31:30 +0300
Date:   Mon, 21 Oct 2019 12:31:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: byteorder: cpu_to_le32_array vs cpu_to_be32_array function API
 differences
Message-ID: <20191021093130.GL32742@smile.fi.intel.com>
References: <2acb30fb3c9a86ac8cc882fb787cd04e5864224b.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2acb30fb3c9a86ac8cc882fb787cd04e5864224b.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2019 at 12:02:52PM -0700, Joe Perches wrote:
> There's an argument inconsistency between these 4 functions
> in include/linux/byteorder/generic.h
> 
> It'd be more a consistent API with one form and not two.

This is done in order to:
 - avoid changing existing code
 - start a very this discussion to see what we can do if it's even needed to be done

So, do we have other places in the kernel which can utilize either of these?

-- 
With Best Regards,
Andy Shevchenko


