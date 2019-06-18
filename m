Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0024A0AF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 14:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbfFRMXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 08:23:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18638 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727584AbfFRMXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 08:23:13 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A409857610055979792B;
        Tue, 18 Jun 2019 20:23:08 +0800 (CST)
Received: from RH5885H-V3.huawei.com (10.90.53.225) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Tue, 18 Jun 2019 20:23:00 +0800
From:   SunKe <sunke32@huawei.com>
To:     <jlbec@evilplan.org>, <hch@lst.de>, <linux-kernel@vger.kernel.org>,
        <sunke32@huawei.com>
Subject: [PATCH 0/2] two test samples for configfs
Date:   Tue, 18 Jun 2019 20:28:27 +0800
Message-ID: <1560860909-51059-1-git-send-email-sunke32@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two test samples for configfs. include read and write bin_file and
creat soft link.

*** BLURB HERE ***

SunKe (2):
  sample_configfs: bin_file read and write
  sample_configfs: soft link creat and delete

 samples/configfs/configfs_sample.c | 84 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

-- 
2.7.4

