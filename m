Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 009B1179DAE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 03:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgCECJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 21:09:53 -0500
Received: from mga17.intel.com ([192.55.52.151]:8525 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbgCECJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 21:09:53 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 18:09:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,516,1574150400"; 
   d="scan'208";a="439338523"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 04 Mar 2020 18:09:51 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j9fxP-0001hZ-8x; Thu, 05 Mar 2020 10:09:51 +0800
Date:   Thu, 5 Mar 2020 10:09:14 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     kbuild-all@lists.01.org, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [driver-core:driver-core-testing 6/17] drivers/base/core.c:2335:5:
 sparse: sparse: symbol 'fw_devlink_flags' was not declared. Should it be
 static?
Message-ID: <202003051006.WjOsPfws%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git driver-core-testing
head:   68464d79015a1bbb41872a9119a07b2cb151a4b9
commit: 8375e74f2bca9802a4ddf431a6d7bd2ab9950f27 [6/17] driver core: Add fw_devlink kernel commandline option
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-174-g094d5a94-dirty
        git checkout 8375e74f2bca9802a4ddf431a6d7bd2ab9950f27
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/base/core.c:2335:5: sparse: sparse: symbol 'fw_devlink_flags' was not declared. Should it be static?
   drivers/base/core.c:67:5: sparse: sparse: context imbalance in 'device_links_read_lock' - wrong count at exit
   include/linux/srcu.h:181:9: sparse: sparse: context imbalance in 'device_links_read_unlock' - unexpected unlock

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
