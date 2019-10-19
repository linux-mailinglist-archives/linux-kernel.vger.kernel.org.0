Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70193DDB48
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2019 00:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfJSWHe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 19 Oct 2019 18:07:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47043 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726143AbfJSWHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 18:07:34 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-nL5Y94MiNzGK8GvS41-CuQ-1; Sat, 19 Oct 2019 18:07:30 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AAB1800D4E;
        Sat, 19 Oct 2019 22:07:29 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-25.brq.redhat.com [10.40.204.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5033E19C7F;
        Sat, 19 Oct 2019 22:07:27 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Jan Stancek <jstancek@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH] perf/x86/intel/pt: Fix base for single entry topa
Date:   Sun, 20 Oct 2019 00:07:26 +0200
Message-Id: <20191019220726.12213-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: nL5Y94MiNzGK8GvS41-CuQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jan reported failing ltp test for pt. It looks like the reason
is commit 38bb8d77d0b9, that did not keep the TOPA_SHIFT for
entry base, adding it back.

[1] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/tracing/pt_test/pt_test.c

Reported-by: Jan Stancek <jstancek@redhat.com>
Fixes: 38bb8d77d0b9 ("perf/x86/intel/pt: Split ToPA metadata and page layout")
Signed-off-by: Jiri Olsa <jolsa@redhat.com>
---
 arch/x86/events/intel/pt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 74e80ed9c6c4..05e43d0f430b 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -627,7 +627,7 @@ static struct topa *topa_alloc(int cpu, gfp_t gfp)
 	 * link as the 2nd entry in the table
 	 */
 	if (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries)) {
-		TOPA_ENTRY(&tp->topa, 1)->base = page_to_phys(p);
+		TOPA_ENTRY(&tp->topa, 1)->base = page_to_phys(p) >> TOPA_SHIFT;
 		TOPA_ENTRY(&tp->topa, 1)->end = 1;
 	}
 
-- 
2.21.0

