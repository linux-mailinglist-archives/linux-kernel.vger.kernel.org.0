Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA55E61AEF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 09:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbfGHHJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 03:09:08 -0400
Received: from mga14.intel.com ([192.55.52.115]:24913 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727481AbfGHHJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 03:09:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2019 00:09:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,465,1557212400"; 
   d="scan'208";a="248729596"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 08 Jul 2019 00:09:00 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hkNlj-0007Il-Oj; Mon, 08 Jul 2019 15:08:59 +0800
Date:   Mon, 8 Jul 2019 15:08:43 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Tony Xie <tony.xie@rock-chips.com>
Cc:     kbuild-all@01.org, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH linux-next] mfd: rk808: rk8xx_pm_ops can be static
Message-ID: <20190708070843.GA23605@lkp-kbuild12>
References: <201907081550.e4JO1ctY%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201907081550.e4JO1ctY%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 586c1b4125b3 ("mfd: rk808: Add RK817 and RK809 support")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 rk808.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index 6ee1c46..52666a9 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -751,7 +751,7 @@ static int rk8xx_resume(struct device *dev)
 
 	return ret;
 }
-SIMPLE_DEV_PM_OPS(rk8xx_pm_ops, rk8xx_suspend, rk8xx_resume);
+static SIMPLE_DEV_PM_OPS(rk8xx_pm_ops, rk8xx_suspend, rk8xx_resume);
 
 static struct i2c_driver rk808_i2c_driver = {
 	.driver = {
