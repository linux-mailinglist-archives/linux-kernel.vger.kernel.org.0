Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5CCC2CDFD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 19:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfE1Rux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 13:50:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbfE1Ruw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 13:50:52 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9681A217F9;
        Tue, 28 May 2019 17:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559065851;
        bh=M2PJxbxYcv3cB9X8zvPKk19cqHlnqV1jHkmyTiTkA8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gRjkSIRV/LL+5qI4GQj9p9DKaD1eMzUBDwEO8tN+M/vTywakZiHfNuRp3tMXKsqNO
         9jR0UstMKSFIrauOKic0zD4d8Sf1DbT9yh+FYgJAL+a+XC0MrtYAoakgHTznADn4Cy
         Ztj6MADwK+pju2Sii/M4uAn7ExA+1mI7OTf1/wO4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 06/14] tools headers UAPI: Sync linux/fs.h with the kernel
Date:   Tue, 28 May 2019 14:50:12 -0300
Message-Id: <20190528175020.13343-7-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528175020.13343-1-acme@kernel.org>
References: <20190528175020.13343-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes in:

  c553ea4fdf27 ("fs/sync.c: sync_file_range(2) may use WB_SYNC_ALL writeback")

That should be used to beautify the 'sync_file_range' syscall 'flags'
arg.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/fs.h' differs from latest version at 'include/uapi/linux/fs.h'
  diff -u tools/include/uapi/linux/fs.h include/uapi/linux/fs.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-at3uoqcvmqdkwaysmvbj1wpv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/fs.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/include/uapi/linux/fs.h b/tools/include/uapi/linux/fs.h
index 121e82ce296b..59c71fa8c553 100644
--- a/tools/include/uapi/linux/fs.h
+++ b/tools/include/uapi/linux/fs.h
@@ -320,6 +320,9 @@ struct fscrypt_key {
 #define SYNC_FILE_RANGE_WAIT_BEFORE	1
 #define SYNC_FILE_RANGE_WRITE		2
 #define SYNC_FILE_RANGE_WAIT_AFTER	4
+#define SYNC_FILE_RANGE_WRITE_AND_WAIT	(SYNC_FILE_RANGE_WRITE | \
+					 SYNC_FILE_RANGE_WAIT_BEFORE | \
+					 SYNC_FILE_RANGE_WAIT_AFTER)
 
 /*
  * Flags for preadv2/pwritev2:
-- 
2.20.1

