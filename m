Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE9694ECF8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 18:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfFUQS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 12:18:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfFUQSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 12:18:55 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 538B1208CA;
        Fri, 21 Jun 2019 16:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561133934;
        bh=FEs3TMM0ZYwBf3dusmpCVE/U5ogVTBo5jlcOMzlVOu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zwk//BBasckgqi8kWaocl4ToLQ1Rx9sa0tk1lEw/lUcb4LPpGM8SHoQbU6j5Akreq
         aOvEHxBDJLQtXxzbLpPUfu2gkOSgmS2Nk5Kq1MEbue7qmKjQ68GrbDzQghL7LFuPJJ
         FH2DHyIIsLvrpR6Puru7osTsAjyAEc1As2R7enqs=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [RFC PATCH 05/11] tracing: Accept different type for synthetic event fields
Date:   Sat, 22 Jun 2019 01:18:50 +0900
Message-Id: <156113392998.28344.16677403249383913005.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156113387975.28344.16009584175308192243.stgit@devnote2>
References: <156113387975.28344.16009584175308192243.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the synthetic event accepts a different type field to record.
However, the size and signed flag must be same.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_events_hist.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index ca6b0dff60c5..a7f447195143 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4063,8 +4063,11 @@ static int check_synth_field(struct synth_event *event,
 
 	field = event->fields[field_pos];
 
-	if (strcmp(field->type, hist_field->type) != 0)
-		return -EINVAL;
+	if (strcmp(field->type, hist_field->type) != 0) {
+		if (field->size != hist_field->size ||
+		    field->is_signed != hist_field->is_signed)
+			return -EINVAL;
+	}
 
 	return 0;
 }

