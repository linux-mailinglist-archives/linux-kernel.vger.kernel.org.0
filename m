Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5202B85730
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 02:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389086AbfHHASq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 20:18:46 -0400
Received: from mga04.intel.com ([192.55.52.120]:36221 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729960AbfHHASm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 20:18:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 17:18:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,358,1559545200"; 
   d="scan'208";a="349995878"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 07 Aug 2019 17:18:22 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hvW8L-000GeR-Nk; Thu, 08 Aug 2019 08:18:21 +0800
Date:   Thu, 8 Aug 2019 08:17:43 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     kbuild-all@01.org, Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Pingfan Liu <kernelfans@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Qian Cai <cai@lca.pw>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Drake <drake@endlessm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org
Subject: Re: [PATCH 2/4] x86/apic: record capped cpu in
 generic_processor_info()
Message-ID: <201908080844.z7kDOy5O%lkp@intel.com>
References: <1564995539-29609-3-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564995539-29609-3-git-send-email-kernelfans@gmail.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pingfan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[cannot apply to v5.3-rc3 next-20190807]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Pingfan-Liu/x86-mce-protect-nr_cpus-from-rebooting-by-broadcast-mce/20190806-101748
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> arch/x86/kernel/cpu/common.c:70:16: sparse: sparse: symbol '__cpu_capped_mask' was not declared. Should it be static?
   arch/x86/kernel/cpu/common.c:135:43: sparse: sparse: cast truncates bits from constant value (fffff becomes ffff)
   arch/x86/kernel/cpu/common.c:136:43: sparse: sparse: cast truncates bits from constant value (fffff becomes ffff)
   arch/x86/kernel/cpu/common.c:137:43: sparse: sparse: cast truncates bits from constant value (fffff becomes ffff)
   arch/x86/kernel/cpu/common.c:138:43: sparse: sparse: cast truncates bits from constant value (fffff becomes ffff)
   arch/x86/kernel/cpu/common.c:165:43: sparse: sparse: cast truncates bits from constant value (fffff becomes ffff)
   arch/x86/kernel/cpu/common.c:166:43: sparse: sparse: cast truncates bits from constant value (fffff becomes ffff)

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
