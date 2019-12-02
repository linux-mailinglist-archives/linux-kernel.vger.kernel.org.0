Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0B410E9A2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 12:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfLBLli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 06:41:38 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:39535 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfLBLlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 06:41:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575286898; x=1606822898;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1CNpxHsr04DmQEhNbChHZtBy2La84Ew3uSgqIRYBJfE=;
  b=CgEP29dw0eaAIIJ/Pw8wUHMX1S52Sur96GBmLauf2o5MHZCkuaE4KPtQ
   Va7v+3UlIifQPKh//S5kqLAn0ZX2ER2/PyGkkmqCUlMibgLhti1cYex9v
   3Dxj7cJf3kT1h3LDWnQDwxSeTNiBhsRfHxwVV5kuBeRUv0tGadQcKrMzv
   4=;
IronPort-SDR: uYWZRtp/AZXVtP7mb9gFHup7uOaxFm9cE+qY0YoiDnmMSBXM+Vzrru3HCnDP5PGCOXhAgaRv9S
 dTndu2QfCZrQ==
X-IronPort-AV: E=Sophos;i="5.69,268,1571702400"; 
   d="scan'208";a="6617694"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 02 Dec 2019 11:41:36 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com (Postfix) with ESMTPS id 58C3BA18B7;
        Mon,  2 Dec 2019 11:41:34 +0000 (UTC)
Received: from EX13D32EUB004.ant.amazon.com (10.43.166.212) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 2 Dec 2019 11:41:33 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D32EUB004.ant.amazon.com (10.43.166.212) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 2 Dec 2019 11:41:33 +0000
Received: from u2f063a87eabd5f.cbg10.amazon.com (10.125.106.135) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Mon, 2 Dec 2019 11:41:30 +0000
From:   Paul Durrant <pdurrant@amazon.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>
CC:     Paul Durrant <pdurrant@amazon.com>
Subject: [PATCH v3 0/2] allow xen-blkback to be cleanly unloaded
Date:   Mon, 2 Dec 2019 11:41:15 +0000
Message-ID: <20191202114117.1264-1-pdurrant@amazon.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Durrant (2):
  xen/xenbus: reference count registered modules
  xen-blkback: allow module to be cleanly unloaded

 drivers/block/xen-blkback/blkback.c |  8 ++++++++
 drivers/block/xen-blkback/common.h  |  3 +++
 drivers/block/xen-blkback/xenbus.c  | 11 +++++++++++
 drivers/xen/xenbus/xenbus_probe.c   | 13 ++++++++++++-
 4 files changed, 34 insertions(+), 1 deletion(-)

-- 
2.20.1

