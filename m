Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B93F21E7A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 21:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbfEQTiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 15:38:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727771AbfEQTiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:38:04 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83F3521743;
        Fri, 17 May 2019 19:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558121882;
        bh=WGTsszVqHzwa79TEsfVcmtG7QBzzZkFsXFEs6E6OTqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=puaCo0sq+vxCTiJMpLrsf85kS/gbXyrIWMIf+Iy6kWloRnlhlIJBkcgfwAXTOnlS/
         eH7RWcz4xY+cclmtKixU2e4dLEcHVEdUiTQNcJCm7ZOyx5Ia4gbMOdo/NDwkIBzeqs
         uv4GcaSU9MXyWZmnL08zC04sP6SWO+hPkn7EhHfE=
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
Subject: [PATCH 23/73] tools lib traceevent: Man pages for tep_handler related APIs
Date:   Fri, 17 May 2019 16:35:21 -0300
Message-Id: <20190517193611.4974-24-acme@kernel.org>
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

Added 4 new man pages, describing libtraceevent APIs:

  tep_register_comm(),
  tep_override_comm(),
  tep_is_pid_registered(),
  tep_data_comm_from_pid(),
  tep_data_pid_from_comm(),
  tep_cmdline_pid(),
  tep_alloc(),
  tep_free(),
  tep_get_long_size(),
  tep_set_long_size(),
  tep_set_flag(),
  tep_clear_flag(),
  tep_test_flag()

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/linux-trace-devel/20190503091119.23399-4-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190510200106.420270952@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../Documentation/libtraceevent-commands.txt  | 153 ++++++++++++++++++
 .../Documentation/libtraceevent-handle.txt    | 101 ++++++++++++
 .../Documentation/libtraceevent-long_size.txt |  78 +++++++++
 .../Documentation/libtraceevent-set_flag.txt  | 104 ++++++++++++
 4 files changed, 436 insertions(+)
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-commands.txt
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-handle.txt
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-long_size.txt
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-set_flag.txt

