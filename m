Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA45BDFD5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 16:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436835AbfIYOQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 10:16:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:60022 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436799AbfIYOQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 10:16:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2019 07:16:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,548,1559545200"; 
   d="scan'208";a="340420625"
Received: from kmakows-mobl.ger.corp.intel.com (HELO localhost) ([10.249.39.225])
  by orsmga004.jf.intel.com with ESMTP; 25 Sep 2019 07:16:10 -0700
Date:   Wed, 25 Sep 2019 17:16:09 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, josh@joshtriplett.org, luto@kernel.org,
        kai.huang@intel.com, rientjes@google.com, cedric.xing@intel.com,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v22 03/24] x86/mm: x86/sgx: Signal SIGSEGV with PF_SGX
Message-ID: <20190925141609.GC19638@linux.intel.com>
References: <20190903142655.21943-1-jarkko.sakkinen@linux.intel.com>
 <20190903142655.21943-4-jarkko.sakkinen@linux.intel.com>
 <20190924160442.GH19317@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924160442.GH19317@zn.tnic>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 06:04:42PM +0200, Borislav Petkov wrote:
> > +	/*
> > +	 * Access is blocked by the Enclave Page Cache Map (EPCM), i.e. the
> > +	 * access is allowed by the PTE but not the EPCM.  This usually happens
> > +	 * when the EPCM is yanked out from under us, e.g. by hardware after a
> > +	 * suspend/resume cycle.  In any case, software, i.e. the kernel, can't
> > +	 * fix the source of the fault as the EPCM can't be directly modified
> > +	 * by software.  Handle the fault as an access error in order to signal
> > +	 * userspace, e.g. so that userspace can rebuild their enclave(s), even
> 
> s/, e.g.//

Thanks I fixed this in my tree. Also, quite many sentences seem that have
two spacebars after the end of sentence. I fixed those too.

/Jarkko
