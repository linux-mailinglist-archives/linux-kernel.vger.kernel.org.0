Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD747170A4F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 22:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbgBZVUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 16:20:36 -0500
Received: from mga09.intel.com ([134.134.136.24]:56772 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727580AbgBZVUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 16:20:36 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 13:20:35 -0800
X-IronPort-AV: E=Sophos;i="5.70,489,1574150400"; 
   d="scan'208";a="231941960"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 13:20:35 -0800
Date:   Wed, 26 Feb 2020 13:20:34 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Kyung Min Park <kyung.min.park@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, gregkh@linuxfoundation.org, ashok.raj@intel.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com
Subject: Re: [PATCH 2/2] x86/asm/delay: Introduce TPAUSE delay
Message-ID: <20200226212034.GA21102@agluck-desk2.amr.corp.intel.com>
References: <1582744258-42744-1-git-send-email-kyung.min.park@intel.com>
 <1582744258-42744-3-git-send-email-kyung.min.park@intel.com>
 <20200226211040.GS160988@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226211040.GS160988@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 01:10:40PM -0800, Andi Kleen wrote:
> On Wed, Feb 26, 2020 at 11:10:58AM -0800, Kyung Min Park wrote:
> > TPAUSE instructs the processor to enter an implementation-dependent
> > optimized state. The instruction execution wakes up when the time-stamp
> > counter reaches or exceeds the implicit EDX:EAX 64-bit input value.
> > The instruction execution also wakes up due to the expiration of
> > the operating system time-limit or by an external interrupt
> 
> This is actually a behavior change. Today's udelay() will continue
> after processing the interrupt. Your patches don't

The instruction level TPAUSE is called inside delay_wait()
that checks to see of we were interrupted early and loops to issue
another TPAUSE if needed.

-Tony
