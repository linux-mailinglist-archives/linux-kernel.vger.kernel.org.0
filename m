Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B473F9A192
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 23:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404773AbfHVVBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 17:01:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404733AbfHVVBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:01:37 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.141.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D215423402;
        Thu, 22 Aug 2019 21:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566507697;
        bh=IBqiPN6ChiLoVXwLy2Gjf+RWJWqd2x5IQJwf5/RTDYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DWDrdYDjdRzZoU0q2NtvHkAVyYtDTl4PX1pEDOxh0xf1pZYMv7RV2QBIrNUWkA5gU
         Ei+o+OgQdiNVKLFaI8ICb86VMEddfutrDv3gwBN/pBo82L/pWzswqYeou1wNdNHWE2
         AtF++KcuIDbEFF6RkeX1j8Ln10CfShctRDWvMsHM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 06/25] perf kvm s390: Add missing string.h header
Date:   Thu, 22 Aug 2019 18:00:41 -0300
Message-Id: <20190822210100.3461-7-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822210100.3461-1-acme@kernel.org>
References: <20190822210100.3461-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It uses strstr(), needs to include string.h or its not going to build
when we remove string.h from the place it is getting from indirectly, by
luck.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-72y0i0uiaqght5b83e3ae7p4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/util/kvm-stat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/s390/util/kvm-stat.c b/tools/perf/arch/s390/util/kvm-stat.c
index dac78441338c..0fd4e9f49ed0 100644
--- a/tools/perf/arch/s390/util/kvm-stat.c
+++ b/tools/perf/arch/s390/util/kvm-stat.c
@@ -7,6 +7,7 @@
  */
 
 #include <errno.h>
+#include <string.h>
 #include "../../util/kvm-stat.h"
 #include "../../util/evsel.h"
 #include <asm/sie.h>
-- 
2.21.0