diff --git a/tools/lib/traceevent/Documentation/libtraceevent-commands.txt b/tools/lib/traceevent/Documentation/libtraceevent-commands.txt
new file mode 100644
index 000000000000..bec552001f8e
--- /dev/null
+++ b/tools/lib/traceevent/Documentation/libtraceevent-commands.txt
@@ -0,0 +1,153 @@
+libtraceevent(3)
+================
+
+NAME
+----
+tep_register_comm, tep_override_comm, tep_pid_is_registered,
+tep_data_comm_from_pid, tep_data_pid_from_comm, tep_cmdline_pid -
+Manage pid to process name mappings.
+
+SYNOPSIS
+--------
+[verse]
+--
+*#include <event-parse.h>*
+
+int *tep_register_comm*(struct tep_handle pass:[*]_tep_, const char pass:[*]_comm_, int _pid_);
+int *tep_override_comm*(struct tep_handle pass:[*]_tep_, const char pass:[*]_comm_, int _pid_);
+bool *tep_is_pid_registered*(struct tep_handle pass:[*]_tep_, int _pid_);
+const char pass:[*]*tep_data_comm_from_pid*(struct tep_handle pass:[*]_pevent_, int _pid_);
+struct cmdline pass:[*]*tep_data_pid_from_comm*(struct tep_handle pass:[*]_pevent_, const char pass:[*]_comm_, struct cmdline pass:[*]_next_);
+int *tep_cmdline_pid*(struct tep_handle pass:[*]_pevent_, struct cmdline pass:[*]_cmdline_);
+--
+
+DESCRIPTION
+-----------
+These functions can be used to handle the mapping between pid and process name.
+The library builds a cache of these mappings, which is used to display the name
+of the process, instead of its pid. This information can be retrieved from
+tracefs/saved_cmdlines file.
+
+The _tep_register_comm()_ function registers a _pid_ / process name mapping.
+If a command with the same _pid_ is already registered, an error is returned.
+The _pid_ argument is the process ID, the _comm_ argument is the process name,
+_tep_ is the event context. The _comm_ is duplicated internally.
+
+The _tep_override_comm()_ function registers a _pid_ / process name mapping.
+If a process with the same pid is already registered, the process name string is
+udapted with the new one. The _pid_ argument is the process ID, the _comm_
+argument is the process name, _tep_ is the event context. The _comm_ is
+duplicated internally.
+
+The _tep_is_pid_registered()_ function checks if a pid has a process name
+mapping registered. The _pid_ argument is the process ID, _tep_ is the event
+context.
+
+The _tep_data_comm_from_pid()_ function returns the process name for a given
+pid. The _pid_ argument is the process ID, _tep_ is the event context.
+The returned string should not be freed, but will be freed when the _tep_
+handler is closed.
+
+The _tep_data_pid_from_comm()_ function returns a pid for a given process name.
+The _comm_ argument is the process name, _tep_ is the event context.
+The argument _next_ is the cmdline structure to search for the next pid.
+As there may be more than one pid for a given process, the result of this call
+can be passed back into a recurring call in the _next_ parameter, to search for
+the next pid. If _next_ is NULL, it will return the first pid associated with
+the _comm_. The function performs a linear search, so it may be slow.
+
+The _tep_cmdline_pid()_ function returns the pid associated with a given
+_cmdline_. The _tep_ argument is the event context.
+
+RETURN VALUE
+------------
+_tep_register_comm()_ function returns 0 on success. In case of an error -1 is
+returned and errno is set to indicate the cause of the problem: ENOMEM, if there
+is not enough memory to duplicate the _comm_ or EEXIST if a mapping for this
+_pid_ is already registered.
+
+_tep_override_comm()_ function returns 0 on success. In case of an error -1 is
+returned and errno is set to indicate the cause of the problem: ENOMEM, if there
+is not enough memory to duplicate the _comm_.
+
+_tep_is_pid_registered()_ function returns true if the _pid_ has a process name
+mapped to it, false otherwise.
+
+_tep_data_comm_from_pid()_ function returns the process name as string, or the
+string "<...>" if there is no mapping for the given pid.
+
+_tep_data_pid_from_comm()_ function returns a pointer to a struct cmdline, that
+holds a pid for a given process, or NULL if none is found. This result can be
+passed back into a recurring call as the _next_ parameter of the function.
+
+_tep_cmdline_pid()_ functions returns the pid for the give cmdline. If _cmdline_
+ is NULL, then -1 is returned.
+
+EXAMPLE
+-------
+The following example registers pid for command "ls", in context of event _tep_
+and performs various searches for pid / process name mappings:
+[source,c]
+--
+#include <event-parse.h>
+...
+int ret;
+int ls_pid = 1021;
+struct tep_handle *tep = tep_alloc();
+...
+	ret = tep_register_comm(tep, "ls", ls_pid);
+	if (ret != 0 && errno == EEXIST)
+		ret = tep_override_comm(tep, "ls", ls_pid);
+	if (ret != 0) {
+		/* Failed to register pid / command mapping */
+	}
+...
+	if (tep_is_pid_registered(tep, ls_pid) == 0) {
+		/* Command mapping for ls_pid is not registered */
+	}
+...
+	const char *comm = tep_data_comm_from_pid(tep, ls_pid);
+	if (comm) {
+		/* Found process name for ls_pid */
+	}
+...
+	int pid;
+	struct cmdline *cmd = tep_data_pid_from_comm(tep, "ls", NULL);
+	while (cmd) {
+		pid = tep_cmdline_pid(tep, cmd);
+		/* Found pid for process "ls" */
+		cmd = tep_data_pid_from_comm(tep, "ls", cmd);
+	}
+--
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
diff --git a/tools/lib/traceevent/Documentation/libtraceevent-handle.txt b/tools/lib/traceevent/Documentation/libtraceevent-handle.txt
new file mode 100644
index 000000000000..8d568316847d
--- /dev/null
+++ b/tools/lib/traceevent/Documentation/libtraceevent-handle.txt
@@ -0,0 +1,101 @@
+libtraceevent(3)
+================
+
+NAME
+----
+tep_alloc, tep_free,tep_ref, tep_unref,tep_ref_get - Create, destroy, manage
+references of trace event parser context.
+
+SYNOPSIS
+--------
+[verse]
+--
+*#include <event-parse.h>*
+
+struct tep_handle pass:[*]*tep_alloc*(void);
+void *tep_free*(struct tep_handle pass:[*]_tep_);
+void *tep_ref*(struct tep_handle pass:[*]_tep_);
+void *tep_unref*(struct tep_handle pass:[*]_tep_);
+int *tep_ref_get*(struct tep_handle pass:[*]_tep_);
+--
+
+DESCRIPTION
+-----------
+These are the main functions to create and destroy tep_handle - the main
+structure, representing the trace event parser context. This context is used as
+the input parameter of most library APIs.
+
+The _tep_alloc()_ function allocates and initializes the tep context.
+
+The _tep_free()_ function will decrement the reference of the _tep_ handler.
+When there is no more references, then it will free the handler, as well
+as clean up all its resources that it had used. The argument _tep_ is
+the pointer to the trace event parser context.
+
+The _tep_ref()_ function adds a reference to the _tep_ handler.
+
+The _tep_unref()_ function removes a reference from the _tep_ handler. When
+the last reference is removed, the _tep_ is destroyed, and all resources that
+it had used are cleaned up.
+
+The _tep_ref_get()_ functions gets the current references of the _tep_ handler.
+
+RETURN VALUE
+------------
+_tep_alloc()_ returns a pointer to a newly created tep_handle structure.
+NULL is returned in case there is not enough free memory to allocate it.
+
+_tep_ref_get()_ returns the current references of _tep_.
+If _tep_ is NULL, 0 is returned.
+
+EXAMPLE
+-------
+[source,c]
+--
+#include <event-parse.h>
+
+...
+struct tep_handle *tep = tep_alloc();
+...
+int ref = tep_ref_get(tep);
+tep_ref(tep);
+if ( (ref+1) != tep_ref_get(tep)) {
+	/* Something wrong happened, the counter is not incremented by 1 */
+}
+tep_unref(tep);
+...
+tep_free(tep);
+...
+--
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
diff --git a/tools/lib/traceevent/Documentation/libtraceevent-long_size.txt b/tools/lib/traceevent/Documentation/libtraceevent-long_size.txt
new file mode 100644
index 000000000000..01d78ea2519a
--- /dev/null
+++ b/tools/lib/traceevent/Documentation/libtraceevent-long_size.txt
@@ -0,0 +1,78 @@
+libtraceevent(3)
+================
+
+NAME
+----
+tep_get_long_size, tep_set_long_size - Get / set the size of a long integer on
+the machine, where the trace is generated, in bytes
+
+SYNOPSIS
+--------
+[verse]
+--
+*#include <event-parse.h>*
+
+int *tep_get_long_size*(strucqt tep_handle pass:[*]_tep_);
+void *tep_set_long_size*(struct tep_handle pass:[*]_tep_, int _long_size_);
+--
+
+DESCRIPTION
+-----------
+The _tep_get_long_size()_ function returns the size of a long integer on the machine,
+where the trace is generated. The _tep_ argument is trace event parser context.
+
+The _tep_set_long_size()_ function sets the size of a long integer on the machine,
+where the trace is generated. The _tep_ argument is trace event parser context.
+The _long_size_ is the size of a long integer, in bytes.
+
+RETURN VALUE
+------------
+The _tep_get_long_size()_ function returns the size of a long integer on the machine,
+where the trace is generated, in bytes.
+
+EXAMPLE
+-------
+[source,c]
+--
+#include <event-parse.h>
+...
+struct tep_handle *tep = tep_alloc();
+...
+tep_set_long_size(tep, 4);
+...
+int long_size = tep_get_long_size(tep);
+...
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
diff --git a/tools/lib/traceevent/Documentation/libtraceevent-set_flag.txt b/tools/lib/traceevent/Documentation/libtraceevent-set_flag.txt
new file mode 100644
index 000000000000..b0599780b9a6
--- /dev/null
+++ b/tools/lib/traceevent/Documentation/libtraceevent-set_flag.txt
@@ -0,0 +1,104 @@
+libtraceevent(3)
+================
+
+NAME
+----
+tep_set_flag, tep_clear_flag, tep_test_flag -
+Manage flags of trace event parser context.
+
+SYNOPSIS
+--------
+[verse]
+--
+*#include <event-parse.h>*
+
+enum *tep_flag* {
+	_TEP_NSEC_OUTPUT_,
+	_TEP_DISABLE_SYS_PLUGINS_,
+	_TEP_DISABLE_PLUGINS_
+};
+void *tep_set_flag*(struct tep_handle pass:[*]_tep_, enum tep_flag _flag_);
+void *tep_clear_flag*(struct tep_handle pass:[*]_tep_, enum tep_flag _flag_);
+bool *tep_test_flag*(struct tep_handle pass:[*]_tep_, enum tep_flag _flag_);
+--
+
+DESCRIPTION
+-----------
+Trace event parser context flags are defined in *enum tep_flag*:
+[verse]
+--
+_TEP_NSEC_OUTPUT_ - print event's timestamp in nano seconds, instead of micro seconds.
+_TEP_DISABLE_SYS_PLUGINS_ - disable plugins, located in system's plugin
+			directory. This directory is defined at library compile
+			time, and usually depends on library installation
+			prefix: (install_preffix)/lib/traceevent/plugins
+_TEP_DISABLE_PLUGINS_ - disable all library plugins:
+			- in system's plugin directory
+			- in directory, defined by the environment variable _TRACEEVENT_PLUGIN_DIR_
+			- in user's home directory, _~/.traceevent/plugins_
+--
+Note: plugin related flags must me set before calling _tep_load_plugins()_ API.
+
+The _tep_set_flag()_ function sets _flag_ to _tep_ context.
+
+The _tep_clear_flag()_ function clears _flag_ from _tep_ context.
+
+The _tep_test_flag()_ function tests if _flag_ is set to _tep_ context.
+
+RETURN VALUE
+------------
+_tep_test_flag()_ function returns true if _flag_ is set, false otherwise.
+
+EXAMPLE
+-------
+[source,c]
+--
+#include <event-parse.h>
+...
+struct tep_handle *tep = tep_alloc();
+...
+/* Print timestamps in nanoseconds */
+tep_set_flag(tep,  TEP_NSEC_OUTPUT);
+...
+if (tep_test_flag(tep, TEP_NSEC_OUTPUT)) {
+	/* print timestamps in nanoseconds */
+} else {
+	/* print timestamps in microseconds */
+}
+...
+/* Print timestamps in microseconds */
+tep_clear_flag(tep, TEP_NSEC_OUTPUT);
+...
+--
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

