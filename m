Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21DBD9009C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 13:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfHPLSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 07:18:55 -0400
Received: from foss.arm.com ([217.140.110.172]:55196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbfHPLSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 07:18:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A59EB28;
        Fri, 16 Aug 2019 04:18:54 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.169.40.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D86093F706;
        Fri, 16 Aug 2019 04:18:52 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Keith Busch <keith.busch@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, Jia He <justin.he@arm.com>
Subject: [PATCH 0/2] Fix and support dax kmem on arm64
Date:   Fri, 16 Aug 2019 19:18:42 +0800
Message-Id: <20190816111844.87442-1-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to fix some dax kmem driver issues and then it can 
support to use pmem as normal RAM in arm64 qemu guest.

Jia He (2):
  drivers/dax/kmem: use default numa_mem_id if target_node is invalid
  drivers/dax/kmem: give a warning if CONFIG_DEV_DAX_PMEM_COMPAT is
    enabled

 drivers/dax/kmem.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
2.17.1

