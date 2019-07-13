Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7619667ADE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2019 17:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfGMPPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jul 2019 11:15:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:43230 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbfGMPPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 11:15:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2019 08:15:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,486,1557212400"; 
   d="scan'208";a="318271993"
Received: from hbriegel-mobl.ger.corp.intel.com ([10.252.50.48])
  by orsmga004.jf.intel.com with ESMTP; 13 Jul 2019 08:15:27 -0700
Message-ID: <8bf125023ad2e99a8620112a393ca95f9939f4fd.camel@linux.intel.com>
Subject: Re: [RFC PATCH v4 1/3] selftests/x86/sgx: Fix Makefile for SGX
 selftest
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Cedric Xing <cedric.xing@intel.com>, linux-kernel@vger.kernel.org,
        linux-sgx@vger.kernel.org
Cc:     akpm@linux-foundation.org, dave.hansen@intel.com,
        sean.j.christopherson@intel.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, haitao.huang@intel.com,
        kai.svahn@intel.com, kai.huang@intel.com
Date:   Sat, 13 Jul 2019 18:15:26 +0300
In-Reply-To: <c6a99c107c1e6b814c1968146c87291c3e84aa2f.camel@linux.intel.com>
References: <cover.1563000446.git.cedric.xing@intel.com>
         <757d44a0e67bfa09d97eea918bc0d20383b5e80e.1563000446.git.cedric.xing@intel.com>
         <c6a99c107c1e6b814c1968146c87291c3e84aa2f.camel@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-07-13 at 18:10 +0300, Jarkko Sakkinen wrote:
> On Fri, 2019-07-12 at 23:51 -0700, Cedric Xing wrote:
> > The original x86/sgx/Makefile didn't work when "x86/sgx" was specified as the
> > test target, nor did it work with "run_tests" as the make target. Yet another
> > problem was that it breaks 32-bit only build. This patch fixes those problems,
> > along with adjustments to compiler/linker options and simplifications to the
> > build rules.
> > 
> > Signed-off-by: Cedric Xing <cedric.xing@intel.com>
> 
> You must split this in quite a few separate patches:
> 
> 1. One for each fix.
> 2. At least one patch for each change in compiler and linker options with a
>    commit message clearly expalaining why the change was made.
> 3. One for each simplification.
> 
> We don't support 32-bit build:
> 
> config INTEL_SGX
> 	bool "Intel SGX core functionality"
> 	depends on X86_64 && CPU_SUP_INTEL

This is not to say that changes suck. This just in "unreviewable" state as far
as the kernel processes go...

/Jarkko

