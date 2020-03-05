Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABCDC179DAD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 03:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgCECJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 21:09:50 -0500
Received: from mga17.intel.com ([192.55.52.151]:8525 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbgCECJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 21:09:49 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 18:09:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,516,1574150400"; 
   d="scan'208";a="274906452"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 04 Mar 2020 18:09:48 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j9fxL-0001Lk-CM; Thu, 05 Mar 2020 10:09:47 +0800
Date:   Thu, 5 Mar 2020 10:09:24 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     kbuild-all@lists.01.org, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH driver-core] driver core: fw_devlink_flags can be static
Message-ID: <20200305020916.GA14234@3143ef58ba07>
References: <202003051006.WjOsPfws%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003051006.WjOsPfws%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 8375e74f2bca ("driver core: Add fw_devlink kernel commandline option")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 26acb92aa966c..cd78a001d7198 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2332,7 +2332,7 @@ static int device_private_init(struct device *dev)
 	return 0;
 }
 
-u32 fw_devlink_flags;
+static u32 fw_devlink_flags;
 static int __init fw_devlink_setup(char *arg)
 {
 	if (!arg)
