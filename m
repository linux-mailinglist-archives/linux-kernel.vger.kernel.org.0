Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6EDD105D37
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 00:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfKUXlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 18:41:21 -0500
Received: from mga01.intel.com ([192.55.52.88]:39193 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfKUXlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 18:41:19 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 15:41:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,227,1571727600"; 
   d="scan'208";a="216242622"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga001.fm.intel.com with ESMTP; 21 Nov 2019 15:41:18 -0800
Date:   Thu, 21 Nov 2019 15:53:29 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Christopherson Sean J <sean.j.christopherson@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Message-ID: <20191121235329.GE199273@romley-ivt3.sc.intel.com>
References: <3908561D78D1C84285E8C5FCA982C28F7F4DC167@ORSMSX115.amr.corp.intel.com>
 <B2612A75-BEC8-4FF7-9FDA-A7B55C2E0B4A@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B2612A75-BEC8-4FF7-9FDA-A7B55C2E0B4A@amacapital.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 03:18:46PM -0800, Andy Lutomirski wrote:
> 
> 
> > On Nov 21, 2019, at 2:29 PM, Luck, Tony <tony.luck@intel.com> wrote:
> > 
> > ﻿
> >> 
> >> It would be really, really nice if we could pass this feature through to a VM. Can we?
> > 
> > It's hard because the MSR is core scoped rather than thread scoped.  So on an HT
> > enabled system a pair of logical processors gets enabled/disabled together.
> > 
> > 
> 
> Well that sucks.
> 
> Could we pass it through if the host has no HT?  Debugging is *so* much easier in a VM.  And HT is a bit dubious these days anyway.

I think it's doable to pass it through to KVM. The difficulty is to disable
split lock detection in KVM because that will disable split lock on
the whole core including threads for the host. Without disabling split lock
in KVM, it's doable to debug split lock in KVM.

Sean and Xiaoyao are working on split lock for KVM (in separate patch set).
They may have insight on how to do this.

Thanks.

-Fenghua
