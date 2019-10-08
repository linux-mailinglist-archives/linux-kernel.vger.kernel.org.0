Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB68CFB59
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 15:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbfJHNbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 09:31:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:44349 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730249AbfJHNbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:31:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 06:31:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,270,1566889200"; 
   d="scan'208";a="393344850"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by fmsmga005.fm.intel.com with ESMTP; 08 Oct 2019 06:31:44 -0700
Date:   Tue, 8 Oct 2019 06:31:44 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, nhorman@redhat.com, npmccallum@redhat.com,
        serge.ayoun@intel.com, shay.katz-zamir@intel.com,
        haitao.huang@intel.com, andriy.shevchenko@linux.intel.com,
        tglx@linutronix.de, kai.svahn@intel.com, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com,
        cedric.xing@intel.com
Subject: Re: [PATCH v22 09/24] x86/sgx: Add functions to allocate and free
 EPC pages
Message-ID: <20191008133144.GA14020@linux.intel.com>
References: <20190903142655.21943-1-jarkko.sakkinen@linux.intel.com>
 <20190903142655.21943-10-jarkko.sakkinen@linux.intel.com>
 <20191005164408.GB25699@zn.tnic>
 <20191007145011.GA18016@linux.intel.com>
 <20191008090931.GC14765@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008090931.GC14765@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 11:09:31AM +0200, Borislav Petkov wrote:
> On Mon, Oct 07, 2019 at 07:50:11AM -0700, Sean Christopherson wrote:
> > The caller is responsible for ensuring EREMOVE can be safely executed,
> > e.g. by holding the enclave's lock.
> 
> lockdep_assert_held() here maybe?

There are a few flows where a page can be removed without holding a lock,
e.g. when the enclave is being released, and for Version Array (VA) pages,
which are not associated with a single enclave.  We could probably force
a lockdep assert with an extra parameter, but I'm not sure that'd be a net
positive.
