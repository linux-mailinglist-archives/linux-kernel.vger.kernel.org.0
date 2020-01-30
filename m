Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA5B14DD3A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 15:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgA3Osr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 09:48:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:33578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727485AbgA3OsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 09:48:14 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7A332468E;
        Thu, 30 Jan 2020 14:48:12 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1ixB75-001COY-QT; Thu, 30 Jan 2020 09:48:11 -0500
Message-Id: <20200130144811.696872536@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 30 Jan 2020 09:47:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 10/21] tracing: Add dynamic event command creation interface
References: <20200130144743.527378179@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Add an interface used to build up dynamic event creation commands,
such as synthetic and kprobe events.  Interfaces specific to those
particular types of events and others can be built on top of this
interface.

Command creation is started by first using the dynevent_cmd_init()
function to initialize the dynevent_cmd object.  Following that, args
are appended and optionally checked by the dynevent_arg_add() and
dynevent_arg_pair_add() functions, which use objects representing
arguments and pairs of arguments, initialized respectively by
dynevent_arg_init() and dynevent_arg_pair_init().  Finally, once all
args have been successfully added, the command is finalized and
actually created using dynevent_create().

The code here for actually printing into the dyn_event->cmd buffer
using snprintf() etc was adapted from v4 of Masami's 'tracing/boot:
Add synthetic event support' patch.

Link: http://lkml.kernel.org/r/1f65fa44390b6f238f6036777c3784ced1dcc6a0.1580323897.git.zanussi@kernel.org

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace_events.h  |  23 ++++
 kernel/trace/trace_dynevent.c | 240 ++++++++++++++++++++++++++++++++++
 kernel/trace/trace_dynevent.h |  33 +++++
 3 files changed, 296 insertions(+)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 25fe743bcbaf..651b03d5e272 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -354,6 +354,29 @@ extern struct trace_event_file *trace_get_event_file(const char *instance,
 						     const char *event);
 extern void trace_put_event_file(struct trace_event_file *file);
 
