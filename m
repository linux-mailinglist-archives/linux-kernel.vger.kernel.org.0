Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCBE410150
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 22:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfD3U5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 16:57:20 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42327 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfD3U4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 16:56:19 -0400
Received: by mail-io1-f66.google.com with SMTP id m188so13427876ioa.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 13:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=HbIvXXxkoOYvDJka1De1DE8EvRWM+I3icfIF/qPG/Mo=;
        b=npmUHW0Er03hsah4vxKt/Rsc1QsknX9ri0ksYinJ9g/tzmhoquukur+SX/2oshvVa8
         /mFc072TVT2d5dSTRyp61oXVEBginSqtFPaNNOFd0YMNYZRQl5y1vXaN+RP+OPOz5fPx
         5MtIdUvP5dP21zOrtu/wUzCPjDuL2XVZlakDVKFiNIGo9WXY5T+SP3+ucjpjJDeTh0R0
         h4MuAQcXBNMLv1MU742iruUUWfmDQqm9agy3yYLk7xxNrOPmlXYhmi2KzHcMrTe7Jbia
         X1UuNJkG2MxNMgwX/O6M+hYcnt6rthuFaLDHRQeUKQhnypA8s8KzavNea1oJ7I/L7uuA
         6ZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=HbIvXXxkoOYvDJka1De1DE8EvRWM+I3icfIF/qPG/Mo=;
        b=DZU9+ks/hZ+nZ9EOcs1xCyoaPYxV5l0CZtRVa0J0ctvH0gpkNEfhJhqrjdyyKndUUh
         zWNdW2egNms/XKyANHVM4akOa57Ns6rKqyOv49BlwD+r+R3s/b2rY8AroJ88hW64+WdX
         fnFaSRD6WmxrhNrG/j1BwU5ReIcz4fS+maBU+LX/BySxCS27IFzieDPZY1awsSWouIEF
         5NLFNdFdOJfwtgjbDrbOLjrTGE5C5kwyU44GYt2goooaVJ2DHB7wGv0Y2A/w4Oh7Uo+m
         itMnGwW7XyTB6rxvUFfpTliZ0Kt44+mSlzeeI7cxNTbS8SfGQkQOK7WEr4kRWXXmW2Yc
         pl7Q==
X-Gm-Message-State: APjAAAVDyz7fQ7wq9e24/AA77YuHq3SyhTAiGyVO3dj6nGrWEeLK69Fy
        PTTSiMbL2aRcj32Qu/mQ1w5HUdim
X-Google-Smtp-Source: APXvYqy6lynZTAveazXX1fd2mBJPceLVJOsg+RbD9KIIi6zHxoFluYnVZkR9PEv7gqwtHxB18lWT/Q==
X-Received: by 2002:a5e:a712:: with SMTP id b18mr18548078iod.119.1556657778742;
        Tue, 30 Apr 2019 13:56:18 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id s7sm9799349ioo.17.2019.04.30.13.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 13:56:18 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: [PATCH 03/14] x86 smpboot: Rename match_die() to match_pkg()
Date:   Tue, 30 Apr 2019 16:55:48 -0400
Message-Id: <5704b04c9992ac75ee4f004c21648ae7e9df09c2.1553624867.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <75386dff62ee869eb7357dff1e60dfd9b3e68023.1553624867.git.len.brown@intel.com>
References: <75386dff62ee869eb7357dff1e60dfd9b3e68023.1553624867.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Syntax only, no functional or semantic change.

This routine matches packages, not die, so name it thus.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/smpboot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ccd1f2a8e557..19a963890bbe 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -459,7 +459,7 @@ static bool match_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
  * multicore group inside a NUMA node.  If this happens, we will
  * discard the MC level of the topology later.
  */
-static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
+static bool match_pkg(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 {
 	if (c->phys_proc_id == o->phys_proc_id)
 		return true;
@@ -550,7 +550,7 @@ void set_cpu_sibling_map(int cpu)
 	for_each_cpu(i, cpu_sibling_setup_mask) {
 		o = &cpu_data(i);
 
-		if ((i == cpu) || (has_mp && match_die(c, o))) {
+		if ((i == cpu) || (has_mp && match_pkg(c, o))) {
 			link_mask(topology_core_cpumask, cpu, i);
 
 			/*
@@ -574,7 +574,7 @@ void set_cpu_sibling_map(int cpu)
 			} else if (i != cpu && !c->booted_cores)
 				c->booted_cores = cpu_data(i).booted_cores;
 		}
-		if (match_die(c, o) && !topology_same_node(c, o))
+		if (match_pkg(c, o) && !topology_same_node(c, o))
 			x86_has_numa_in_package = true;
 	}
 
-- 
2.18.0-rc0

