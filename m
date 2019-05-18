Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8420522276
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2019 11:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbfERJEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 May 2019 05:04:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50889 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfERJEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:04:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I94L8N1736066
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:04:21 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I94L8N1736066
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558170261;
        bh=+7LEYlX/cQo+o3Cl5/qfg42Kbz0ixCkb87hRr1yoi5E=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=wvy9Vq7fcz60uLO9udDdsThOeDOy3141XhkkCZwuhcBVx9hjDECvtPVHdrzisI2Um
         SQAJ9PARdvvvOcadQI6Ip5qdM2kVKoKH+xeSKlVxuKn/dRn/6FJHamFe1Kg5Sn8V/u
         cyrOaEM5muufslRdsg1hfOdikPOjUAXHfKsUbJzFwAAi1U1ulPuDTlSUpIVwM7Pl7M
         520nNGbuGtpW+IPV7fmbN2ty0ZK0Epl7a1eJaeyby5ElmmFN17gHvGKZovwkv3EizA
         WKn7RHz8yK2PgnFr4nQZJuu4eDbB95kM4BUov+mDh7nKZzKCQR0dVyfw4AnGFaV6At
         IxUMmQXHYEnUw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I94KMp1736062;
        Sat, 18 May 2019 02:04:20 -0700
Date:   Sat, 18 May 2019 02:04:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-802e985eb682e766992d2f851e4f1843414b3b0e@git.kernel.org>
Cc:     acme@redhat.com, akpm@linux-foundation.org, rostedt@goodmis.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        tstoyanov@vmware.com
Reply-To: tstoyanov@vmware.com, tglx@linutronix.de, mingo@kernel.org,
          namhyung@kernel.org, jolsa@redhat.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, rostedt@goodmis.org,
          akpm@linux-foundation.org, acme@redhat.com
In-Reply-To: <20190510200107.063709363@goodmis.org>
References: <20190510200107.063709363@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Man page for host endian APIs
Git-Commit-ID: 802e985eb682e766992d2f851e4f1843414b3b0e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-3.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        T_DATE_IN_FUTURE_96_Q autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  802e985eb682e766992d2f851e4f1843414b3b0e
Gitweb:     https://git.kernel.org/tip/802e985eb682e766992d2f851e4f1843414b3b0e
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Fri, 10 May 2019 15:56:14 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:47 -0300

tools lib traceevent: Man page for host endian APIs

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
 .../Documentation/libtraceevent-host_endian.txt    | 104 +++++++++++++++++++++
 1 file changed, 104 insertions(+)

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
