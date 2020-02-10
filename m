Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D31B157DD7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 15:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgBJOxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 09:53:35 -0500
Received: from mga01.intel.com ([192.55.52.88]:19165 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbgBJOxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:53:34 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 06:53:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,425,1574150400"; 
   d="scan'208";a="405606798"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 10 Feb 2020 06:53:31 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j1ARJ-000Zbj-E8; Mon, 10 Feb 2020 16:53:33 +0200
Date:   Mon, 10 Feb 2020 16:53:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1] MAINTAINERS: Sort entries in database for VSPRINTF
Message-ID: <20200210145333.GW10400@smile.fi.intel.com>
References: <20200128143425.47283-1-andriy.shevchenko@linux.intel.com>
 <20200210142154.x2azckvduvh3xuea@pathway.suse.cz>
 <20200210145129.GV10400@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210145129.GV10400@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 04:51:29PM +0200, Andy Shevchenko wrote:
> On Mon, Feb 10, 2020 at 03:21:55PM +0100, Petr Mladek wrote:

> > Also the order does not look defined in the file. When I run
> > parse-maintainers.pl on the entire MAINTAINERS file:
> 
> See [2] for the details.

"... But in the meantime, at least that MAINTAINERS file should _really_ be
alpha-sorted now."

> [2]: https://lore.kernel.org/lkml/CA+55aFy3naVgbRubhjfq7k4CcSiFOEdQNkNwHTLDLmepECu9yA@mail.gmail.com/

-- 
With Best Regards,
Andy Shevchenko


