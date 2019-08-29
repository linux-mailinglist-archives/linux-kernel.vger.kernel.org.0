Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E53DA267C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 20:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbfH2Swa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 14:52:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:33507 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbfH2Swa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:52:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 11:52:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,444,1559545200"; 
   d="scan'208";a="186064544"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Aug 2019 11:52:25 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1i3PWy-000Ecn-PH; Fri, 30 Aug 2019 02:52:24 +0800
Date:   Fri, 30 Aug 2019 02:51:36 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     kbuild-all@01.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, tony.luck@intel.com, x86@kernel.org,
        andriy.shevchenko@intel.com, alan@linux.intel.com,
        linux-kernel@vger.kernel.org, qi-ming.wu@intel.com,
        chuanhua.lei@linux.intel.com, cheol.yong.kim@intel.com,
        rahul.tanwar@intel.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [RFC PATCH] x86/init: x86_wallclock_init() can be static
Message-ID: <20190829185136.pat4kgnolbsxjm3u@48261080c7f1>
References: <199d34bc514d4fbf2058a862918dc6a71390c48f.1566895445.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <199d34bc514d4fbf2058a862918dc6a71390c48f.1566895445.git.rahul.tanwar@linux.intel.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 1461badd03e7 ("x86/init: Noop get/set wallclock when platform doesn't support RTC")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 x86_init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 88c120710d5d5..50aa8257fd20a 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -39,7 +39,7 @@ static const struct of_device_id of_cmos_match[] = {
 	{}
 };
 
-void x86_wallclock_init(void)
+static void x86_wallclock_init(void)
 {
 	struct device_node *node;
 
