Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0CD9173DA9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 17:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgB1QzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 11:55:03 -0500
Received: from mga03.intel.com ([134.134.136.65]:11161 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgB1QzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:55:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 08:55:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,496,1574150400"; 
   d="scan'208";a="272703638"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga002.fm.intel.com with ESMTP; 28 Feb 2020 08:55:01 -0800
Message-ID: <333f90f8ded76bf11c6b90f1db174c841ec89ed9.camel@intel.com>
Subject: Re: [PATCH v2 8/8] x86/fpu/xstate: Restore supervisor xstates for
 __fpu__restore_sig()
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Fri, 28 Feb 2020 08:54:14 -0800
In-Reply-To: <20200228165021.76pec2cdudmtpxeu@linutronix.de>
References: <20200121201843.12047-1-yu-cheng.yu@intel.com>
         <20200121201843.12047-9-yu-cheng.yu@intel.com>
         <20200221175859.GL25747@zn.tnic>
         <77f3841a92df5d0c819699ee3612118d566b7445.camel@intel.com>
         <20200228121724.GA25261@zn.tnic>
         <89bcab262d6dad4c08c4a21e522796fea2320db3.camel@intel.com>
         <20200228162359.GC25261@zn.tnic>
         <6f91699c91f9ea0f527e80ed3ea2999444a8d2d1.camel@intel.com>
         <20200228165021.76pec2cdudmtpxeu@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-02-28 at 17:50 +0100, Sebastian Andrzej Siewior wrote:
> On 2020-02-28 08:20:27 [-0800], Yu-cheng Yu wrote:
> > On Fri, 2020-02-28 at 17:23 +0100, Borislav Petkov wrote:
> > > On Fri, Feb 28, 2020 at 07:53:38AM -0800, Yu-cheng Yu wrote:
> > > > Yes, saving only supervisor states is optimal, but doing XSAVES with a
> > > > partial RFBM changes xcomp_bv.
> > > 
> > > ... and that means what exactly in plain english?
> > 
> > When XSAVES writes to an xsave buffer, xsave->header.xcomp_bv is set to
> > include only saved components, effectively changing the buffer's format.
> 
> How large is this supervisor state at most? I guess saving the AVX512
> state just to get the 2 bytes of the supervisor state at the right spot
> is not really optimal.
> But this is the performance division…
> 
> > I will include this in the comments.
> 
> If you do so, please state that the first hunk is only interested in the
> supervisor-state bits and everything else is ignored.

Yes, I will include that.

Yu-cheng

