Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49581D6034
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 12:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbfJNKcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 06:32:04 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:22346 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731127AbfJNKcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 06:32:04 -0400
X-UUID: 69246c0437ad43a995a203276ea7a8a6-20191014
X-UUID: 69246c0437ad43a995a203276ea7a8a6-20191014
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 653775818; Mon, 14 Oct 2019 18:31:59 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 14 Oct 2019 18:31:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 14 Oct 2019 18:31:48 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: [PATCH 0/2] fix the missing underflow in memory operation function
Date:   Mon, 14 Oct 2019 18:31:48 +0800
Message-ID: <20191014103148.17816-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B0FC585DE902AF415BBF2DF73DCE4769D5BBE65605E5E2F26222F2C9D0F93BC92000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchsets help to produce KASAN report when size is negative numbers
in memory operation function. It is helpful for programmer to solve the 
undefined behavior issue. Patch 1 based on Dmitry's review and
suggestion, patch 2 is a test in order to verify the patch 1. 

[1]https://bugzilla.kernel.org/show_bug.cgi?id=199341 
[2]https://lore.kernel.org/linux-arm-kernel/20190927034338.15813-1-walter-zh.wu@mediatek.com/ 

Walter Wu (2): 
kasan: detect negative size in memory operation function 
kasan: add test for invalid size in memmove

---
 lib/test_kasan.c          | 18 ++++++++++++++++++
 mm/kasan/common.c         | 13 ++++++++-----
 mm/kasan/generic.c        |  5 +++++
 mm/kasan/generic_report.c | 18 ++++++++++++++++++
 mm/kasan/tags.c           |  5 +++++
 mm/kasan/tags_report.c    | 17 +++++++++++++++++
 6 files changed, 71 insertions(+), 5 deletions(-)

-- 
2.18.0

