Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10EFB10D345
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2019 10:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfK2JaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Nov 2019 04:30:19 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7178 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726832AbfK2JaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 04:30:18 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1043F257E3523E82807E;
        Fri, 29 Nov 2019 17:30:04 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Fri, 29 Nov 2019 17:29:57 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH next 0/3] debugfs: introduce debugfs_create_single/seq[,_data]
Date:   Fri, 29 Nov 2019 17:27:49 +0800
Message-ID: <20191129092752.169902-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like proc_create_single/seq[,_data] in procfs, we could provide similar debugfs
helper to reduce losts of boilerplate code.

debugfs_create_single[,_data]
  creates a file in debugfs with the extra data and a seq_file show callback.
debugfs_create_seq[,_data]
  creates a file in debugfs with the extra data and a seq_operations.

There is a object dynamically allocated in the helper, which is used to store
extra data, we need free it when remove the debugfs file.

If the change is acceptable, we could change the caller one by one.

Kefeng Wang (3):
  debugfs: Provide debugfs_[set|clear|test]_lowest_bit()
  debugfs: introduce debugfs_create_single[,_data]
  debugfs: introduce debugfs_create_seq[,_data]

 fs/debugfs/file.c       | 127 +++++++++++++++++++++++++++++++++++-----
 fs/debugfs/inode.c      |  11 ++--
 fs/debugfs/internal.h   |   5 +-
 include/linux/debugfs.h |  34 +++++++++++
 4 files changed, 157 insertions(+), 20 deletions(-)

-- 
2.20.1

