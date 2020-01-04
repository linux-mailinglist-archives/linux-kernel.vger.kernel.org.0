Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 970771303BB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jan 2020 18:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgADRNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jan 2020 12:13:15 -0500
Received: from mga06.intel.com ([134.134.136.31]:56865 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbgADRNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 12:13:15 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2020 09:13:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,395,1571727600"; 
   d="scan'208";a="217036006"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jan 2020 09:13:13 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1inmzA-000ARX-Ro; Sun, 05 Jan 2020 01:13:12 +0800
Date:   Sun, 5 Jan 2020 01:13:03 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: drivers/rtc/rtc-pcf8523.c:361:1-3: WARNING: PTR_ERR_OR_ZERO can be
 used
Message-ID: <202001050159.Bmn930KQ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3a562aee727a7bfbb3a37b1aa934118397dad701
commit: 93966243cf90c055d89b5ebfbb8dee0f9ac6b0a2 rtc: pcf8523: Remove struct pcf8523
date:   5 weeks ago

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


coccinelle warnings: (new ones prefixed by >>)

>> drivers/rtc/rtc-pcf8523.c:361:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
