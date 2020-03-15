Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9816B1857E9
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 02:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbgCOBtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Mar 2020 21:49:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:26789 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbgCOBtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 21:49:21 -0400
IronPort-SDR: YaUreDnd0I1VR/dU7zKQ12apw1SgOSuE96kD1DFzTZip26genzsHH/0XhXWGFCw1Z83xuokpSC
 CgKyA8z4XypA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2020 17:27:45 -0700
IronPort-SDR: 8yK2ll5Tu4V2XpSyStMwsKuKMJf0wdmFBl8nTiWCOzNbqbUn8nz0p9qbL1AUV4PRL72Z+dYBQx
 6skQKLPj9qVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,554,1574150400"; 
   d="scan'208";a="442852835"
Received: from mbenhamu-mobl2.ger.corp.intel.com (HELO localhost) ([10.251.177.145])
  by fmsmga005.fm.intel.com with ESMTP; 14 Mar 2020 17:27:33 -0700
Date:   Sun, 15 Mar 2020 02:27:32 +0200
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
Message-ID: <20200315002732.GA208715@linux.intel.com>
References: <20200303233609.713348-1-jarkko.sakkinen@linux.intel.com>
 <20200303233609.713348-17-jarkko.sakkinen@linux.intel.com>
 <20200305190354.GK11500@linux.intel.com>
 <20200306184702.GD7472@linux.intel.com>
 <20200312183824.GB26453@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312183824.GB26453@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 11:38:24AM -0700, Sean Christopherson wrote:
> On Fri, Mar 06, 2020 at 08:47:02PM +0200, Jarkko Sakkinen wrote:
> > On Thu, Mar 05, 2020 at 11:03:54AM -0800, Sean Christopherson wrote:
> > > We've also discussed taking a file descriptor to hold the backing, but
> > > unless I'm misreading the pagecache code, that doesn't solve the incorrect
> > > accounting problem because the current task, i.e. evicting task, would be
> > > charged.  In other words, whether the backing is kernel or user controlled
> > > is purely an ABI question.
> > 
> > Even if the file is owned by a different process the account happens
> > to "current"?
> 
> Yes.  Which makes sense as files do not have a 1:1 association with tasks.

Yeah, that makes sense. Looking at mm/memory.c.

Looking at finish_fault/alloc_set_pte/inc_mm_counter_fast code path that
is also what happens.

/Jarkko