+#define MAX_DYNEVENT_CMD_LEN	(2048)
+
+enum dynevent_type {
+	DYNEVENT_TYPE_NONE,
+};
+
+struct dynevent_cmd;
+
+typedef int (*dynevent_create_fn_t)(struct dynevent_cmd *cmd);
+
+struct dynevent_cmd {
+	char			*buf;
+	const char		*event_name;
+	int			maxlen;
+	int			remaining;
+	unsigned int		n_fields;
+	enum dynevent_type	type;
+	dynevent_create_fn_t	run_command;
+	void			*private_data;
+};
+
+extern int dynevent_create(struct dynevent_cmd *cmd);
+
 extern int synth_event_delete(const char *name);
 
 /*
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index 89779eb84a07..6ffdbc4fda53 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -223,3 +223,243 @@ static __init int init_dynamic_event(void)
 	return 0;
 }
 fs_initcall(init_dynamic_event);
+
+/**
+ * dynevent_arg_add - Add an arg to a dynevent_cmd
+ * @cmd: A pointer to the dynevent_cmd struct representing the new event cmd
+ * @arg: The argument to append to the current cmd
+ *
+ * Append an argument to a dynevent_cmd.  The argument string will be
+ * appended to the current cmd string, followed by a separator, if
+ * applicable.  Before the argument is added, the check_arg()
+ * function, if defined, is called.
+ *
+ * The cmd string, separator, and check_arg() function should be set
+ * using the dynevent_arg_init() before any arguments are added using
+ * this function.
+ *
+ * Return: 0 if successful, error otherwise.
+ */
+int dynevent_arg_add(struct dynevent_cmd *cmd,
+		     struct dynevent_arg *arg)
+{
+	int ret = 0;
+	int delta;
+	char *q;
+
+	if (arg->check_arg) {
+		ret = arg->check_arg(arg);
+		if (ret)
+			return ret;
+	}
+
+	q = cmd->buf + (cmd->maxlen - cmd->remaining);
+
+	delta = snprintf(q, cmd->remaining, " %s%c", arg->str, arg->separator);
+	if (delta >= cmd->remaining) {
+		pr_err("String is too long: %s\n", arg->str);
+		return -E2BIG;
+	}
+	cmd->remaining -= delta;
+
+	return ret;
+}
+
+/**
+ * dynevent_arg_pair_add - Add an arg pair to a dynevent_cmd
+ * @cmd: A pointer to the dynevent_cmd struct representing the new event cmd
+ * @arg_pair: The argument pair to append to the current cmd
+ *
+ * Append an argument pair to a dynevent_cmd.  An argument pair
+ * consists of a left-hand-side argument and a right-hand-side
+ * argument separated by an operator, which can be whitespace, all
+ * followed by a separator, if applicable.  This can be used to add
+ * arguments of the form 'type variable_name;' or 'x+y'.
+ *
+ * The lhs argument string will be appended to the current cmd string,
+ * followed by an operator, if applicable, followd by the rhs string,
+ * followed finally by a separator, if applicable.  Before anything is
+ * added, the check_arg() function, if defined, is called.
+ *
+ * The cmd strings, operator, separator, and check_arg() function
+ * should be set using the dynevent_arg_pair_init() before any arguments
+ * are added using this function.
+ *
+ * Return: 0 if successful, error otherwise.
+ */
+int dynevent_arg_pair_add(struct dynevent_cmd *cmd,
+			  struct dynevent_arg_pair *arg_pair)
+{
+	int ret = 0;
+	int delta;
+	char *q;
+
+	if (arg_pair->check_arg) {
+		ret = arg_pair->check_arg(arg_pair);
+		if (ret)
+			return ret;
+	}
+
+	q = cmd->buf + (cmd->maxlen - cmd->remaining);
+
+	delta = snprintf(q, cmd->remaining, " %s%c", arg_pair->lhs,
+			 arg_pair->operator);
+	if (delta >= cmd->remaining) {
+		pr_err("field string is too long: %s\n", arg_pair->lhs);
+		return -E2BIG;
+	}
+	cmd->remaining -= delta; q += delta;
+
+	delta = snprintf(q, cmd->remaining, "%s%c", arg_pair->rhs,
+			 arg_pair->separator);
+	if (delta >= cmd->remaining) {
+		pr_err("field string is too long: %s\n", arg_pair->rhs);
+		return -E2BIG;
+	}
+	cmd->remaining -= delta; q += delta;
+
+	return ret;
+}
+
+/**
+ * dynevent_str_add - Add a string to a dynevent_cmd
+ * @cmd: A pointer to the dynevent_cmd struct representing the new event cmd
+ * @str: The string to append to the current cmd
+ *
+ * Append a string to a dynevent_cmd.  The string will be appended to
+ * the current cmd string as-is, with nothing prepended or appended.
+ *
+ * Return: 0 if successful, error otherwise.
+ */
+int dynevent_str_add(struct dynevent_cmd *cmd, const char *str)
+{
+	int ret = 0;
+	int delta;
+	char *q;
+
+	q = cmd->buf + (cmd->maxlen - cmd->remaining);
+
+	delta = snprintf(q, cmd->remaining, "%s", str);
+	if (delta >= cmd->remaining) {
+		pr_err("String is too long: %s\n", str);
+		return -E2BIG;
+	}
+	cmd->remaining -= delta;
+
+	return ret;
+}
+
+/**
+ * dynevent_cmd_init - Initialize a dynevent_cmd object
+ * @cmd: A pointer to the dynevent_cmd struct representing the cmd
+ * @buf: A pointer to the buffer to generate the command into
+ * @maxlen: The length of the buffer the command will be generated into
+ * @type: The type of the cmd, checked against further operations
+ * @run_command: The type-specific function that will actually run the command
+ *
+ * Initialize a dynevent_cmd.  A dynevent_cmd is used to build up and
+ * run dynamic event creation commands, such as commands for creating
+ * synthetic and kprobe events.  Before calling any of the functions
+ * used to build the command, a dynevent_cmd object should be
+ * instantiated and initialized using this function.
+ *
+ * The initialization sets things up by saving a pointer to the
+ * user-supplied buffer and its length via the @buf and @maxlen
+ * params, and by saving the cmd-specific @type and @run_command
+ * params which are used to check subsequent dynevent_cmd operations
+ * and actually run the command when complete.
+ */
+void dynevent_cmd_init(struct dynevent_cmd *cmd, char *buf, int maxlen,
+		       enum dynevent_type type,
+		       dynevent_create_fn_t run_command)
+{
+	memset(cmd, '\0', sizeof(*cmd));
+
+	cmd->buf = buf;
+	cmd->maxlen = maxlen;
+	cmd->remaining = cmd->maxlen;
+	cmd->type = type;
+	cmd->run_command = run_command;
+}
+
+/**
+ * dynevent_arg_init - Initialize a dynevent_arg object
+ * @arg: A pointer to the dynevent_arg struct representing the arg
+ * @check_arg: An (optional) pointer to a function checking arg sanity
+ * @separator: An (optional) separator, appended after adding the arg
+ *
+ * Initialize a dynevent_arg object.  A dynevent_arg represents an
+ * object used to append single arguments to the current command
+ * string.  The @check_arg function, if present, will be used to check
+ * the sanity of the current arg string (which is directly set by the
+ * caller).  After the arg string is successfully appended to the
+ * command string, the optional @separator is appended.  If no
+ * separator was specified when initializing the arg, a space will be
+ * appended.
+ */
+void dynevent_arg_init(struct dynevent_arg *arg,
+		       dynevent_check_arg_fn_t check_arg,
+		       char separator)
+{
+	memset(arg, '\0', sizeof(*arg));
+
+	if (!separator)
+		separator = ' ';
+	arg->separator = separator;
+
+	arg->check_arg = check_arg;
+}
+
+/**
+ * dynevent_arg_pair_init - Initialize a dynevent_arg_pair object
+ * @arg_pair: A pointer to the dynevent_arg_pair struct representing the arg
+ * @check_arg: An (optional) pointer to a function checking arg sanity
+ * @operator: An (optional) operator, appended after adding the first arg
+ * @separator: An (optional) separator, appended after adding the second arg
+ *
+ * Initialize a dynevent_arg_pair object.  A dynevent_arg_pair
+ * represents an object used to append argument pairs such as 'type
+ * variable_name;' or 'x+y' to the current command string.  An
+ * argument pair consists of a left-hand-side argument and a
+ * right-hand-side argument separated by an operator, which can be
+ * whitespace, all followed by a separator, if applicable. The
+ * @check_arg function, if present, will be used to check the sanity
+ * of the current arg strings (which is directly set by the caller).
+ * After the first arg string is successfully appended to the command
+ * string, the optional @operator is appended, followed by the second
+ * arg and and optional @separator.  If no separator was specified
+ * when initializing the arg, a space will be appended.
+ */
+void dynevent_arg_pair_init(struct dynevent_arg_pair *arg_pair,
+			    dynevent_check_arg_fn_t check_arg,
+			    char operator, char separator)
+{
+	memset(arg_pair, '\0', sizeof(*arg_pair));
+
+	if (!operator)
+		operator = ' ';
+	arg_pair->operator = operator;
+
+	if (!separator)
+		separator = ' ';
+	arg_pair->separator = separator;
+
+	arg_pair->check_arg = check_arg;
+}
+
+/**
+ * dynevent_create - Create the dynamic event contained in dynevent_cmd
+ * @cmd: The dynevent_cmd object containing the dynamic event creation command
+ *
+ * Once a dynevent_cmd object has been successfully built up via the
+ * dynevent_cmd_init(), dynevent_arg_add() and dynevent_arg_pair_add()
+ * functions, this function runs the final command to actually create
+ * the event.
+ *
+ * Return: 0 if the event was successfully created, error otherwise.
+ */
+int dynevent_create(struct dynevent_cmd *cmd)
+{
+	return cmd->run_command(cmd);
+}
+EXPORT_SYMBOL_GPL(dynevent_create);
diff --git a/kernel/trace/trace_dynevent.h b/kernel/trace/trace_dynevent.h
index 46898138d2df..b593fc34c5b1 100644
--- a/kernel/trace/trace_dynevent.h
+++ b/kernel/trace/trace_dynevent.h
@@ -117,4 +117,37 @@ int dyn_event_release(int argc, char **argv, struct dyn_event_operations *type);
 #define for_each_dyn_event_safe(pos, n)	\
 	list_for_each_entry_safe(pos, n, &dyn_event_list, list)
 
