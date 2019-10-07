Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65CD5CE136
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 14:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfJGMG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 08:06:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:3272 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbfJGMG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:06:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 05:06:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,268,1566889200"; 
   d="scan'208";a="344715622"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.66])
  by orsmga004.jf.intel.com with ESMTP; 07 Oct 2019 05:06:55 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] perf session: Fix indent in perf_session__new()
Date:   Mon,  7 Oct 2019 15:05:33 +0300
Message-Id: <20191007120533.19071-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor white space fix.

Reported-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/session.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 061bb4d6a3f5..5b7a85224cee 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -227,8 +227,8 @@ struct perf_session *perf_session__new(struct perf_data *data,
 			/* Open the directory data. */
 			if (data->is_dir) {
 				ret = perf_data__open_dir(data);
-			if (ret)
-				goto out_delete;
+				if (ret)
+					goto out_delete;
 			}
 		}
 	} else  {
-- 
2.17.1

