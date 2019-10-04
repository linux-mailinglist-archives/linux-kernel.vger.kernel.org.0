Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F235DCB5AA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 10:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbfJDIDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 04:03:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:28702 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729252AbfJDIDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 04:03:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 01:03:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,255,1566889200"; 
   d="scan'208";a="205802407"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 04 Oct 2019 01:03:40 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 04 Oct 2019 11:03:40 +0300
Date:   Fri, 4 Oct 2019 11:03:40 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: System hangs if NVMe/SSD is removed during suspend
Message-ID: <20191004080340.GB2819@lahna.fi.intel.com>
References: <20191002122136.GD2819@lahna.fi.intel.com>
 <20191003165033.GC3247445@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003165033.GC3247445@devbig004.ftw2.facebook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 09:50:33AM -0700, Tejun Heo wrote:
> Hello, Mika.
> 
> On Wed, Oct 02, 2019 at 03:21:36PM +0300, Mika Westerberg wrote:
> > but from that discussion I don't see more generic solution to be
> > implemented.
> > 
> > Any ideas we should fix this properly?
> 
> Yeah, the only fix I can think of is not using freezable wq.  It's
> just not a good idea and not all that difficult to avoid using.

OK, thanks.

In that case I will just make a patch that removes WQ_FREEZABLE from
bdi_wq and see what people think about it :)
