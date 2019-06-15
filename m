Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0B446FB1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2019 12:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfFOK4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jun 2019 06:56:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:47852 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbfFOK4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 06:56:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2019 03:56:07 -0700
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 15 Jun 2019 03:56:06 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hc6Lt-0003ts-Dn; Sat, 15 Jun 2019 18:56:05 +0800
Date:   Sat, 15 Jun 2019 18:55:12 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Tim Wawrzynczak <twawrzynczak@chromium.org>
Cc:     kbuild-all@01.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH chrome-platform-linux] platform/chrome: cros_ec_debugfs:
 cros_ec_uptime_fops can be static
Message-ID: <20190615105512.GA152427@lkp-kbuild11>
References: <201906151827.DYouSmoA%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201906151827.DYouSmoA%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 909447f683b3 ("platform/chrome: cros_ec_debugfs: Add debugfs entry to retrieve EC uptime")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 cros_ec_debugfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 970ba13d..d40902e 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -285,7 +285,7 @@ static const struct file_operations cros_ec_pdinfo_fops = {
 	.llseek = default_llseek,
 };
 
-const struct file_operations cros_ec_uptime_fops = {
+static const struct file_operations cros_ec_uptime_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
 	.read = cros_ec_uptime_read,
