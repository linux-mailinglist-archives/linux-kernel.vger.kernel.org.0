Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E70867F7C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2019 16:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbfGNOyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Jul 2019 10:54:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:34543 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728146AbfGNOyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 10:54:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jul 2019 07:53:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,490,1557212400"; 
   d="scan'208";a="172006952"
Received: from hgenzken-mobl.ger.corp.intel.com (HELO localhost) ([10.249.35.131])
  by orsmga006.jf.intel.com with ESMTP; 14 Jul 2019 07:53:52 -0700
Date:   Sun, 14 Jul 2019 17:53:50 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Xing, Cedric" <cedric.xing@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        akpm@linux-foundation.org, dave.hansen@intel.com,
        sean.j.christopherson@intel.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, haitao.huang@intel.com,
        kai.svahn@intel.com, kai.huang@intel.com
Subject: Re: [RFC PATCH v4 1/3] selftests/x86/sgx: Fix Makefile for SGX
 selftest
Message-ID: <20190714145350.22cvim2u4mmkowr7@linux.intel.com>
References: <cover.1563000446.git.cedric.xing@intel.com>
 <757d44a0e67bfa09d97eea918bc0d20383b5e80e.1563000446.git.cedric.xing@intel.com>
 <c6a99c107c1e6b814c1968146c87291c3e84aa2f.camel@linux.intel.com>
 <8bf125023ad2e99a8620112a393ca95f9939f4fd.camel@linux.intel.com>
 <84c792d8-a5ef-1030-9072-9670b6ba966c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84c792d8-a5ef-1030-9072-9670b6ba966c@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 13, 2019 at 10:29:12AM -0700, Xing, Cedric wrote:
> Please note that your patchset hasn't been upstreamed yet. Your Makefile is
> problematic to begin with. Technically it's your job to make it work before
> sending out any patches. You didn't explain what's done for each line of
> Makefile in your commit message either.

Yes, it is different case to do the initial version of the whole thing
that suggest fixes to it. The latter needs to have more granularity.
Bug fixes in any type of software development should be isolated to
separate change sets. It is just a sane QA practice.

> Not saying documentation is unimportant, but the purposes for those changes
> are obvious and easy to understand for anyone having reasonable knowledge on
> how Makefile works.
>
> I'm totally fine not fixing the Makefile. You can just leave them out.

/Jarkko
