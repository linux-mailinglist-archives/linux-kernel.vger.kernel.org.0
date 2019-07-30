Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06B8C7B0D0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 19:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbfG3RsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 13:48:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52137 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfG3RsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:48:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UHlxsS3319611
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 10:47:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UHlxsS3319611
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564508880;
        bh=+6yKiUXMu1K/encb/gPDYxwM4XxUEg6uIDAmZdriiF8=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=Q9vf/DFRIgUvvT1blWgp/cHl/OznBymm5PycdXMP5IbwEU6MSqyz6KAP8nqFd+3BL
         sefcTFepBwPn/LXJ15fNh90QiaeL4qohr2O5XSVU85SrLQuhFgDfK2RxV0CSKaWugs
         FfjfIJyehAVqn5cgfKeA8vDYqXNjTjYDqAmBHFhIKzBwbLTn1selVfXNwd5MSiXQ+z
         PnCyJ9zaUdvSzah7oiSgf1D0zLvJwlA8Qnvx9HG/KWo2nUUAylLvdBBmDawRSZwTWy
         veVm112PHk4aZNwyT17BlTW0u+NIW1D07I27H/o8BjyQyTL1itz2blrx8S3rabXYy5
         8TqWGXnzcK3dQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UHlv893319606;
        Tue, 30 Jul 2019 10:47:57 -0700
Date:   Tue, 30 Jul 2019 10:47:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-lk6dasjr1yf9rtvl292b2hpc@git.kernel.org>
Cc:     lclaudio@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        tglx@linutronix.de, acme@redhat.com, mingo@kernel.org
Reply-To: mingo@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de,
          acme@redhat.com, jolsa@kernel.org, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, lclaudio@redhat.com, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf bpf: Do not attach a BPF prog to a tracepoint
 if its name starts with !
Git-Commit-ID: 2620b7e3696a9470c7cda0a08e55813fd5e57e5c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  2620b7e3696a9470c7cda0a08e55813fd5e57e5c
Gitweb:     https://git.kernel.org/tip/2620b7e3696a9470c7cda0a08e55813fd5e57e5c
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 15 Jul 2019 15:29:34 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:40 -0300

perf bpf: Do not attach a BPF prog to a tracepoint if its name starts with !

With BPF_MAP_TYPE_PROG_ARRAY + bpf_tail_call() we want to have BPF
programs, i.e. functions in a object file that perf's BPF loader
shouldn't try to attach to anything, i.e. "!syscalls:sys_enter_open"
should just stay there, not be attached to a tracepoint with that name,
it'll be used by, for instance, 'perf trace' to associate with syscalls
that copy, in addition to the syscall raw args, a filename pointed by
the first arg, i.e. multiple syscalls that need copying the same pointer
arg in the same way, as a filename, for instance, will share the same
BPF program/function.

Right now when perf's BPF loader sees a function with a name
"sys:name" it'll look for a tracepoint and will associate that BPF
program with it, say:

  SEC("raw_syscalls:sys_enter")
  int sys_enter(struct syscall_enter_args *args)
  {
     //SNIP
  }

Will crate a perf_evsel tracepoint event and then associate with it that
BPF program.

This convention at some point will switch to the one used by the BPF
loader in libbpf, but to experiment with BPF_MAP_TYPE_PROG_ARRAY in
'perf trace' lets do this, that will not require changing too much
stuff.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-lk6dasjr1yf9rtvl292b2hpc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 371ff3aee769..fac6b32ef94a 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -639,6 +639,15 @@ static int add_bpf_event(const char *group, const char *event, int fd,
 	struct list_head *list = param->list;
 	struct perf_evsel *pos;
 	int err;
+	/*
+	 * Check if we should add the event, i.e. if it is a TP but starts with a '!',
+	 * then don't add the tracepoint, this will be used for something else, like
+	 * adding to a BPF_MAP_TYPE_PROG_ARRAY.
+	 *
+	 * See tools/perf/examples/bpf/augmented_raw_syscalls.c
+	 */
+	if (group[0] == '!')
+		return 0;
 
 	pr_debug("add bpf event %s:%s and attach bpf program %d\n",
 		 group, event, fd);
