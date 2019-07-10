Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E222964EC4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 00:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfGJWqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 18:46:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:3827 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfGJWqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 18:46:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 15:46:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,476,1557212400"; 
   d="scan'208";a="173986954"
Received: from teutenbb-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.50.108])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jul 2019 15:46:38 -0700
Date:   Thu, 11 Jul 2019 01:46:28 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Xing, Cedric" <cedric.xing@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        akpm@linux-foundation.org, dave.hansen@intel.com,
        sean.j.christopherson@intel.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, haitao.huang@intel.com,
        kai.svahn@intel.com, kai.huang@intel.com
Subject: Re: [RFC PATCH v2 0/3] An alternative __vdso_sgx_enter_enclave() to
 allow enclave/host parameter passing using untrusted stack
Message-ID: <20190710224628.epjxwlpqqxdurmzo@linux.intel.com>
References: <cover.1555965327.git.cedric.xing@intel.com>
 <20190424062623.4345-1-cedric.xing@intel.com>
 <20190710111719.nnoedfo4wvbfghq7@linux.intel.com>
 <686e47d2-f45c-6828-39d1-48374925de6c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <686e47d2-f45c-6828-39d1-48374925de6c@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 11:08:37AM -0700, Xing, Cedric wrote:
> > With these conclusions I think the current vDSO API is sufficient for
> > Linux.
> 
> The new vDSO API is to support data exchange on stack. It has nothing to do
> with debugging. BTW, the community has closed on this.

And how that is useful?

> The CFI directives are for stack unwinding. They don't affect what the code
> does so you can just treat them as NOPs if you don't understand what they
> do. However, they are useful to not only debuggers but also exception
> handling code. libunwind also has a setjmp()/longjmp() implementation based
> on CFI directives.

Of course I won't merge code of which usefulness I don't understand.

/Jarkko
