Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C55C796963
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 21:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbfHTT14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 15:27:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730334AbfHTT14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 15:27:56 -0400
Received: from quaco.ghostprotocols.net (177.206.236.100.dynamic.adsl.gvt.net.br [177.206.236.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98C2F22DD6;
        Tue, 20 Aug 2019 19:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566329275;
        bh=7RR7D4GuaKbiFw/QReZVtbwH7s3xDpxLyc+n11C866k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MT9t4RmtfgVcrBhJV5gJKeSpXnWJhrUoBSIFMYb8jy2G82extQdyj1Iochmw7oCEW
         kRUbyNKYkvxvgx+BlCUgPoqGLwbfUgHCmc7Zwe6pcbmG9ZxlxCqjy/u/pjyzgxHfNM
         AnKMCWfk7ZWLurv+pmrC++SjN+zrKnXbPqblwRvE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 01/17] tools headers: Add limits.h to access __WORDSIZE
Date:   Tue, 20 Aug 2019 16:27:17 -0300
Message-Id: <20190820192733.19180-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820192733.19180-1-acme@kernel.org>
References: <20190820192733.19180-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We need to make sure limits.h is included before checking if we can use
__WORDSIZE, do it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-5yfoed4rnsck2n3cwhm9mvth@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/bitops.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/linux/bitops.h b/tools/include/linux/bitops.h
index 0b0ef3abc966..140c8362f113 100644
--- a/tools/include/linux/bitops.h
+++ b/tools/include/linux/bitops.h
@@ -3,6 +3,7 @@
 #define _TOOLS_LINUX_BITOPS_H_
 
 #include <asm/types.h>
+#include <limits.h>
 #ifndef __WORDSIZE
 #define __WORDSIZE (__SIZEOF_LONG__ * 8)
 #endif
-- 
2.21.0

