Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBEE5E6C2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 16:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfGCObn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 10:31:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45129 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGCObn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:31:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63EVTUX3327509
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:31:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63EVTUX3327509
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562164290;
        bh=Yw4bKg9NQiQDGNsE8NvApjjYe94H5QZQrNn/Wjl1cMw=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=vYYIIC9PAnVRCowv5QnZimLjGntstgoOdJwUJeTIvM1sPPaBJuYuvQfriLkmCnK8j
         2JkPsKTPbPslY//PKwMpL3vfk0WoF44SqPzOKLxWy6ZTrIRGUQkTKscq4nypWlgO7R
         gbEoWHbB+2+WhvnZaR8ESEUJ/z4ce59uUoMzQCLjTDAYf/z3nkCNnbcDNrSQIkzFob
         NEow0DFDG0FiZSmTq6/lvgGvgkCol+douq8PKiNdvT4+9m6egL7Zq14hHy0h/WVWNv
         ootiZcn0bmFc+6LTPQGQ8NKAKBLQVkjOZ1VZjbyoIEIiIKJ8eh9vMbz0lHepVESE1V
         AOhuRAUlAooQw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63EVT2v3327504;
        Wed, 3 Jul 2019 07:31:29 -0700
Date:   Wed, 3 Jul 2019 07:31:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Luke Mujica <tipbot@zytor.com>
Message-ID: <tip-prgnwmaoo1pv9zz4vnv1bjaj@git.kernel.org>
Cc:     acme@redhat.com, jolsa@redhat.com, lukemujica@google.com,
        tglx@linutronix.de, irogers@google.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        nums@google.com, eranian@google.com
Reply-To: nums@google.com, eranian@google.com, mingo@kernel.org,
          lukemujica@google.com, tglx@linutronix.de, hpa@zytor.com,
          linux-kernel@vger.kernel.org, irogers@google.com,
          acme@redhat.com, jolsa@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf jevents: Use nonlocal include statements in
 pmu-events.c
Git-Commit-ID: 06c642c0e9fceafd16b1a4c80d44b1c09e282215
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-3.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  06c642c0e9fceafd16b1a4c80d44b1c09e282215
Gitweb:     https://git.kernel.org/tip/06c642c0e9fceafd16b1a4c80d44b1c09e282215
Author:     Luke Mujica <lukemujica@google.com>
AuthorDate: Tue, 25 Jun 2019 10:31:22 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 1 Jul 2019 22:50:42 -0300

perf jevents: Use nonlocal include statements in pmu-events.c

Change pmu-events.c to not use local include statements. The code that
creates the include statements for pmu-events.c is in jevents.c.

pmu-events.c is a generated file, and for build systems that put
generated files in a separate directory, include statements with local
pathing cannot find non-generated files.

Signed-off-by: Luke Mujica <lukemujica@google.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Numfor Mbiziwo-Tiapo <nums@google.com>
Cc: Stephane Eranian <eranian@google.com>
Link: https://lkml.kernel.org/n/tip-prgnwmaoo1pv9zz4vnv1bjaj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/jevents.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 58f77fd0f59f..a1184ea64cc6 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -841,7 +841,7 @@ static void create_empty_mapping(const char *output_file)
 		_Exit(1);
 	}
 
-	fprintf(outfp, "#include \"../../pmu-events/pmu-events.h\"\n");
+	fprintf(outfp, "#include \"pmu-events/pmu-events.h\"\n");
 	print_mapping_table_prefix(outfp);
 	print_mapping_table_suffix(outfp);
 	fclose(outfp);
@@ -1096,7 +1096,7 @@ int main(int argc, char *argv[])
 	}
 
 	/* Include pmu-events.h first */
-	fprintf(eventsfp, "#include \"../../pmu-events/pmu-events.h\"\n");
+	fprintf(eventsfp, "#include \"pmu-events/pmu-events.h\"\n");
 
 	/*
 	 * The mapfile allows multiple CPUids to point to the same JSON file,
