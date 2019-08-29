Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1B8CA1A9C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 15:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfH2NCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 09:02:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:41257 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbfH2NCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:02:16 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 06:02:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,443,1559545200"; 
   d="scan'208";a="185963100"
Received: from vtorregr-mobl1.amr.corp.intel.com (HELO araj-mobl1.jf.intel.com) ([10.251.148.126])
  by orsmga006.jf.intel.com with ESMTP; 29 Aug 2019 06:02:14 -0700
Date:   Thu, 29 Aug 2019 06:02:14 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Mihai Carabas <mihai.carabas@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jon Grimm <Jon.Grimm@amd.com>, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, patrick.colp@oracle.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] x86/microcode: Add an option to reload microcode even if
 revision is unchanged
Message-ID: <20190829130213.GA23510@araj-mobl1.jf.intel.com>
References: <1567056803-6640-1-git-send-email-ashok.raj@intel.com>
 <20190829060942.GA1312@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829060942.GA1312@zn.tnic>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 08:09:42AM +0200, Borislav Petkov wrote:
> On Wed, Aug 28, 2019 at 10:33:22PM -0700, Ashok Raj wrote:
> > During microcode development, its often required to test different versions
> > of microcode. Intel microcode loader enforces loading only if the revision is
> > greater than what is currently loaded on the cpu. Overriding this behavior
> > allows us to reuse the same revision during development cycles.
> > This facilty also allows us to share debug microcode with development
> > partners for getting feedback before microcode release.
> > 
> > Microcode developers should have other ways to check which
> > of their internal version is actually loaded. For e.g. checking a
> > temporary MSR for instance. In order to reload the same microcode do as
> > shown below.
> > 
> >  # echo 2 > /sys/devices/system/cpu/microcode/reload
> > 
> >  as root.
> > 
> > 
> > I tested this on top of the parallel ucode load patch
> > 
> > https://lore.kernel.org/r/1566506627-16536-2-git-send-email-mihai.carabas@oracle.com/
> > 
> > v2: [Mihai] Address comments from Boris
> > 	- Support for AMD
> > 	- add taint flag
> > 	- removed global force_ucode_load and parameterized it.
> 
> As I've said before, I don't like the churn in this version and how it
> turns out. I'll have a look at how to do this cleanly when I get some
> free cycles.

Thanks Boris. I'll wait for your updates. I remember your comment on another
simplification from the Boris Ostrovsky https://lore.kernel.org/r/20190828191618.GO4920@zn.tnic/

Mihai rolled in your suggestions noted above.

BTW, We only need to force on the late-load. Its not needed during early load.

Cheers,
Ashok
