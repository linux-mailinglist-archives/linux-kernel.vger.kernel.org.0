Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F21882C0A7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 09:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfE1HyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 03:54:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17594 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726203AbfE1HyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 03:54:03 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 18DB99DC278E877CA54E;
        Tue, 28 May 2019 15:54:01 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Tue, 28 May 2019 15:53:51 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jeremy@azazel.net>
CC:     <thesven73@gmail.com>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <matt.sickler@daktronics.com>, Mao Wenan <maowenan@huawei.com>
Subject: [PATCH -next v3 0/2] cleanup for kpc2000_spi.c
Date:   Tue, 28 May 2019 16:02:12 +0800
Message-ID: <20190528080214.18382-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190525081321.121294-1-maowenan@huawei.com>
References: <20190525081321.121294-1-maowenan@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error status should resotre to m->status in kp_spi_transfer_one_message(),
and many white spaces in kpc2000_spi.c. patch 1 is to fix the error path, and
patch 2 is to cleanup kpc2000_spi.c.

v1: remove set but not used variable 'status'.

v2: fix the subject tile.

v3: add another patch to fix the error condition path and do some clean work for kpc2000_spi.c.

Mao Wenan (2):
  staging: kpc2000: report error status to spi core
  staging: kpc2000: replace white spaces with tabs for kpc2000_spi.c

 drivers/staging/kpc2000/kpc2000_spi.c | 718 +++++++++++++-------------
 1 file changed, 361 insertions(+), 357 deletions(-)

-- 
2.20.1

