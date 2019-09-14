Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 675D8B2CAA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2019 21:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbfINTW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Sep 2019 15:22:57 -0400
Received: from mga07.intel.com ([134.134.136.100]:16855 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727663AbfINTW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 15:22:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2019 12:22:56 -0700
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="190663609"
Received: from spandruv-mobl.amr.corp.intel.com ([10.251.128.136])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2019 12:22:55 -0700
Message-ID: <85876cd057ff5f871dd830ff19a6e32c83e8e344.camel@linux.intel.com>
Subject: Re: [PATCH 0/5] tools/power/x86/intel-speed-select: New command and
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        prarit@redhat.com, darcari@redhat.com
Date:   Sat, 14 Sep 2019 12:22:54 -0700
In-Reply-To: <20190914171950.GW2680@smile.fi.intel.com>
References: <20190914070513.19807-1-srinivas.pandruvada@linux.intel.com>
         <20190914171950.GW2680@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-09-14 at 20:19 +0300, Andy Shevchenko wrote:
> On Sat, Sep 14, 2019 at 12:05:08AM -0700, Srinivas Pandruvada wrote:
> > This series contains some minor fixes, when firmware mask is
> > including
> > invalid CPU in the perf-profile mask. Also add some commands to
> > better manage core-power feature.
> 
> Hmm... 150+ LOCs doesn't count to me as minor fixes.
> So, are you considering this a material for v5.4?
Sorry, I should be clear. It is for 5.4. I am trying to catch merge
window. None of the fixes are critical. The majority of the code is
added for new command features.

What is your cut off for 5.4? I want to send some more features if
possible for 5.4.

Thanks,
Srinivas

> 
> 
> > Srinivas Pandruvada (4):
> >   tools/power/x86/intel-speed-select: Allow online/offline based on
> > tdp
> >   tools/power/x86/intel-speed-select: Format get-assoc information
> >   tools/power/x86/intel-speed-select: Fix some debug prints
> >   tools/power/x86/intel-speed-select: Extend core-power command set
> > 
> > Youquan Song (1):
> >   tools/power/x86/intel-speed-select: Fix high priority core mask
> > over
> >     count
> > 
> >  .../x86/intel-speed-select/isst-config.c      | 108
> > ++++++++++++++++--
> >  .../power/x86/intel-speed-select/isst-core.c  |  25 ++++
> >  .../x86/intel-speed-select/isst-display.c     |  51 +++++++++
> >  tools/power/x86/intel-speed-select/isst.h     |   9 +-
> >  4 files changed, 182 insertions(+), 11 deletions(-)
> > 
> > -- 
> > 2.17.2
> > 
> 
> 

