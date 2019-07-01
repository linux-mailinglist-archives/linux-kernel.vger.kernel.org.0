Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2D4C1FEA9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 07:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfEPFBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 01:01:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:50290 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfEPFBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 01:01:46 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2019 22:01:45 -0700
X-ExtLoop1: 1
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.189])
  by fmsmga008.fm.intel.com with ESMTP; 15 May 2019 22:01:40 -0700
Date:   Thu, 16 May 2019 08:01:50 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Dr. Greg" <greg@enjellic.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "nhorman@redhat.com" <nhorman@redhat.com>,
        "npmccallum@redhat.com" <npmccallum@redhat.com>,
        "Ayoun, Serge" <serge.ayoun@intel.com>,
        "Katz-zamir, Shay" <shay.katz-zamir@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Svahn, Kai" <kai.svahn@intel.com>, Borislav Petkov <bp@alien8.de>,
        Josh Triplett <josh@joshtriplett.org>,
        "Huang, Kai" <kai.huang@intel.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v20 00/28] Intel SGX1 support
Message-ID: <20190516050150.GA6388@linux.intel.com>
References: <358e9b36-230f-eb18-efdb-b472be8438b4@fortanix.com>
 <960B34DE67B9E140824F1DCDEC400C0F4E886094@ORSMSX116.amr.corp.intel.com>
 <6da269d8-7ebb-4177-b6a7-50cc5b435cf4@fortanix.com>
 <CALCETrWCZQwg-TUCm58DVG43=xCKRsMe1tVHrR8vdt06hf4fWA@mail.gmail.com>
 <20190513102926.GD8743@linux.intel.com>
 <20190514104323.GA7591@linux.intel.com>
 <CALCETrVbgTCnPo=PAq0-KoaRwt--urrPzn==quAJ8wodCpkBkw@mail.gmail.com>
 <20190514204527.GC1977@linux.intel.com>
 <20190515103531.GB10917@linux.intel.com>
 <20190515132147.GA5875@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515132147.GA5875@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 06:21:47AM -0700, Sean Christopherson wrote:
> On Wed, May 15, 2019 at 01:35:31PM +0300, Jarkko Sakkinen wrote:
> > On Tue, May 14, 2019 at 01:45:27PM -0700, Sean Christopherson wrote:
> > > On Tue, May 14, 2019 at 08:13:36AM -0700, Andy Lutomirski wrote:
> > > > I think it's as simple as requiring that, if SECINFO.X is set, then
> > > > the src pointer points to the appropriate number of bytes of
> > > > executable memory.  (Unless there's some way for an enclave to change
> > > > SECINFO after the fact -- is there?)
> > > 
> > > Nit: SECINFO is just the struct passed to EADD, I think what you're really
> > > asking is "can the EPCM permissions be changed after the fact".
> > > 
> > > And the answer is, yes.
> > > 
> > > On SGX2 hardware, the enclave can extend the EPCM permissions at runtime
> > > via ENCLU[EMODPE], e.g. to make a page writable.
> > 
> > Small correction: it is EMODPR.
> 
> No, I'm referring to EMODPE, note the ENCLU classification.
> 
> > Anyway, it is good to mention that these would require EACCEPT from the
> > enclave side. In order to take advantage of this is in a malicous
> > enclave, one would require SELinux/IMA/whatnot policy to have permitted
> > it in the first place.
> 
> EMODPE doesn't require EACCEPT or any equivalent from the kernel.  As
> you alluded to, the page tables would still need to allow PROT_EXEC.  I
> was simply trying to answer Andy's question regarding SECINFO.

Ah, have to admit that I had totally forgot EMODPE :-) Have not had
to deal with that opcode that much.

/Jarkko
