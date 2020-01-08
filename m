Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67831134245
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 13:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgAHMxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 07:53:22 -0500
Received: from mga11.intel.com ([192.55.52.93]:49509 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728261AbgAHMxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 07:53:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 04:53:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="211526404"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2020 04:53:18 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 12A731AD; Wed,  8 Jan 2020 14:53:17 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 0/2] thunderbolt: Fix and MAINTAINERS update
Date:   Wed,  8 Jan 2020 15:53:15 +0300
Message-Id: <20200108125317.36444-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The first patch fixes an issue reported by Dan Carpenter and the second
updates MAINTAINERS to use linux-usb as mailing list for Thunderbolt and
USB4 related patches.

Greg, can you pick these to your usb-next branch if there are no
objections?

Mika Westerberg (2):
  thunderbolt: Fix xhci check in usb4_switch_setup()
  MAINTAINERS: Use linux-usb mailing list for Thunderbolt and USB4 patches

 MAINTAINERS                | 1 +
 drivers/thunderbolt/usb4.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.24.1

