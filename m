Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7D617A939
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 16:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgCEPvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 10:51:17 -0500
Received: from mga11.intel.com ([192.55.52.93]:35179 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbgCEPvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:51:16 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 07:51:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="scan'208";a="240853890"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga003.jf.intel.com with ESMTP; 05 Mar 2020 07:51:15 -0800
Date:   Thu, 5 Mar 2020 07:51:15 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        DavidWang@zhaoxin.com, CooperYan@zhaoxin.com,
        QiyuanWang@zhaoxin.com, HerryYang@zhaoxin.com
Subject: Re: [PATCH v1 0/2] x86/Kconfig: modify X86_UMIP depends on CPUs
Message-ID: <20200305155115.GC11500@linux.intel.com>
References: <1583390951-4103-1-git-send-email-TonyWWang-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583390951-4103-1-git-send-email-TonyWWang-oc@zhaoxin.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 02:49:09PM +0800, Tony W Wang-oc wrote:
> CONFIG_X86_UMIP is generic since commit b971880fe79f (x86/Kconfig:
> Rename UMIP config parameter).
> 
> Some Centaur family 7 CPUs and Zhaoxin family 7 CPUs support the UMIP
> feature. So, modify X86_UMIP to cover these CPUs too.

That leaves UMC_32, TRANSMETA_32 and CYRIX_32 as the last CPU_SUP types
that don't support UMIP.  Maybe it's time to remove the CPU_SUP checks
altogether, same as X86_SMAP?

> Tony W Wang-oc (2):
>   x86/Kconfig: Make X86_UMIP to cover Centaur CPUs
>   x86/Kconfig: Make X86_UMIP to cover Zhaoxin CPUs
> 
>  arch/x86/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> -- 
> 2.7.4
> 
