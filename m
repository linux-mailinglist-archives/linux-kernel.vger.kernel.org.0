Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31A72A0A56
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 21:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfH1TSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 15:18:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbfH1TSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 15:18:21 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B91D0214DA;
        Wed, 28 Aug 2019 19:18:20 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1i33SV-0007dm-TI; Wed, 28 Aug 2019 15:18:19 -0400
Message-Id: <20190828190527.680021737@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 28 Aug 2019 15:05:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/2] tools lib traceevent: Fixes for adding tasks to the tep descriptor
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Arnaldo,

Please pull in these patches as they fix the lib tools traceevent code
that has issues with adding in new tasks on large data files.

-- Steve



Steven Rostedt (VMware) (2):
      tools lib traceevent: Do not free tep->cmdlines in add_new_comm() on failure
      tools lib traceevent: Remove unneeded qsort and uses memmove instead

----
 tools/lib/traceevent/event-parse.c | 58 ++++++++++++++++++++++++++++++++------
 1 file changed, 50 insertions(+), 8 deletions(-)
