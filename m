Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91AD7D0A6A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 10:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbfJII5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 04:57:46 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36830 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725903AbfJII5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 04:57:45 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7DF0EA200A797F312905;
        Wed,  9 Oct 2019 16:57:43 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 9 Oct 2019 16:57:34 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <mark.rutland@arm.com>, <will@kernel.org>
CC:     <f.fainelli@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <zhangshaokun@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH] MAINTAINERS: Add entry for perf tool arm64 pmu-events files
Date:   Wed, 9 Oct 2019 16:54:33 +0800
Message-ID: <1570611273-108281-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will and I have an interest in reviewing the pmu-events changes related to
arm64, so add a specific entry for this.

Cc: Will Deacon <will@kernel.org>
Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 296de2b51c83..6583b02790fe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12767,6 +12767,13 @@ F:	arch/*/events/*
 F:	arch/*/events/*/*
 F:	tools/perf/
 
+PERFORMANCE EVENTS SUBSYSTEM ARM64 PMU EVENTS
+R:	John Garry <john.garry@huawei.com>
+R:	Will Deacon <will@kernel.org>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	tools/perf/pmu-events/arch/arm64/
+
 PERSONALITY HANDLING
 M:	Christoph Hellwig <hch@infradead.org>
 L:	linux-abi-devel@lists.sourceforge.net
-- 
2.17.1

