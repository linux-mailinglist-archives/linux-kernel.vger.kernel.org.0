Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAF6017C5A8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 19:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgCFSrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 13:47:17 -0500
Received: from mga02.intel.com ([134.134.136.20]:24392 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgCFSrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 13:47:17 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 10:47:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,523,1574150400"; 
   d="scan'208";a="440203147"
Received: from wbakowsk-mobl.ger.corp.intel.com (HELO localhost) ([10.252.27.142])
  by fmsmga005.fm.intel.com with ESMTP; 06 Mar 2020 10:47:03 -0800
Date:   Fri, 6 Mar 2020 20:47:02 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, nhorman@redhat.com, npmccallum@redhat.com,
        haitao.huang@intel.com, andriy.shevchenko@linux.intel.com,
        tglx@linutronix.de, kai.svahn@intel.com, bp@alien8.de,
        josh@joshtriplett.org, luto@kernel.org, kai.huang@intel.com,
        rientjes@google.com, cedric.xing@intel.com, puiterwijk@redhat.com,
        linux-mm@kvack.org, Ismo Puustinen <ismo.puustinen@intel.com>,
        Mark Shanahan <mark.shanahan@intel.com>,
        Mikko Ylinen <mikko.ylinen@intel.com>,
        Derek Bombien <derek.bombien@intel.com>
Subject: Re: [PATCH v28 16/22] x86/sgx: Add a page reclaimer
Message-ID: <20200306184702.GD7472@linux.intel.com>
References: <20200303233609.713348-1-jarkko.sakkinen@linux.intel.com>
 <20200303233609.713348-17-jarkko.sakkinen@linux.intel.com>
 <20200305190354.GK11500@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305190354.GK11500@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 11:03:54AM -0800, Sean Christopherson wrote:
> We've also discussed taking a file descriptor to hold the backing, but
> unless I'm misreading the pagecache code, that doesn't solve the incorrect
> accounting problem because the current task, i.e. evicting task, would be
> charged.  In other words, whether the backing is kernel or user controlled
> is purely an ABI question.

Even if the file is owned by a different process the account happens
to "current"?

/Jarkko
