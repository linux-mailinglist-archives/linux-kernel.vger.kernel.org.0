Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6B787D77
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 17:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407258AbfHIPCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 11:02:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:39284 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbfHIPCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:02:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 08:02:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,364,1559545200"; 
   d="scan'208";a="186688037"
Received: from jsakkine-mobl1.tm.intel.com ([10.237.50.189])
  by orsmga002.jf.intel.com with ESMTP; 09 Aug 2019 08:02:09 -0700
Message-ID: <cb8a7d13a31588205d1c18521e58a0ee4bac03f8.camel@linux.intel.com>
Subject: Re: [PATCH v21 16/28] x86/sgx: Add the Linux SGX Enclave Driver
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     "Ayoun, Serge" <serge.ayoun@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "nhorman@redhat.com" <nhorman@redhat.com>,
        "npmccallum@redhat.com" <npmccallum@redhat.com>,
        "Katz-zamir, Shay" <shay.katz-zamir@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Svahn, Kai" <kai.svahn@intel.com>, "bp@alien8.de" <bp@alien8.de>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "Huang, Kai" <kai.huang@intel.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "Xing, Cedric" <cedric.xing@intel.com>
Date:   Fri, 09 Aug 2019 18:02:08 +0300
In-Reply-To: <20190808154000.GB23156@linux.intel.com>
References: <20190713170804.2340-1-jarkko.sakkinen@linux.intel.com>
         <20190713170804.2340-17-jarkko.sakkinen@linux.intel.com>
         <88B7642769729B409B4A93D7C5E0C5E7C65ABB8D@hasmsx108.ger.corp.intel.com>
         <20190807151534.kxsletvhbn3lno6w@linux.intel.com>
         <20190808154000.GB23156@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-08 at 08:40 -0700, Sean Christopherson wrote:
> On Wed, Aug 07, 2019 at 06:15:34PM +0300, Jarkko Sakkinen wrote:
> > On Mon, Jul 29, 2019 at 11:17:57AM +0000, Ayoun, Serge wrote:
> > > > +	/* TCS pages need to be RW in the PTEs, but can be 0 in the EPCM. */
> > > > +	if ((secinfo.flags & SGX_SECINFO_PAGE_TYPE_MASK) ==
> > > > SGX_SECINFO_TCS)
> > > > +		prot |= PROT_READ | PROT_WRITE;
> > > 
> > > For TCS pages you add both RD and WR maximum protection bits.
> > > For the enclave to be able to run, user mode will have to change the
> > > "vma->vm_flags" from PROT_NONE to PROT_READ | PROT_WRITE (otherwise
> > > eenter fails).  This is exactly what your selftest  does.
> > 
> > Recap where the TCS requirements came from? Why does it need
> > RW in PTEs and can be 0 in the EPCM? The comment should explain
> > it rather leave it as a claim IMHO.
> 
> Hardware ignores SECINFO.FLAGS.{R,W,X} coming from userspace and instead
> forces RWX=0.  It does this to prevent software from directly accessing
> the TCS.  But hardware still accesses the TCS through a virtual address,
> e.g. to allow software to zap the page for reclaim, which means hardware
> generates reads and writes to the TCS, i.e. the PTEs need RW permissions.

Manipulating a PTE should not require any specific permissions on the
page that it is defining. Why RW is required in SGX context?

> So, for the EADD ioctl(), it's not unreasonable for userspace to provide
> SECINFO.FLAGS.{R,W,X} = 0 for the TCS to match what will actually get
> jammed into the EPCM.  Allowing userspace to specify RWX=0 means the
> kernel needs to manually add PROT_READ and PROT_WRITE to the allowed prot
> bits so that mmap()/mprotect() work as expected.

Anyway, appreciate your throughtout explanation, thanks.

/Jarkko