+extern void dynevent_cmd_init(struct dynevent_cmd *cmd, char *buf, int maxlen,
+			      enum dynevent_type type,
+			      dynevent_create_fn_t run_command);
+
+typedef int (*dynevent_check_arg_fn_t)(void *data);
+
+struct dynevent_arg {
+	const char		*str;
+	char			separator; /* e.g. ';', ',', or nothing */
+	dynevent_check_arg_fn_t	check_arg;
+};
+
+extern void dynevent_arg_init(struct dynevent_arg *arg,
+			      dynevent_check_arg_fn_t check_arg,
+			      char separator);
+extern int dynevent_arg_add(struct dynevent_cmd *cmd,
+			    struct dynevent_arg *arg);
+
+struct dynevent_arg_pair {
+	const char		*lhs;
+	const char		*rhs;
+	char			operator; /* e.g. '=' or nothing */
+	char			separator; /* e.g. ';', ',', or nothing */
+	dynevent_check_arg_fn_t	check_arg;
+};
+
+extern void dynevent_arg_pair_init(struct dynevent_arg_pair *arg_pair,
+				   dynevent_check_arg_fn_t check_arg,
+				   char operator, char separator);
+extern int dynevent_arg_pair_add(struct dynevent_cmd *cmd,
+				 struct dynevent_arg_pair *arg_pair);
+extern int dynevent_str_add(struct dynevent_cmd *cmd, const char *str);
+
 #endif
-- 
2.24.1


