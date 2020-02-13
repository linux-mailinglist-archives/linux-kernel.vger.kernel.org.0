Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B055A15CE03
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 23:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgBMWTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 17:19:16 -0500
Received: from mga18.intel.com ([134.134.136.126]:28415 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727705AbgBMWTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 17:19:16 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 14:19:15 -0800
X-IronPort-AV: E=Sophos;i="5.70,438,1574150400"; 
   d="scan'208";a="227395334"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 14:19:15 -0800
Date:   Thu, 13 Feb 2020 14:19:13 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] x86/mce: Fix all mce notifiers to update the
 mce->handled bitmask
Message-ID: <20200213221913.GB21107@agluck-desk2.amr.corp.intel.com>
References: <20200212204652.1489-1-tony.luck@intel.com>
 <20200212204652.1489-5-tony.luck@intel.com>
 <20200213170308.GM31799@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213170308.GM31799@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 06:03:08PM +0100, Borislav Petkov wrote:
> On Wed, Feb 12, 2020 at 12:46:51PM -0800, Tony Luck wrote:
> > If the handler took any action to log or deal with the error, set
> > a bit int mce->handled so that the default handler on the end of
> > the machine check chain can see what has been done.
> > 
> > [!!! What to do about NOTIFY_STOP ... any handler that returns this
> > value short-circuits calling subsequent entries on the chain. In
> > some cases this may be the right thing to do ... but it others we
> > really want to keep calling other functions on the chain]
> 
> Yes, we can kill that NOTIFY_STOP thing in the mce code since it is
> nasty.

Well, there are places where we want to keep NOTIFY_STOP.

1) Default case for CEC.  We want it to "hide" the corrected error.
   That was one of the main goals for CEC.  We've discussed cases
   where CEC shouldn't hide (when internal threshold exceeded and
   it tries to take a page offline ... probably something related to
   CMCI storms ... though we didn't really come to any conclusion)
2) Errata. Perhaps a vendor/platform specific function at the head
   of the notify chain that weeds out errors that should never have
   been reported.

> Then, from the looks of it, there should be a function at the end of
> the chain which decides whether to print or not, just by looking at
> ->handled.

That's there now. See mce_default_notifier()

> For example, it should not print MCE_HANDLED_CEC or MCE_HANDLED_EDAC,
> etc cases. The assumption for the latter being that EDAC does its own
> printing. Which then makes me wonder whether MCE_HANDLED_EDAC is enough.

But may need some refining.

> Because this one bit would basically determine whether the error gets
> printed or not. Which would mean that all EDAC drivers should print
> it...

Alternative wording "An EDAC driver should only set the bit if it printed
something useful about the error."

-Tony
