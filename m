Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B851013B3F6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 22:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgANVEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 16:04:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:51052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728874AbgANVDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:03:43 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA3282468B;
        Tue, 14 Jan 2020 21:03:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1irTLf-000DCY-Jt; Tue, 14 Jan 2020 16:03:39 -0500
Message-Id: <20200114210339.492724604@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 14 Jan 2020 16:03:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 26/26] tracing: trigger: Replace unneeded RCU-list traversals
References: <20200114210316.450821675@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

With CONFIG_PROVE_RCU_LIST, I had many suspicious RCU warnings
when I ran ftracetest trigger testcases.

-----
  # dmesg -c > /dev/null
  # ./ftracetest test.d/trigger
  ...
  # dmesg | grep "RCU-list traversed" | cut -f 2 -d ] | cut -f 2 -d " "
  kernel/trace/trace_events_hist.c:6070
  kernel/trace/trace_events_hist.c:1760
  kernel/trace/trace_events_hist.c:5911
  kernel/trace/trace_events_trigger.c:504
  kernel/trace/trace_events_hist.c:1810
  kernel/trace/trace_events_hist.c:3158
  kernel/trace/trace_events_hist.c:3105
  kernel/trace/trace_events_hist.c:5518
  kernel/trace/trace_events_hist.c:5998
  kernel/trace/trace_events_hist.c:6019
  kernel/trace/trace_events_hist.c:6044
  kernel/trace/trace_events_trigger.c:1500
  kernel/trace/trace_events_trigger.c:1540
  kernel/trace/trace_events_trigger.c:539
  kernel/trace/trace_events_trigger.c:584
-----

I investigated those warnings and found that the RCU-list
traversals in event trigger and hist didn't need to use
RCU version because those were called only under event_mutex.

I also checked other RCU-list traversals related to event
trigger list, and found that most of them were called from
event_hist_trigger_func() or hist_unregister_trigger() or
register/unregister functions except for a few cases.

Replace these unneeded RCU-list traversals with normal list
traversal macro and lockdep_assert_held() to check the
event_mutex is held.

