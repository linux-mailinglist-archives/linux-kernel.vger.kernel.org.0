Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A008E15CE0F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 23:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgBMW1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 17:27:52 -0500
Received: from mga02.intel.com ([134.134.136.20]:24096 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgBMW1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 17:27:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 14:27:51 -0800
X-IronPort-AV: E=Sophos;i="5.70,438,1574150400"; 
   d="scan'208";a="227397990"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 14:27:51 -0800
Date:   Thu, 13 Feb 2020 14:27:50 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] x86/mce: Change default mce logger to check
 mce->handled
Message-ID: <20200213222750.GC21107@agluck-desk2.amr.corp.intel.com>
References: <20200212204652.1489-1-tony.luck@intel.com>
 <20200212204652.1489-6-tony.luck@intel.com>
 <20200213170820.GN31799@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213170820.GN31799@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 06:08:20PM +0100, Borislav Petkov wrote:
> I definitely like where this is going.

Thanks.

> Another thing: what do we do if we have to deviate from that sequantial
> path through the notifiers? What if notifier A gets to look at an error,
> then another notifier B needs to look at it and then the information
> obtained from the second notifier B, is needed by the first notifier A
> again to inspect the error a *second* time.

That's pretty hard with a chain.  I think folks will have a conniptions
if we invent an error return from a notifier chain function that means
"Go back and start over". Though if we did it would make the "handled"
field useful for functions that didn't want to redo ... they'd just
check if "their" bit in handled was already set.

Still, seems like a terrible idea.

> I don't think there's a case like that now but I'm just playing the
> devil's advocate here. Because a use case like that would break our
> simplistic, sequential assembly line of MCE decoding.

If some driver really wants multiple bites at an error on the
chain it could register more than one handler with different
priorities.  In which case we should have "enum" names for the
highest and lowest priorities so such a driver can go "first"
or "last" (though such a thing would be dependent on whether
some other driver was attempting to add a "first" or "last"
entry on the chain).

-Tony
