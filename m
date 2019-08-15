Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD44E8EA33
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 13:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730867AbfHOL23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 07:28:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:30184 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbfHOL23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 07:28:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 04:28:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="194750092"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 15 Aug 2019 04:28:27 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] software node: Introduce software_node_find_by_name()
Date:   Thu, 15 Aug 2019 14:28:23 +0300
Message-Id: <20190815112826.81785-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This helper makes it much more easier to access "external" nodes.

thanks,


Heikki Krogerus (3):
  software node: Add software_node_find_by_name()
  usb: roles: intel_xhci: Supplying software node for the role mux
  platform/x86: intel_cht_int33fe: Use new API to gain access to the
    role switch

 drivers/base/swnode.c                         | 35 ++++++++++++
 drivers/platform/x86/intel_cht_int33fe.c      | 57 ++++---------------
 .../usb/roles/intel-xhci-usb-role-switch.c    | 13 ++++-
 include/linux/property.h                      |  4 ++
 4 files changed, 61 insertions(+), 48 deletions(-)

-- 
2.20.1

