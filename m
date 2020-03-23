Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9EB0190287
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 01:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgCXALU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 20:11:20 -0400
Received: from mga09.intel.com ([134.134.136.24]:56291 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727299AbgCXALU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 20:11:20 -0400
IronPort-SDR: 8A/iedMK6PWeaCH/TC5ECRKdYZm3TNAgPNJBZYMeKuvtgZNNbTWWgYZeC9a28qlzydaW5E0jfl
 YK04sMXwWUAQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 17:11:19 -0700
IronPort-SDR: +yzgMZ4pMuQpT1NE7He3vuTOG2pgPJ7SLhUCST9bTczk+5BUCwe+yqr8TSGaKO3j4lsCilPm5N
 j5h/viUtpnPw==
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; 
   d="scan'208";a="325739407"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 17:11:19 -0700
Subject: [PATCH 07/12] drivers/base: Make device_find_child_by_name()
 compatible with sysfs inputs
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-mm@kvack.org
Cc:     vishal.l.verma@intel.com, dave.hansen@linux.intel.com, hch@lst.de,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        jmoyer@redhat.com
Date:   Mon, 23 Mar 2020 16:55:13 -0700
Message-ID: <158500771333.2088294.9851442753403203762.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sysfs_streq() in device_find_child_by_name() to allow it to use a
sysfs input string that might contain a trailing newline.

The other "device by name" interfaces,
{bus,driver,class}_find_device_by_name(), already account for sysfs
strings.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/base/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 139cdf7e7327..4abfd4df42ec 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2931,7 +2931,7 @@ struct device *device_find_child_by_name(struct device *parent,
 
 	klist_iter_init(&parent->p->klist_children, &i);
 	while ((child = next_device(&i)))
-		if (!strcmp(dev_name(child), name) && get_device(child))
+		if (sysfs_streq(dev_name(child), name) && get_device(child))
 			break;
 	klist_iter_exit(&i);
 	return child;

