Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0301347515
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2019 16:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfFPOEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jun 2019 10:04:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727140AbfFPOEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 10:04:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E2F052F8BF4;
        Sun, 16 Jun 2019 14:04:02 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-53.brq.redhat.com [10.40.204.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9ABF68CF9E;
        Sun, 16 Jun 2019 14:03:59 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCHv3 0/8] perf/x86: Rework msr probe interface
Date:   Sun, 16 Jun 2019 16:03:50 +0200
Message-Id: <20190616140358.27799-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sun, 16 Jun 2019 14:04:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
following up on [1], [2] and [3], this patchset adds update
attribute groups to pmu, factors out the MSR probe code and
use it in msr,cstate* and rapl PMUs.

The functionality stays the same with one exception:
for msr PMU: the event is not exported if the rdmsr return zero
on event's msr, cstate* and rapl pmu functionality stays.

And also: ;-)
> Somewhere along the line you lost the explanation of _why_ we're doing
> this; namely: virt sucks.

Also available in:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/msr

Tested on snb and skylake servers.

v3 changes:
  - rebase on latest perf changes for Icelake models

v2 changes:
  - checking zero rdmsr only for rapl PMU events,
    cstate* and msr pmu functionality stays unchanged

thanks,
jirka


[1] https://lore.kernel.org/lkml/20190301114250.GA23459@krava/
[2] https://lore.kernel.org/lkml/20190318182116.17388-1-jolsa@kernel.org/
[3] https://lore.kernel.org/lkml/20190512155518.21468-1-jolsa@kernel.org/
---
Jiri Olsa (8):
      perf/x86: Add msr probe interface
      perf/x86/msr: Use new probe function
      perf/x86/cstate: Use new probe function
      perf/x86/rapl: Use new msr detection interface
      perf/x86/rapl: Get rapl_cntr_mask from new probe framework
      perf/x86/rapl: Get msr values from new probe framework
      perf/x86/rapl: Get attributes from new probe framework
      perf/x86/rapl: Get quirk state from new probe framework

 arch/x86/events/Makefile       |   2 +-
 arch/x86/events/intel/cstate.c | 152 +++++++++++++++++++++++++++---------------------
 arch/x86/events/intel/rapl.c   | 380 ++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------------------------------------
 arch/x86/events/msr.c          | 110 +++++++++++++++++++----------------
 arch/x86/events/probe.c        |  45 +++++++++++++++
 arch/x86/events/probe.h        |  29 ++++++++++
 6 files changed, 392 insertions(+), 326 deletions(-)
 create mode 100644 arch/x86/events/probe.c
 create mode 100644 arch/x86/events/probe.h
