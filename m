Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA1B61AEC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 09:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfGHHJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 03:09:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:2812 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727481AbfGHHJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 03:09:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2019 00:09:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,465,1557212400"; 
   d="scan'208";a="173185440"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Jul 2019 00:09:00 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hkNlj-0007IV-NU; Mon, 08 Jul 2019 15:08:59 +0800
Date:   Mon, 8 Jul 2019 15:08:42 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Tony Xie <tony.xie@rock-chips.com>
Cc:     kbuild-all@01.org, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [linux-next:master 9992/12641] drivers/mfd/rk808.c:754:1: sparse:
 sparse: symbol 'rk8xx_pm_ops' was not declared. Should it be static?
Message-ID: <201907081550.e4JO1ctY%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git master
head:   22c45ec32b4a9fa8c48ef4f5bf9b189b307aae12
commit: 586c1b4125b3c7bf5b482fcafab5d568b8a3c285 [9992/12641] mfd: rk808: Add RK817 and RK809 support
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        git checkout 586c1b4125b3c7bf5b482fcafab5d568b8a3c285
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/mfd/rk808.c:754:1: sparse: sparse: symbol 'rk8xx_pm_ops' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
