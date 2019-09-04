Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 097BEA89D0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 21:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731567AbfIDP5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 11:57:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6663 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730355AbfIDP5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:57:31 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E5E0CA303BF9F0B72BE0;
        Wed,  4 Sep 2019 23:57:18 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Wed, 4 Sep 2019 23:57:10 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <zhangshaokun@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 0/4] HiSilicon hip08 uncore PMU events additions
Date:   Wed, 4 Sep 2019 23:54:40 +0800
Message-ID: <1567612484-195727-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds some missing uncore PMU events for the hip08 arm64
platform.

The missing events were originally mentioned in
https://lkml.org/lkml/2019/6/14/645, when upstreaming the JSONs initially.

It also includes a fix for a DDRC eventname.

John Garry (4):
  perf jevents: Fix Hisi hip08 DDRC PMU eventname
  perf jevents: Add some missing events for Hisi hip08 DDRC PMU
  perf jevents: Add some missing events for Hisi hip08 L3C PMU
  perf jevents: Add some missing events for Hisi hip08 HHA PMU

 .../arm64/hisilicon/hip08/uncore-ddrc.json    | 16 +++++-
 .../arm64/hisilicon/hip08/uncore-hha.json     | 23 +++++++-
 .../arm64/hisilicon/hip08/uncore-l3c.json     | 56 +++++++++++++++++++
 3 files changed, 93 insertions(+), 2 deletions(-)

-- 
2.17.1

