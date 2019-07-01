Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3E51F3F5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 14:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbfEOMQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 08:16:58 -0400
Received: from mga04.intel.com ([192.55.52.120]:44143 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728231AbfEOMQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 08:16:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2019 05:16:55 -0700
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 15 May 2019 05:16:54 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hQsq6-000Cit-3Y; Wed, 15 May 2019 20:16:54 +0800
Date:   Wed, 15 May 2019 20:16:13 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Matt Sickler <Matt.Sickler@daktronics.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: drivers/staging/kpc2000/kpc_dma/fileops.c:60:8-26: WARNING: casting
 value returned by memory allocation function to (struct aio_cb_data *) is
 useless.
Message-ID: <201905152009.JVEMePDb%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5ac94332248ee017964ba368cdda4ce647e3aba7
commit: 7df95299b94a63ec67a6389fc02dc25019a80ee8 staging: kpc2000: Add DMA driver
date:   3 weeks ago

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


coccinelle warnings: (new ones prefixed by >>)

>> drivers/staging/kpc2000/kpc_dma/fileops.c:60:8-26: WARNING: casting value returned by memory allocation function to (struct aio_cb_data *) is useless.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
