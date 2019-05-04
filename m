Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94404139E0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2019 14:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfEDMwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 May 2019 08:52:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37674 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbfEDMwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 08:52:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A5ABFC05681F;
        Sat,  4 May 2019 12:52:13 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 08A435C298;
        Sat,  4 May 2019 12:52:11 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/8] perf: Add attr_groups_update into struct pmu
Date:   Sat,  4 May 2019 14:52:01 +0200
Message-Id: <20190504125207.24662-3-jolsa@kernel.org>
In-Reply-To: <20190504125207.24662-1-jolsa@kernel.org>
References: <20190504125207.24662-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Sat, 04 May 2019 12:52:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding attr_update attribute group into pmu, to allow
having multiple attribute groups for same group name.

This will allow us to update "events" or "format"
directories with attributes that depend on various
HW conditions.

For example having group_format_extra group that updates
"format" directory only if pmu version is 2 and higher:

  static umode_t
  exra_is_visible(struct kobject *kobj, struct attribute *attr, int i)
  {
         return x86_pmu.version >= 2 ? attr->mode : 0;
  }

  static struct attribute_group group_format_extra = {
         .name       = "format",
         .is_visible = exra_is_visible,
  };

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/perf_event.h | 1 +
 kernel/events/core.c       | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index f3864e1c5569..cb5f07d50edb 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -255,6 +255,7 @@ struct pmu {
 	struct module			*module;
 	struct device			*dev;
 	const struct attribute_group	**attr_groups;
+	const struct attribute_group	**attr_update;
 	const char			*name;
 	int				type;
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index abbd4b3b96c2..21ef9b843af0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9874,6 +9874,12 @@ static int pmu_dev_alloc(struct pmu *pmu)
 	if (ret)
 		goto del_dev;
 
+	if (pmu->attr_update)
+		ret = sysfs_update_groups(&pmu->dev->kobj, pmu->attr_update);
+
+	if (ret)
+		goto del_dev;
+
 out:
 	return ret;
 
-- 
2.20.1

