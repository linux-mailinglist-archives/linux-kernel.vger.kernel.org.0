Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44D411774F1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 12:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgCCLDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 06:03:12 -0500
Received: from outbound-smtp36.blacknight.com ([46.22.139.219]:37733 "EHLO
        outbound-smtp36.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728018AbgCCLDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 06:03:12 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp36.blacknight.com (Postfix) with ESMTPS id 3C78A1546
        for <linux-kernel@vger.kernel.org>; Tue,  3 Mar 2020 11:03:10 +0000 (GMT)
Received: (qmail 13293 invoked from network); 3 Mar 2020 11:03:09 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPA; 3 Mar 2020 11:03:09 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Paul McKenney <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 0/3] Accumulated fixes for Load/NUMA Balancing reconcilation series
Date:   Tue,  3 Mar 2020 11:02:55 +0000
Message-Id: <20200303110258.1092-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following are three fixes already posted and reviewed that are needed
in tip/sched/core to address a load balancing issue, a build warning and
an RCU warning. They've already been posted but could easily have be lost
in the noise.

 kernel/sched/fair.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

-- 
2.16.4

