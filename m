Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 148F6D001B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 19:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfJHRpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 13:45:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:20436 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfJHRpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 13:45:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 10:45:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,272,1566889200"; 
   d="scan'208";a="368487975"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by orsmga005.jf.intel.com with ESMTP; 08 Oct 2019 10:45:37 -0700
Date:   Tue, 8 Oct 2019 10:45:37 -0700
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
Subject: Re: [PATCH v22 10/24] x86/sgx: Add sgx_einit() for wrapping
 ENCLS[EINIT]
Message-ID: <20191008174537.GC14020@linux.intel.com>
References: <20190903142655.21943-1-jarkko.sakkinen@linux.intel.com>
 <20190903142655.21943-11-jarkko.sakkinen@linux.intel.com>
 <20191008173035.GK14765@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008173035.GK14765@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 07:30:35PM +0200, Borislav Petkov wrote:
> I was about to ask why isn't this export _GPL() but it goes away in a
> later patch.

Speaking of later patches, don't bother reviewing patches 19/24 or 20/20,
the vDSO function and selftest respectively.  I'm in the process of
reworking them for v23, reviewing them in their current state is likely a
waste of your time.
