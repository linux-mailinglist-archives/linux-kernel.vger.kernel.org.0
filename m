Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 868597E341
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 21:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388614AbfHATUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 15:20:32 -0400
Received: from mga05.intel.com ([192.55.52.43]:42463 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfHATUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:20:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 12:20:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,335,1559545200"; 
   d="scan'208";a="324341692"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga004.jf.intel.com with ESMTP; 01 Aug 2019 12:20:31 -0700
Date:   Thu, 1 Aug 2019 12:20:30 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Lin, Jing" <jing.lin@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] x86/asm: Add support for MOVDIR64B instruction
Message-ID: <20190801192030.GA11781@agluck-desk2.amr.corp.intel.com>
References: <20190730230554.8291-1-kirill.shutemov@linux.intel.com>
 <20190801095928.GA32138@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801095928.GA32138@nazgul.tnic>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 12:03:41PM +0200, Borislav Petkov wrote:
> On Wed, Jul 31, 2019 at 02:05:54AM +0300, Kirill A. Shutemov wrote:
> > Several upcoming patchsets will make use of the helper.
> 
> ... so why aren't you sending it together with its first user?

Just to get another of the non-controversial bits out of the
way before the main course arrives.

Note that the CPUFEATURE bit for MOVDIR64B already went upstream
in v4.20:

 ace6485a0326 ("x86/cpufeatures: Enumerate MOVDIR64B instruction")

-Tony
