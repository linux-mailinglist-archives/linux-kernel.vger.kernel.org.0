Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6B691783C4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 21:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731289AbgCCUO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 15:14:27 -0500
Received: from mga17.intel.com ([192.55.52.151]:60348 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730352AbgCCUO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 15:14:26 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 12:14:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="440727556"
Received: from fkuchars-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.4.236])
  by fmsmga006.fm.intel.com with ESMTP; 03 Mar 2020 12:14:20 -0800
Date:   Tue, 3 Mar 2020 22:14:18 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, nhorman@redhat.com, npmccallum@redhat.com,
        haitao.huang@intel.com, andriy.shevchenko@linux.intel.com,
        tglx@linutronix.de, kai.svahn@intel.com, bp@alien8.de,
        josh@joshtriplett.org, luto@kernel.org, kai.huang@intel.com,
        rientjes@google.com, cedric.xing@intel.com, puiterwijk@redhat.com
Subject: Re: [PATCH v27 04/22] x86/sgx: Add SGX microarchitectural data
 structures
Message-ID: <20200303201418.GH5775@linux.intel.com>
References: <20200223172559.6912-1-jarkko.sakkinen@linux.intel.com>
 <20200223172559.6912-5-jarkko.sakkinen@linux.intel.com>
 <20200303003932.GA27842@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200303003932.GA27842@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 04:39:32PM -0800, Sean Christopherson wrote:
> On Sun, Feb 23, 2020 at 07:25:41PM +0200, Jarkko Sakkinen wrote:
> > Define the SGX microarchitectural data structures used by various SGX
> > opcodes. This is not an exhaustive representation of all SGX data
> > structures but only those needed by the kernel.
> > 
> > The data structures are described in:
> > 
> >   Intel SDM: 37.6 INTEL� SGX DATA STRUCTURES OVERVIEW
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> 
> ...
> 
> > +#define SGX_SSA_GPRS_SIZE		182
> 
> SSA GPRs size is 184.  Per table 37.9 in the SDM:
> 
>   Field    OFFSET (Bytes)    Size (Bytes)
> 
>   GSBASE   176               8
> 
> Reported by a third party, I'm just the messenger and not that good at math :-).

Thanks!

I've fixed this in my tree.

/Jarkko
