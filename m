Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7D9524973
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 09:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfEUH4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 03:56:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbfEUH4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:56:22 -0400
Received: from localhost.localdomain (unknown [153.145.222.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 770812173C;
        Tue, 21 May 2019 07:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558425381;
        bh=qxHfr4Hi+PajQcYj2TJLTrbR4UOul7CUgMlD8k0p1Uk=;
        h=From:To:Cc:Subject:Date:From;
        b=M5xfmM1GavKb9nurGX+Yp2PsQhpBXjDrWGrKk+3lupqFtW28sr8bOzycJ2pkJaz8g
         TuYZUfu+UDUYtrdtLJOFLfloJ2VN3SybEBNnhY1xCdeFJeRmxtrcU32Xig0wxPKztv
         In+FBSYhDhkxB0BmPXwZYnmQNHZGb4ttCxLGsX9M=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 0/2] Enable new kprobe event at boot
Date:   Tue, 21 May 2019 16:56:16 +0900
Message-Id: <155842537599.4253.14690293652007233645.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a kernel parameter, 'kprobe_event=' to add and enable
new kprobe events at boot time.

Currently ftrace can enable some existing trace events at boot time.
This also allows admin/developer to add new kprobe-events at boot
time to debug device drivers etc.

The syntax is similar to tracing/kprobe_events interface, but
uses ',' and ';' instead of ' ' and '\n' respectively. e.g.

  kprobe_event=p,func1,$arg1,$arg2;p,func2,$arg1

will add probes on func1 with the 1st and the 2nd arguments and on
func2 with the 1st argument.

Note that 'trace_event=' option enables trace event at very early
timing, but the events added by 'kprobe_event=' are enabled right
before enabling device drivers at this point. It is enough for
tracing device driver initialization etc.

Thank you,

---

Masami Hiramatsu (2):
      kprobes: Initialize kprobes at subsys_initcall
      tracing/kprobe: Add kprobe_event= boot parameter


 Documentation/admin-guide/kernel-parameters.txt |   13 ++++++
 Documentation/trace/kprobetrace.rst             |   14 ++++++
 kernel/kprobes.c                                |    2 -
 kernel/trace/trace_kprobe.c                     |   54 +++++++++++++++++++++++
 4 files changed, 82 insertions(+), 1 deletion(-)

--
Masami Hiramatsu (Linaro)
