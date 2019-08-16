Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01392904FA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 17:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfHPPwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 11:52:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:61553 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727312AbfHPPwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 11:52:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 08:51:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,393,1559545200"; 
   d="scan'208";a="168084887"
Received: from ppiatekx-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.39.24])
  by orsmga007.jf.intel.com with ESMTP; 16 Aug 2019 08:51:37 -0700
Date:   Fri, 16 Aug 2019 18:51:36 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Xing, Cedric" <cedric.xing@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, bp@alien8.de, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com
Subject: Re: [PATCH v21 24/28] selftests/x86: Add a selftest for SGX
Message-ID: <20190816155136.po23te4zi3k263wm@linux.intel.com>
References: <20190713170804.2340-1-jarkko.sakkinen@linux.intel.com>
 <20190713170804.2340-25-jarkko.sakkinen@linux.intel.com>
 <e7b51875-c190-bab6-28ec-0eaa6caf2955@intel.com>
 <20190816154344.223mtts6jngx424d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816154344.223mtts6jngx424d@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 06:43:44PM +0300, Jarkko Sakkinen wrote:
> On Wed, Jul 17, 2019 at 03:37:03PM -0700, Xing, Cedric wrote:
> > > +$(OUTPUT)/encl.bin: $(OUTPUT)/encl.elf $(OUTPUT)/sgxsign
> > > +	objcopy --remove-section=.got.plt -O binary $< $@
> > 
> > .got.plt section will never be present for statically linked binaries.
> 
> You are right that it should not be there because the enclave does not
> use any library calls. And if it did, we would want to assert that and
> fail the compilation if it is the case.
> 
> Assuming that .got.plt can never exist in a static binary, however, is
> simply not true. A common example are library calls such as strncpy().
> The default handler selects the fastest implementation and substitutes
> that to the GOT.
> 
> The right way to fix this is to assert it in the linker script.

In addition, objcopy should be replaced with $(OBJCOPY).

/Jarkko