Link: http://lkml.kernel.org/r/157680910305.11685.15110237954275915782.stgit@devnote2

Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c    | 41 +++++++++++++++++++++--------
 kernel/trace/trace_events_trigger.c | 20 ++++++++++----
 2 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 8e90f1ada437..117a1202a6b9 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1771,11 +1771,13 @@ static struct hist_field *find_var(struct hist_trigger_data *hist_data,
 	struct event_trigger_data *test;
 	struct hist_field *hist_field;
 
+	lockdep_assert_held(&event_mutex);
+
 	hist_field = find_var_field(hist_data, var_name);
 	if (hist_field)
 		return hist_field;
 
-	list_for_each_entry_rcu(test, &file->triggers, list) {
+	list_for_each_entry(test, &file->triggers, list) {
 		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
 			test_data = test->private_data;
 			hist_field = find_var_field(test_data, var_name);
@@ -1825,7 +1827,9 @@ static struct hist_field *find_file_var(struct trace_event_file *file,
 	struct event_trigger_data *test;
 	struct hist_field *hist_field;
 
-	list_for_each_entry_rcu(test, &file->triggers, list) {
+	lockdep_assert_held(&event_mutex);
+
+	list_for_each_entry(test, &file->triggers, list) {
 		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
 			test_data = test->private_data;
 			hist_field = find_var_field(test_data, var_name);
@@ -3120,7 +3124,9 @@ static char *find_trigger_filter(struct hist_trigger_data *hist_data,
 {
 	struct event_trigger_data *test;
 
-	list_for_each_entry_rcu(test, &file->triggers, list) {
+	lockdep_assert_held(&event_mutex);
+
+	list_for_each_entry(test, &file->triggers, list) {
 		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
 			if (test->private_data == hist_data)
 				return test->filter_str;
@@ -3171,9 +3177,11 @@ find_compatible_hist(struct hist_trigger_data *target_hist_data,
 	struct event_trigger_data *test;
 	unsigned int n_keys;
 
+	lockdep_assert_held(&event_mutex);
+
 	n_keys = target_hist_data->n_fields - target_hist_data->n_vals;
 
-	list_for_each_entry_rcu(test, &file->triggers, list) {
+	list_for_each_entry(test, &file->triggers, list) {
 		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
 			hist_data = test->private_data;
 
@@ -5536,7 +5544,7 @@ static int hist_show(struct seq_file *m, void *v)
 		goto out_unlock;
 	}
 
-	list_for_each_entry_rcu(data, &event_file->triggers, list) {
+	list_for_each_entry(data, &event_file->triggers, list) {
 		if (data->cmd_ops->trigger_type == ETT_EVENT_HIST)
 			hist_trigger_show(m, data, n++);
 	}
@@ -5929,7 +5937,9 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 	if (hist_data->attrs->name && !named_data)
 		goto new;
 
-	list_for_each_entry_rcu(test, &file->triggers, list) {
+	lockdep_assert_held(&event_mutex);
+
+	list_for_each_entry(test, &file->triggers, list) {
 		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
 			if (!hist_trigger_match(data, test, named_data, false))
 				continue;
@@ -6013,10 +6023,12 @@ static bool have_hist_trigger_match(struct event_trigger_data *data,
 	struct event_trigger_data *test, *named_data = NULL;
 	bool match = false;
 
+	lockdep_assert_held(&event_mutex);
+
 	if (hist_data->attrs->name)
 		named_data = find_named_trigger(hist_data->attrs->name);
 
-	list_for_each_entry_rcu(test, &file->triggers, list) {
+	list_for_each_entry(test, &file->triggers, list) {
 		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
 			if (hist_trigger_match(data, test, named_data, false)) {
 				match = true;
@@ -6034,10 +6046,12 @@ static bool hist_trigger_check_refs(struct event_trigger_data *data,
 	struct hist_trigger_data *hist_data = data->private_data;
 	struct event_trigger_data *test, *named_data = NULL;
 
+	lockdep_assert_held(&event_mutex);
+
 	if (hist_data->attrs->name)
 		named_data = find_named_trigger(hist_data->attrs->name);
 
-	list_for_each_entry_rcu(test, &file->triggers, list) {
+	list_for_each_entry(test, &file->triggers, list) {
 		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
 			if (!hist_trigger_match(data, test, named_data, false))
 				continue;
@@ -6059,10 +6073,12 @@ static void hist_unregister_trigger(char *glob, struct event_trigger_ops *ops,
 	struct event_trigger_data *test, *named_data = NULL;
 	bool unregistered = false;
 
+	lockdep_assert_held(&event_mutex);
+
 	if (hist_data->attrs->name)
 		named_data = find_named_trigger(hist_data->attrs->name);
 
-	list_for_each_entry_rcu(test, &file->triggers, list) {
+	list_for_each_entry(test, &file->triggers, list) {
 		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
 			if (!hist_trigger_match(data, test, named_data, false))
 				continue;
@@ -6088,7 +6104,9 @@ static bool hist_file_check_refs(struct trace_event_file *file)
 	struct hist_trigger_data *hist_data;
 	struct event_trigger_data *test;
 
-	list_for_each_entry_rcu(test, &file->triggers, list) {
+	lockdep_assert_held(&event_mutex);
+
+	list_for_each_entry(test, &file->triggers, list) {
 		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
 			hist_data = test->private_data;
 			if (check_var_refs(hist_data))
@@ -6331,7 +6349,8 @@ hist_enable_trigger(struct event_trigger_data *data, void *rec,
 	struct enable_trigger_data *enable_data = data->private_data;
 	struct event_trigger_data *test;
 
-	list_for_each_entry_rcu(test, &enable_data->file->triggers, list) {
+	list_for_each_entry_rcu(test, &enable_data->file->triggers, list,
+				lockdep_is_held(&event_mutex)) {
 		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
 			if (enable_data->enable)
 				test->paused = false;
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index d8ada4c6f3f7..60959c31791d 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -501,7 +501,9 @@ void update_cond_flag(struct trace_event_file *file)
 	struct event_trigger_data *data;
 	bool set_cond = false;
 
-	list_for_each_entry_rcu(data, &file->triggers, list) {
+	lockdep_assert_held(&event_mutex);
+
+	list_for_each_entry(data, &file->triggers, list) {
 		if (data->filter || event_command_post_trigger(data->cmd_ops) ||
 		    event_command_needs_rec(data->cmd_ops)) {
 			set_cond = true;
@@ -536,7 +538,9 @@ static int register_trigger(char *glob, struct event_trigger_ops *ops,
 	struct event_trigger_data *test;
 	int ret = 0;
 
-	list_for_each_entry_rcu(test, &file->triggers, list) {
+	lockdep_assert_held(&event_mutex);
+
+	list_for_each_entry(test, &file->triggers, list) {
 		if (test->cmd_ops->trigger_type == data->cmd_ops->trigger_type) {
 			ret = -EEXIST;
 			goto out;
@@ -581,7 +585,9 @@ static void unregister_trigger(char *glob, struct event_trigger_ops *ops,
 	struct event_trigger_data *data;
 	bool unregistered = false;
 
-	list_for_each_entry_rcu(data, &file->triggers, list) {
+	lockdep_assert_held(&event_mutex);
+
+	list_for_each_entry(data, &file->triggers, list) {
 		if (data->cmd_ops->trigger_type == test->cmd_ops->trigger_type) {
 			unregistered = true;
 			list_del_rcu(&data->list);
@@ -1497,7 +1503,9 @@ int event_enable_register_trigger(char *glob,
 	struct event_trigger_data *test;
 	int ret = 0;
 
-	list_for_each_entry_rcu(test, &file->triggers, list) {
+	lockdep_assert_held(&event_mutex);
+
+	list_for_each_entry(test, &file->triggers, list) {
 		test_enable_data = test->private_data;
 		if (test_enable_data &&
 		    (test->cmd_ops->trigger_type ==
@@ -1537,7 +1545,9 @@ void event_enable_unregister_trigger(char *glob,
 	struct event_trigger_data *data;
 	bool unregistered = false;
 
-	list_for_each_entry_rcu(data, &file->triggers, list) {
+	lockdep_assert_held(&event_mutex);
+
+	list_for_each_entry(data, &file->triggers, list) {
 		enable_data = data->private_data;
 		if (enable_data &&
 		    (data->cmd_ops->trigger_type ==
-- 
2.24.1


