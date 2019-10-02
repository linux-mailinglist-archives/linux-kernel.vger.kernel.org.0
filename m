Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6DBC88A9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 14:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfJBMdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 08:33:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:27022 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbfJBMdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 08:33:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2019 05:33:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,574,1559545200"; 
   d="scan'208";a="205330025"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Oct 2019 05:33:05 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] software node: API documentation
Date:   Wed,  2 Oct 2019 15:33:03 +0300
Message-Id: <20191002123305.80012-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm sending this as an RFC first. I would like to wait for the API
change Dmitry proposed [1] before we add the final API documentation
for the software nodes.

At this point I would like to know if the generic use is explained
clearly enough and if there is anything missing that should be added.

[1] https://lkml.org/lkml/2019/9/11/8

thanks,

Heikki Krogerus (2):
  software node: Add missing kernel-doc function descriptions
  software node: Add documentation

 Documentation/driver-api/software_node.rst | 197 +++++++++++++++++++++
 drivers/base/swnode.c                      |  23 +++
 2 files changed, 220 insertions(+)
 create mode 100644 Documentation/driver-api/software_node.rst

-- 
2.23.0

