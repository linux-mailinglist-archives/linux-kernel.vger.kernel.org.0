Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5718C12A6F3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Dec 2019 10:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfLYJOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Dec 2019 04:14:42 -0500
Received: from mga18.intel.com ([134.134.136.126]:26290 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfLYJOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 04:14:41 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Dec 2019 01:14:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,353,1571727600"; 
   d="scan'208";a="212079837"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 25 Dec 2019 01:14:34 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ik2kU-00020J-8e; Wed, 25 Dec 2019 17:14:34 +0800
Date:   Wed, 25 Dec 2019 17:14:15 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     kbuild-all@lists.01.org, dri-devel@lists.freedesktop.org,
        thierry.reding@gmail.com, sam@ravnborg.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH v2 3/3] drm/panel: add panel driver for Leadtek
 LTK500HD1829
Message-ID: <201912251756.Sa7kvTwW%lkp@intel.com>
References: <20191217222812.19872-3-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217222812.19872-3-heiko@sntech.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

I love your patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[cannot apply to drm-exynos/exynos-drm-next drm-intel/for-linux-next tegra-drm/drm/tegra/for-next drm-tip/drm-tip linus/master drm/drm-next v5.5-rc3 next-20191220]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Heiko-Stuebner/dt-bindings-Add-vendor-prefix-for-Leadtek-Technology/20191221-062606
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-129-g341daf20-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c:411:22: sparse: sparse: incorrect type in initializer (different argument counts)
>> drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c:411:22: sparse:    expected int ( *get_modes )( ... )
>> drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c:411:22: sparse:    got int ( * )( ... )
   drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c:463:15: sparse: sparse: undefined identifier 'drm_panel_of_backlight'

vim +411 drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c

   407	
   408	static const struct drm_panel_funcs ltk500hd1829_funcs = {
   409		.unprepare = ltk500hd1829_unprepare,
   410		.prepare = ltk500hd1829_prepare,
 > 411		.get_modes = ltk500hd1829_get_modes,
   412	};
   413	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
