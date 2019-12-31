Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7301912D9FD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Dec 2019 17:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfLaQAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Dec 2019 11:00:08 -0500
Received: from mga06.intel.com ([134.134.136.31]:41021 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfLaQAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 11:00:08 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Dec 2019 08:00:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,379,1571727600"; 
   d="scan'208";a="251737690"
Received: from vmauer-mobl.ger.corp.intel.com (HELO localhost) ([10.252.22.151])
  by fmsmga002.fm.intel.com with ESMTP; 31 Dec 2019 08:00:02 -0800
Date:   Tue, 31 Dec 2019 18:00:01 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Bundy <christianbundy@fraction.io>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable-commits@vger.kernel.org, linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Patch "tpm_tis: reserve chip for duration of tpm_tis_core_init"
 has been added to the 5.4-stable tree
Message-ID: <20191231155944.GA4790@linux.intel.com>
References: <1577122577157232@kroah.com>
 <CAPcyv4jfpOX85GWgNTyugWksU=e-j=RhU_fcrcHBo4GMZ8_bhw@mail.gmail.com>
 <c6ce34b130210d2d1330fc4079d6d82bd74dcef1.camel@linux.intel.com>
 <50217a688ffa56cf5f150ffd358daba2a88cad48.camel@linux.intel.com>
 <20191228151526.GA6971@linux.intel.com>
 <CAPcyv4i_frm8jZeknniPexp8AAmGsaq0_DHegmL4XZHQi1ThxA@mail.gmail.com>
 <CAPcyv4iyQeXBWvp8V_UPBsOk29cfmTVZGYrrDgyYYqzsQvTjNA@mail.gmail.com>
 <2c4a80e0d30bf1dfe89c6e3469d1dbfb008275fa.camel@linux.intel.com>
 <20191231010256.kymv4shwmx5jcmey@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191231010256.kymv4shwmx5jcmey@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 06:02:56PM -0700, Jerry Snitselaar wrote:
> On Tue Dec 31 19, Jarkko Sakkinen wrote:
> > On Sun, 2019-12-29 at 23:41 -0800, Dan Williams wrote:
> > > This looked like the wrong revert to me, and testing confirms that
> > > this does not fix the problem.
> > > 
> > > As I mentioned in the original report [1] the commit that bisect flagged was:
> > > 
> > >     5b359c7c4372 tpm_tis_core: Turn on the TPM before probing IRQ's
> > > 
> > > That commit moved tpm_chip_start() before irq probing. Commit
> > > 21df4a8b6018 "tpm_tis: reserve chip for duration of tpm_tis_core_init"
> > > does not appear to change anything in that regard.
> > > 
> > > Perhaps this hardware has always had broken interrupts and needs to be
> > > quirked off? I'm trying an experiment with tpm_tis_core.interrupts=0
> > > workaround.
> > > 
> > > 
> > > [1]: https://lore.kernel.org/linux-integrity/CAA9_cmeLnHK4y+usQaWo72nUG3RNsripuZnS-koY4XTRC+mwJA@mail.gmail.com/
> > 
> > I think for short term, yes, it is better to revert the commits
> > that make things more broken.
> > 
> > for-linus-v5.5-rc5 branch contains three commits that exactly do
> > this i.e. the reverts that Stefan sent and revert to Jerry's earlier
> > commit.
> > 
> > After that is out of the table it is easier to analyze how the code
> > should be actually refactored. Like, I have no idea when I get
> > local HW that can reproduce this and Jerry still seems to have the
> > same issue. It'd be nice make the exactly right changes instead of
> > reverts but situation is what it is.
> > 
> 
> The only other thought I had was moving the tpm_chip_start/stop
> into tpm_tis_probe_irq_single around the tpm_tis_gen_interrupt call.
> I don't know why doing the clkrun bit after setting the interrupt
> register values would matter, but I'm not sure what else there is
> that would be different than when that stuff was happening in
> down in tpm_try_transmit. Without hardware to poke at it is hard
> to get anywhere.

I think in the current timeframe it is better to reset to best known
state like Dan suggested given the limited testing abilities.

Hopefully Dan can test this after the holidays and I also informed
about the branch here:

https://bugzilla.kernel.org/show_bug.cgi?id=205935

/Jarkko
