Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 686F59063E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 18:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfHPQ4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 12:56:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:35899 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfHPQ4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 12:56:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 09:56:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,393,1559545200"; 
   d="scan'208";a="376760471"
Received: from ppiatekx-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.39.24])
  by fmsmga005.fm.intel.com with ESMTP; 16 Aug 2019 09:56:10 -0700
Date:   Fri, 16 Aug 2019 19:56:08 +0300
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
Message-ID: <20190816165608.j6slxb2hpamokvts@linux.intel.com>
References: <20190713170804.2340-1-jarkko.sakkinen@linux.intel.com>
 <20190713170804.2340-25-jarkko.sakkinen@linux.intel.com>
 <e7b51875-c190-bab6-28ec-0eaa6caf2955@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7b51875-c190-bab6-28ec-0eaa6caf2955@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 03:37:03PM -0700, Xing, Cedric wrote:
> > +$(TEST_CUSTOM_PROGS): $(OUTPUT)/main.o $(OUTPUT)/sgx_call.o \
> > +		      $(OUTPUT)/encl_piggy.o
> > +	$(CC) $(HOST_CFLAGS) -o $@ $^
> > +
> > +$(OUTPUT)/main.o: main.c
> > +	$(CC) $(HOST_CFLAGS) -c $< -o $@
> 
> .o files don't have to be generated/kept. And to be consistent with other
> selftests, please don't generate/keep them.

AFAIK there is no rule that .o files can't be generated when it makes
sense.

In your other comment you correctly pointed out that "-I$(OUTPUT)" was
missing when compiling encl_piggy.S. However, it is required neither
main.c nor sgx_call.c, and thus should not be used there.

The consequences are:

1. The enclave can and should be compiled like you suggest here.
2. The enclave hosting program must be compiled as it has been.

/Jarkko
