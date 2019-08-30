Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4FCA2FC4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 08:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfH3GYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 02:24:44 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36918 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfH3GYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:24:44 -0400
Received: by mail-yb1-f193.google.com with SMTP id t5so2090540ybt.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 23:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=CRg35i2KWpjsknTISfFxKQ/QZUyPHEq1p0YfyQly9p0=;
        b=JmcG7+8VBeJwdkL0srCfVuUiYENIyP2RgEaDEDY8NlPmzkibNggOUAP8bHIerZq4nH
         TytJBi2hvzuYvRS6ch+1FHJWP/9ZRoF+dSl1pwpgi01MAwvT+VUoJCFToIJq1k1dQInV
         NPJgo9t/Rrr4MGBBe8a5sfo/jCEVSLdYVySTe8YfkvTBQy/5eyaYRFB+ysOcpdhBcFSC
         vEgfu88Q+EQivdqkzfHQkPQWR+klffAdPQoZM/sIvDVO3m1CIKkqghA35Jz+wf9tJ00K
         VW+kuu2Maubrh4ZKtnq+mOWHW1YbTdlfLc9g7Gng9Vx4Z6Xi9OBTmKCwxsMH8F+9k2j3
         4mNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CRg35i2KWpjsknTISfFxKQ/QZUyPHEq1p0YfyQly9p0=;
        b=d26SLgR1I3BrUBu16B8kW4QGDYCPJ2XNBc2c96ttXK60X3a09uiaJAP6tFoED7NElb
         DnZdk3sgjYrzT4Aw2ixyDf1sxPB/HxfC09qlA3+DS8TKK2WJYahmQQzzybDSbJPHSb0J
         avQy16WQ/Zh2X/22dZlSRHvulLRECbA4X6kfh7StuC99fDk6/isn8qPWHV58eyPMbkR3
         ZYmkcCU66MNx/TZf77zeUHWaHvRg9S/XoY/c/D28GEqmptLtPTHE93LIo3wenlPpmqjV
         2B7bSpoxWV9Kj3EAgLfn7I/r8Bqn6JF0xtsbZR82+5colBRyj5emX5dZfDe/kK6p+AAY
         k76A==
X-Gm-Message-State: APjAAAV9v6FUiiBNXvszZLdvtBLOd5OgKUHauXYCN5drSDwBWFe1OWu2
        lsq5x04iv7NKPNv0CJvecjZV3w==
X-Google-Smtp-Source: APXvYqwlWNQGDdaoHm4ruUISqYzX0oZ1tMA0KTcAcnI6CC8hmRUBISY9eT6FQ8g7u2ShnwUYBrJG3Q==
X-Received: by 2002:a25:7904:: with SMTP id u4mr9798468ybc.73.1567146283332;
        Thu, 29 Aug 2019 23:24:43 -0700 (PDT)
Received: from localhost.localdomain (li1320-244.members.linode.com. [45.79.221.244])
        by smtp.gmail.com with ESMTPSA id r193sm976784ywe.8.2019.08.29.23.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 23:24:42 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <Robert.Walker@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 0/3] perf cs-etm: Add support for callchain
Date:   Fri, 30 Aug 2019 14:24:18 +0800
Message-Id: <20190830062421.31275-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch seris adds support for instruction sample's callchain.

Patch 01 is to refactor the instruction size calculation; patch 02
is to add thread stack and callchain support; patch 03 is a minor fixing
for instruction sample generation thus the instruction sample can be
alignment with the callchain generation.

Before:

  # perf script --itrace=g16l64i100
            main  1579        100      instructions:  ffff0000102137f0 group_sched_in+0xb0 ([kernel.kallsyms])
            main  1579        100      instructions:  ffff000010213b78 flexible_sched_in+0xf0 ([kernel.kallsyms])
            main  1579        100      instructions:  ffff0000102135ac event_sched_in.isra.57+0x74 ([kernel.kallsyms])
            main  1579        100      instructions:  ffff000010219344 perf_swevent_add+0x6c ([kernel.kallsyms])
            main  1579        100      instructions:  ffff000010214854 perf_event_update_userpage+0x4c ([kernel.kallsyms])

  [...]

After:

  # perf script --itrace=g16l64i100

  main  1579        100      instructions: 
          ffff0000102137f0 group_sched_in+0xb0 ([kernel.kallsyms])

  main  1579        100      instructions: 
          ffff000010213b78 flexible_sched_in+0xf0 ([kernel.kallsyms])
          ffff00001020c0b4 visit_groups_merge+0x12c ([kernel.kallsyms])

  main  1579        100      instructions: 
          ffff0000102135ac event_sched_in.isra.57+0x74 ([kernel.kallsyms])
          ffff0000102137a0 group_sched_in+0x60 ([kernel.kallsyms])
          ffff000010213b84 flexible_sched_in+0xfc ([kernel.kallsyms])
          ffff00001020c0b4 visit_groups_merge+0x12c ([kernel.kallsyms])

  main  1579        100      instructions: 
          ffff000010219344 perf_swevent_add+0x6c ([kernel.kallsyms])
          ffff0000102135f4 event_sched_in.isra.57+0xbc ([kernel.kallsyms])
          ffff0000102137a0 group_sched_in+0x60 ([kernel.kallsyms])
          ffff000010213b84 flexible_sched_in+0xfc ([kernel.kallsyms])
          ffff00001020c0b4 visit_groups_merge+0x12c ([kernel.kallsyms])

  main  1579        100      instructions: 
          ffff000010214854 perf_event_update_userpage+0x4c ([kernel.kallsyms])
          ffff000010219360 perf_swevent_add+0x88 ([kernel.kallsyms])
          ffff0000102135f4 event_sched_in.isra.57+0xbc ([kernel.kallsyms])
          ffff0000102137a0 group_sched_in+0x60 ([kernel.kallsyms])
          ffff000010213b84 flexible_sched_in+0xfc ([kernel.kallsyms])
          ffff00001020c0b4 visit_groups_merge+0x12c ([kernel.kallsyms])

  [...]

Leo Yan (3):
  perf cs-etm: Refactor instruction size handling
  perf cs-etm: Add callchain to instruction sample
  perf cs-etm: Correct the packet usage for instruction sample

 tools/perf/util/cs-etm.c | 122 +++++++++++++++++++++++++++++++++------
 1 file changed, 105 insertions(+), 17 deletions(-)

-- 
2.17.1

