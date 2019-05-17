Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8403421E7E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 21:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbfEQTiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 15:38:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727771AbfEQTiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:38:22 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 372A72087B;
        Fri, 17 May 2019 19:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558121901;
        bh=ZZHpVeldgq2te0IVdNlVpjadCkX6kTS1VW6eps8Klc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DXl/cscYi22cHe4wi4q5ZrvOrlcfDIWwB2CxZDsqSK2uNeSIkJTVoMbviBiUKkplG
         9otLxNNc1xVx/b6qa/thZ/X5/DunkkOfEceE8HykuoSuBa9D3YojVuKTvNyZsEurcl
         kgUkEURF0eRpQvk6N/fxz8w9NYHAUFvvWZj6AA5g=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 27/73] tools lib traceevent: Man page for host endian APIs
Date:   Fri, 17 May 2019 16:35:25 -0300
Message-Id: <20190517193611.4974-28-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

Create man pages for libtraceevent APIs:

  tep_is_bigendian(),
  tep_is_local_bigendian(),
  tep_set_local_bigendian()

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/linux-trace-devel/20190503091119.23399-8-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190510200107.063709363@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../libtraceevent-host_endian.txt             | 104 ++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-host_endian.txt

diff --git a/tools/lib/traceevent/Documentation/libtraceevent-host_endian.txt b/tools/lib/traceevent/Documentation/libtraceevent-host_endian.txt
new file mode 100644
index 000000000000..d5d375eb8d1e
--- /dev/null
+++ b/tools/lib/traceevent/Documentation/libtraceevent-host_endian.txt
@@ -0,0 +1,104 @@
+libtraceevent(3)
+================
+
+NAME
+----
+tep_is_bigendian, tep_is_local_bigendian, tep_set_local_bigendian - Get / set
+the endianness of the local machine.
+
+SYNOPSIS
+--------
+[verse]
+--
+*#include <event-parse.h>*
+
+enum *tep_endian* {
+	TEP_LITTLE_ENDIAN = 0,
+	TEP_BIG_ENDIAN
+};
+
+int *tep_is_bigendian*(void);
+bool *tep_is_local_bigendian*(struct tep_handle pass:[*]_tep_);
+void *tep_set_local_bigendian*(struct tep_handle pass:[*]_tep_, enum tep_endian _endian_);
+--
+
+DESCRIPTION
+-----------
+
+The _tep_is_bigendian()_ gets the endianness of the machine, executing
+the function.
+
+The _tep_is_local_bigendian()_ function gets the endianness of the local
+machine, saved in the _tep_ handler. The _tep_ argument is the trace event
+parser context. This API is a bit faster than _tep_is_bigendian()_, as it
+returns cached endianness of the local machine instead of checking it each time.
+
+The _tep_set_local_bigendian()_ function sets the endianness of the local
+machine in the _tep_ handler. The _tep_ argument is trace event parser context.
+The _endian_ argument is the endianness:
+[verse]
+--
+	_TEP_LITTLE_ENDIAN_ - the machine is little endian,
+	_TEP_BIG_ENDIAN_ - the machine is big endian.
+--
+
+RETURN VALUE
+------------
+The _tep_is_bigendian()_ function returns non zero if the endianness of the
+machine, executing the code, is big endian and zero otherwise.
+
+The _tep_is_local_bigendian()_ function returns true, if the endianness of the
+local machine, saved in the _tep_ handler, is big endian, or false otherwise.
+
+EXAMPLE
+-------
+[source,c]
+--
+#include <event-parse.h>
+...
+struct tep_handle *tep = tep_alloc();
+...
+	if (tep_is_bigendian())
+		tep_set_local_bigendian(tep, TEP_BIG_ENDIAN);
+	else
+		tep_set_local_bigendian(tep, TEP_LITTLE_ENDIAN);
+...
+	if (tep_is_local_bigendian(tep))
+		printf("This machine you are running on is bigendian\n");
+	else
+		printf("This machine you are running on is little endian\n");
+
+--
+
+FILES
+-----
+[verse]
+--
+*event-parse.h*
+	Header file to include in order to have access to the library APIs.
+*-ltraceevent*
+	Linker switch to add when building a program that uses the library.
+--
+
+SEE ALSO
+--------
+_libtraceevent(3)_, _trace-cmd(1)_
+
+AUTHOR
+------
+[verse]
+--
+*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
+*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
+--
+REPORTING BUGS
+--------------
+Report bugs to  <linux-trace-devel@vger.kernel.org>
+
+LICENSE
+-------
+libtraceevent is Free Software licensed under the GNU LGPL 2.1
+
+RESOURCES
+---------
+https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
-- 
2.20.1

