Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEC0C10FF64
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 14:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfLCN52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 08:57:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:35542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfLCN50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:57:26 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86C5020409;
        Tue,  3 Dec 2019 13:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575381446;
        bh=5HsrQ91rsRMjs222G21GWWlJX7cH7KjfErCjL0wtVL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vq4mOm1zFHUgzh98S2HHxpLnjTV27QxJldI7qAayvC9PWKmYe67CQdFM9lZM0b48g
         EHsGLLLYGz48ZiJNS4U/qTmHdfaYDt+UR2R2YT/56yIXqKpLplLRj+7Tx1vBaPUOXx
         NbJzOY+nzUia2YSncSU7WvVxcOGYZr0U79Wb/FTk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 23/23] libtraceevent: Copy pkg-config file to output folder when using O=
Date:   Tue,  3 Dec 2019 10:56:06 -0300
Message-Id: <20191203135606.24902-24-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191203135606.24902-1-acme@kernel.org>
References: <20191203135606.24902-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

When we use 'O=' with make to build libtraceevent in a separate folder
it still copies 'libtraceevent.pc' to its source folder. Modify the
Makefile so that it uses the output folder to copy the pkg-config file
and install from there.

Signed-off-by: Sudipm Mukherjee <sudipm.mukherjee@gmail.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/lkml/20191115113610.21493-2-sudipm.mukherjee@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/lib/traceevent/Makefile b/tools/lib/traceevent/Makefile
index 83446fe2cf01..c5a03356a999 100644
--- a/tools/lib/traceevent/Makefile
+++ b/tools/lib/traceevent/Makefile
@@ -208,10 +208,11 @@ define do_install
 	$(INSTALL) $(if $3,-m $3,) $1 '$(DESTDIR_SQ)$2'
 endef
 
-PKG_CONFIG_FILE = libtraceevent.pc
+PKG_CONFIG_SOURCE_FILE = libtraceevent.pc
+PKG_CONFIG_FILE := $(addprefix $(OUTPUT),$(PKG_CONFIG_SOURCE_FILE))
 define do_install_pkgconfig_file
 	if [ -n "${pkgconfig_dir}" ]; then 					\
-		cp -f ${PKG_CONFIG_FILE}.template ${PKG_CONFIG_FILE}; 		\
+		cp -f ${PKG_CONFIG_SOURCE_FILE}.template ${PKG_CONFIG_FILE};	\
 		sed -i "s|INSTALL_PREFIX|${1}|g" ${PKG_CONFIG_FILE}; 		\
 		sed -i "s|LIB_VERSION|${EVENT_PARSE_VERSION}|g" ${PKG_CONFIG_FILE}; \
 		sed -i "s|LIB_DIR|${libdir}|g" ${PKG_CONFIG_FILE}; \
-- 
2.21.0

