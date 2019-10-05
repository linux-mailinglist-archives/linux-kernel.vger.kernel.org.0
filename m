Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFE06CCCEE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2019 23:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfJEV6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Oct 2019 17:58:09 -0400
Received: from mga07.intel.com ([134.134.136.100]:12245 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfJEV6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 17:58:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2019 14:58:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,261,1566889200"; 
   d="scan'208";a="192746757"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 05 Oct 2019 14:58:06 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iGs3y-0008fF-36; Sun, 06 Oct 2019 05:58:06 +0800
Date:   Sun, 6 Oct 2019 05:57:27 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Biju Das <biju.das@bp.renesas.com>
Cc:     kbuild-all@01.org, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [usb:usb-next 32/37] drivers/usb/typec/hd3ss3220.c:123:13: sparse:
 sparse: symbol 'hd3ss3220_irq' was not declared. Should it be static?
Message-ID: <201910060507.cCblZmu7%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-next
head:   905eccc6a509d2818e3dd1304c55dc5291b7ea88
commit: 1c48c759ef4bb9031b3347277f04484e07e27d97 [32/37] usb: typec: driver for TI HD3SS3220 USB Type-C DRP port controller
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-42-g38eda53-dirty
        git checkout 1c48c759ef4bb9031b3347277f04484e07e27d97
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/usb/typec/hd3ss3220.c:123:13: sparse: sparse: symbol 'hd3ss3220_irq' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
