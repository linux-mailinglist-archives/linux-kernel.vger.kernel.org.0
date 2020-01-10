Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0F711377FF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 21:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgAJUfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 15:35:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:58724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727361AbgAJUfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 15:35:43 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78DC124125;
        Fri, 10 Jan 2020 20:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578688542;
        bh=loElwpRIkzmxhCypl2r7nv5SV9Ki/Qj7Kub47ovlmLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=N1T1Zrnr5n19YvVZQbE4hGUW/TQIEHrx1OonvTh3zFqcpKPjdu9qVMvkuypDa6BaT
         SBQQalInXuXtBlQjqDXvikxXofLzq8UstIZjee1g5GZnWlcY3TiYiooVbPk5nd8a4T
         Nu7b7jZS/diIljw89DoYsND1GJUKFRQehlGzJRpY=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v2 12/12] tracing: Documentation for in-kernel synthetic event API
Date:   Fri, 10 Jan 2020 14:35:18 -0600
Message-Id: <91ee64186d5894724e276c4e7fad70446d7a02a7.1578688120.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1578688120.git.zanussi@kernel.org>
References: <cover.1578688120.git.zanussi@kernel.org>
In-Reply-To: <cover.1578688120.git.zanussi@kernel.org>
References: <cover.1578688120.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Documentation for creating and generating synthetic events from
modules.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 Documentation/trace/events.rst | 488 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 488 insertions(+)

diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index f7e1fcc0953c..20f9fc6690db 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -525,3 +525,491 @@ The following commands are supported:
   event counts (hitcount).
 
   See Documentation/trace/histogram.rst for details and examples.
+
+6.3 In-kernel trace event API
+-----------------------------
+
+In most cases, the command-line interface to trace events is more than
+sufficient.  Sometimes, however, applications might find the need for
+more complex relationships than can be expressed through a simple
+series of linked command-line expressions, or putting together sets of
+commands may be simply too cumbersome.  An example might be an
+application that needs to 'listen' to the trace stream in order to
+maintain an in-kernel state machine detecting, for instance, when an
+illegal kernel state occurs in the scheduler.
+
+The trace event subsystem provides an in-kernel API allowing modules
+or other kernel code to generate user-defined 'synthetic' events at
+will, which can be used to either augment the existing trace stream
+and/or signal that a particular important state has occurred.
+
+A similar in-kernel API is also available for creating kprobe and
+kretprobe events.
+
+Both the synthetic event and k/ret/probe event APIs are built on top
+of a lower-level "dynevent_cmd" event command API, which is also
+available for more specialized applications, or as the basis of other
+higher-level trace event APIs.
+
+The API provided for these purposes is describe below and allows the
+following:
+
+  - dynamically creating synthetic event definitions
+  - dynamically creating kprobe and kretprobe event definitions
+  - tracing synthetic events from in-kernel code
+  - the low-level "dynevent_cmd" API
+
+6.3.1 Dyamically creating synthetic event definitions
+-----------------------------------------------------
+
+There are a couple ways to create a new synthetic event from a kernel
+module or other kernel code.
+
+The first creates the event in one step, using create_synth_event().
+In this method, the name of the event to create and an array defining
+the fields is supplied to create_synth_event().  If successful, a
+synthetic event with that name and fields will exist following that
+call.  For example, to create a new "schedtest" synthetic event:
+
+  ret = create_synth_event("schedtest", sched_fields,
+                           ARRAY_SIZE(sched_fields), THIS_MODULE);
+
+The sched_fields param in this example points to an array of struct
+synth_field_desc, each of which describes an event field by type and
+name:
+
+  static struct synth_field_desc sched_fields[] = {
+        { .type = "pid_t",              .name = "next_pid_field" },
+        { .type = "char[16]",           .name = "next_comm_field" },
+        { .type = "u64",                .name = "ts_ns" },
+        { .type = "u64",                .name = "ts_ms" },
+        { .type = "unsigned int",       .name = "cpu" },
+        { .type = "char[64]",           .name = "my_string_field" },
+        { .type = "int",                .name = "my_int_field" },
+  };
+
+See synth_field_size() for available types. If field_name contains [n]
+the field is considered to be an array.
+
+If the event is created from within a module, a pointer to the module
+must be passed to create_synth_event().  This will ensure that the
+trace buffer won't contain unreadable events when the module is
+removed.
+
+At this point, the event object is ready to be used for generating new
+events.
+
+In the second method, the event is created in several steps.  This
+allows events to be created dynamically and without the need to create
+and populate an array of fields beforehand.
+
+To use this method, an empty or partially empty synthetic event should
+first be created using gen_synth_cmd().  The name of the event along
+with one or more pairs of args each pair representing a 'type
+field_name;' field specification should be supplied to this function.
+Before calling gen_synth_cmd(), the user should create and initialize
+a dynevent_cmd object using synth_dynevent_cmd_init().
+
+For example, to create a new "schedtest" synthetic event with two
+fields:
+
+  struct dynevent_cmd cmd;
+  char *buf;
+
+  /* Create a buffer to hold the generated command */
+  buf = kzalloc(MAX_DYNEVENT_CMD_LEN, GFP_KERNEL);
+
+  /* Before generating the command, initialize the cmd object */
+  synth_dynevent_cmd_init(&cmd, buf, MAX_DYNEVENT_CMD_LEN);
+
+  ret = gen_synth_cmd(&cmd, "schedtest", THIS_MODULE,
+                     "pid_t", "next_pid_field",
+                     "u64", "ts_ns");
+
+Once the synthetic event object has been created, it can then be
+populated with more fields.  Fields are added one by one using
+add_synth_field(), supplying the dynevent_cmd object, a field type,
+and a field name.  For example, to add a new int field named
+"intfield", the following call should be made:
+
+  ret = add_synth_field(&cmd, "int", "intfield");
+
+See synth_field_size() for available types. If field_name contains [n]
+the field is considered to be an array.
+
+A group of fields can also be added all at once using an array of
+synth_field_desc with add_synth_fields().  For example, this would add
+just the first four sched_fields:
+
+  ret = add_synth_fields(&cmd, sched_fields, 4);
+
+Once all the fields have been added, the event should be finalized and
+registered by calling the create_dynevent() function:
+
+  ret = create_dynevent(&cmd);
+
+At this point, the event object is ready to be used for tracing new
+events.
+
+6.3.3 Tracing synthetic events from in-kernel code
+--------------------------------------------------
+
+To trace a synthetic event, there are several options.  The first
+option is to trace the event in one call, using trace_synth_event()
+with a variable number of values, or trace_synth_event_array() with an
+array of values to be set.  A second option can be used to avoid the
+need for a pre-formed array of values or list of arguments, via
+trace_synth_event_start() and trace_synth_event_end() along with
+add_next_synth_val() or add_synth_val() to add the values piecewise.
+
+6.3.3.1 Tracing a synthetic event all at once
+---------------------------------------------
+
+To trace a synthetic event all at once, the trace_synth_event() or
+trace_synth_event_array() functions can be used.
+
+The trace_synth_event() function is passed the trace_event_file
+representing the synthetic event (which can be retrieved using
+get_event_file() using the synthetic event name, "synthetic" as the
+system name, and the trace instance name (NULL if using the global
+trace array)), along with an variable number of u64 args, one for each
+synthetic event field, and the number of values being passed.
+
+So, to generate an event corresponding to the synthetic event
+definition above, code like the following could be used:
+
+  ret = trace_synth_event(create_synth_test, 7, /* number of values */
+                          444,             /* next_pid_field */
+                          (u64)"clackers", /* next_comm_field */
+                          1000000,         /* ts_ns */
+                          1000,            /* ts_ms */
+                          smp_processor_id(),/* cpu */
+                          (u64)"Thneed",   /* my_string_field */
+                          999);            /* my_int_field */
+
+All vals should be cast to u64, and string vals are just pointers to
+strings, cast to u64.  Strings will be copied into space reserved in
+the event for the string, using these pointers.
+
+Alternatively, the trace_synth_event_array() function can be used to
+accomplish the same thing.  It is passed the trace_event_file
+representing the synthetic event (which can be retrieved using
+get_event_file() using the synthetic event name, "synthetic" as the
+system name, and the trace instance name (NULL if using the global
+trace array)), along with an array of u64, one for each synthetic
+event field.
+
+Tto generate an event corresponding to the synthetic event definition
+above, code like the following could be used:
+
+  u64 vals[7];
+
+  vals[0] = 777;                  /* next_pid_field */
+  vals[1] = (u64)"tiddlywinks";   /* next_comm_field */
+  vals[2] = 1000000;              /* ts_ns */
+  vals[3] = 1000;                 /* ts_ms */
+  vals[4] = smp_processor_id();   /* cpu */
+  vals[5] = (u64)"thneed";        /* my_string_field */
+  vals[6] = 398;                  /* my_int_field */
+
+The 'vals' array is just an array of u64, the number of which must
+match the number of field in the synthetic event, and which must be in
+the same order as the synthetic event fields.
+
+All vals should be cast to u64, and string vals are just pointers to
+strings, cast to u64.  Strings will be copied into space reserved in
+the event for the string, using these pointers.
+
+In order to generate a synthetic event, a pointer to the trace event
+file is needed.  The get_event_file() function can be used to get it -
+it will find the file in the given trace instance (in this case NULL
+since the top trace array is being used) while at the same time
+preventing the instance containing it from going away:
+
+       schedtest_event_file = get_event_file(NULL, "synthetic",
+                                             "schedtest");
+
+Before generating the event, it should be enabled in some way,
+otherwise the synthetic event won't actually show up in the trace
+buffer.
+
+To enable a synthetic event from the kernel, trace_array_set_clr_event()
+can be used (which is not specific to synthetic events, so does need
+the "synthetic" system name to be specified explicitly).
+
+To enable the event, pass 'true' to it:
+
+       trace_array_set_clr_event(schedtest_event_file->tr,
+                                 "synthetic", "schedtest", true);
+
+To disable it pass false:
+
+       trace_array_set_clr_event(schedtest_event_file->tr,
+                                 "synthetic", "schedtest", false);
+
+Finally, trace_synth_event_array() can be used to actually trace the
+event, which should be visible in the trace buffer afterwards:
+
+       ret = trace_synth_event_array(schedtest_event_file, vals,
+                                     ARRAY_SIZE(vals));
+
+To remove the synthetic event, the event should be disabled, and the
+trace instance should be 'put' back using put_event_file():
+
+       trace_array_set_clr_event(schedtest_event_file->tr,
+                                 "synthetic", "schedtest", false);
+       put_event_file(schedtest_event_file);
+
+If those have been successful, delete_synth_event() can be called to
+remove the event:
+
+       ret = delete_synth_event("schedtest");
+
+6.3.3.1 Tracing a synthetic event piecewise
+-------------------------------------------
+
+To trace a synthetic using the piecewise method described above, the
+trace_synth_event_start() function is used to 'open' the synthetic
+event trace:
+
+       struct synth_gen_state gen_state;
+
+       ret = trace_synth_event_start(schedtest_event_file, &gen_state);
+
+It's passed the trace_event_file representing the synthetic event
+using the same methods as described above, along with a pointer to a
+struct synth_gen_state object, which will be zeroed before use and
+used to maintain state between this and following calls.
+
+Once the event has been opened, which means space for it has been
+reserved in the trace buffer, the individual fields can be set.  There
+are two ways to do that, either one after another for each field in
+the event, which requires no lookups, or by name, which does.  The
+tradeoff is flexibility in doing the assignments vs the cost of a
+lookup per field.
+
+To assign the values one after the other without lookups,
+add_next_synth_val() should be used.  Each call is passed the same
+synth_gen_state object used in the trace_synth_event_start(), along
+with the value to set the next field in the event.  After each field
+is set, the 'cursor' points to the next field, which will be set by
+the subsequent call, continuing until all the fields have been set in
+order.  The same sequence of calls as in the above examples using this
+method would be (without error-handling code):
+
+       /* next_pid_field */
+       ret = add_next_synth_val(777, &gen_state);
+
+       /* next_comm_field */
+       ret = add_next_synth_val((u64)"slinky", &gen_state);
+
+       /* ts_ns */
+       ret = add_next_synth_val(1000000, &gen_state);
+
+       /* ts_ms */
+       ret = add_next_synth_val(1000, &gen_state);
+
+       /* cpu */
+       ret = add_next_synth_val(smp_processor_id(), &gen_state);
+
+       /* my_string_field */
+       ret = add_next_synth_val((u64)"thneed_2.01", &gen_state);
+
+       /* my_int_field */
+       ret = add_next_synth_val(395, &gen_state);
+
+To assign the values in any order, add_synth_val() should be used.
+Each call is passed the same synth_gen_state object used in the
+generate_synth_event_start(), along with the field name of the field
+to set and the value to set it to.  The same sequence of calls as in
+the above examples using this method would be (without error-handling
+code):
+
+       ret = add_synth_val("next_pid_field", 777, &gen_state);
+       ret = add_synth_val("next_comm_field", (u64)"silly putty", &gen_state);
+       ret = add_synth_val("ts_ns", 1000000, &gen_state);
+       ret = add_synth_val("ts_ms", 1000, &gen_state);
+       ret = add_synth_val("cpu", smp_processor_id(), &gen_state);
+       ret = add_synth_val("my_string_field", (u64)"thneed_9", &gen_state);
+       ret = add_synth_val("my_int_field", 3999, &gen_state);
+
+Note that add_next_synth_val() and add_synth_val() are incompatible if
+used within the same generation of an event - either one can be used
+but not both at the same time.
+
+Finally, the event won't be actually traced until it's 'closed',
+which is done using trace_synth_event_end(), which takes only the
+struct synth_gen_state object used in the previous calls:
+
+       ret = trace_synth_event_end(&gen_state);
+
+Note that trace_synth_event_end() must be called at the end regardless
+of whether any of the add calls failed (say due to a bad field name
+being passed in).
+
+6.3.4 Dyamically creating kprobe and kretprobe event definitions
+----------------------------------------------------------------
+
+To create a kprobe or kretprobe trace event from kernel code, the
+gen_kprobe_cmd() or gen_kretprobe() functions can be used.
+
+To create a kprobe event, an empty or partially empty kprobe event
+should first be created using gen_kprobe_cmd().  The name of the event
+and the probe location should be specfied along with one or args each
+representing a probe field should be supplied to this function.
+Before calling gen_kprobe_cmd(), the user should create and initialize
+a dynevent_cmd object using kprobe_dynevent_cmd_init().
+
+For example, to create a new "schedtest" synthetic event with two
+fields:
+
+  struct dynevent_cmd cmd;
+  char *buf;
+
+  /* Create a buffer to hold the generated command */
+  buf = kzalloc(MAX_DYNEVENT_CMD_LEN, GFP_KERNEL);
+
+  /* Before generating the command, initialize the cmd object */
+  kpobe_dynevent_cmd_init(&cmd, buf, MAX_DYNEVENT_CMD_LEN);
+
+  /*
+   * Define the gen_kprobe_test event with the first 2 kprobe
+   * fields.
+   */
+  ret = gen_kprobe_cmd(&cmd, "gen_kprobe_test", "do_sys_open",
+                       "dfd=%ax", "filename=%dx");
+
+Once the kprobe event object has been created, it can then be
+populated with more fields.  Fields can be added using
+add_probe_fields(), supplying the dynevent_cmd object along with a
+variable arg list of probe fields.  For example, to add a couple
+additional fields, the following call could be made:
+
+  ret = add_probe_fields(&cmd, "flags=%cx", "mode=+4($stack)");
+
+Once all the fields have been added, the event should be finalized and
+registered by calling the create_dynevent() function:
+
+  ret = create_dynevent(&cmd);
+
+At this point, the event object is ready to be used for tracing new
+events.
+
+Similarly, a kretprobe event can be created using gen_kretprobe_cmd()
+with a probe name and location and additional params such as $retval:
+
+  ret = gen_kretprobe_cmd(&cmd, "gen_kretprobe_test", "do_sys_open",
+                          "$retval");
+
+Similar to the synthetic event case, code like the following can be
+used to enable the newly created kprobe event:
+
+  gen_kprobe_test = get_event_file(NULL, "kprobes", "gen_kprobe_test");
+
+  ret = trace_array_set_clr_event(gen_kprobe_test->tr,
+                                  "kprobes", "gen_kprobe_test", true);
+
+Finally, also similar to synthetic events, the following code can be
+used to give the kprobe event file back and delete the event:
+
+  put_event_file(gen_kprobe_test);
+
+ret = delete_kprobe_event("gen_kprobe_test");
+
+6.3.4 The "dynevent_cmd" low-level API
+--------------------------------------
+
+Both the in-kernel synthetic event and kprobe interfaces are built on
+top of a lower-level "dynevent_cmd" interface.  This interface can
+also be used on its own by modules and other kernel code, but it's
+generally meant to be used as the basis for higher-level interfaces
+such as the synthetic and kprobe interfaces, which can be used as
+examples.
+
+The basic idea is simple - it's meant to be used to generate trace
+event commands that can then be passed to the command-parsing and
+event creation code that already exists to create the corresponding
+trace events.
+
+In a nutshell, the way it works is that the user creates a struct
+dynevent_cmd object, then uses a couple functions, add_dynevent_arg()
+and add_dynevent_arg_pair() to build up a command string, then finally
+causes the command to be executed using the create_dynevent()
+function.  The details of the interface are described below.
+
+The first step in building a new command string is to create and
+initialize an instance of a dynevent_cmd.  Here, for instance, we
+create a dynevent_cmd on the stack and initialize it:
+
+  struct dynevent_cmd cmd;
+  char *buf;
+  int ret;
+
+  buf = kzalloc(MAX_DYNEVENT_CMD_LEN, GFP_KERNEL);
+
+  dynevent_cmd_init(cmd, buf, maxlen, DYNEVENT_TYPE_FOO,
+                    foo_event_run_command);
+
+The dynevent_cmd initialization needs to be given a user-specified
+buffer and the length of the buffer (MAX_DYNEVENT_CMD_LEN can be used
+for this purpose - at 2k it's generally too big to be comfortably put
+on the stack, so is dynamically allocated), a dynevent type id, which
+is meant to be used to check that further API calls are for the
+correct command type, and a pointer to an event-specific run_command()
+callback that will be called to actually execute the event-specific
+command function.
+
+Once that's done, the command string can by built up by successive
+calls to argument-adding functions.
+
+To add a single argument, define and initialize a struct dynevent_arg
+or struct dynevent_arg_pair object.  Here's an example of the simplest
+possible arg addition, which is simply to append the given string as
+a whitespace-separated argument to the command:
+
+  struct dynevent_arg arg;
+
+  dynevent_arg_init(&arg, NULL, 0);
+
+  arg.str = name;
+
+  ret = add_dynevent_arg(cmd, &arg);
+
+The arg object is first initialized using dynevent_arg_init() and in
+this case the parameters are NULL or 0, which means there's no
+optional sanity-checking function or separator appended to the end of
+the arg.
+
+Here's another more complicated example using an 'arg pair', which is
+used to create an argument that consists of a couple components added
+together as a unit, for example, a 'type field_name;' arg or a simple
+expression arg e.g. 'flags=%cx':
+
+  struct dynevent_arg_pair arg_pair;
+
+  dynevent_arg_pair_init(&arg_pair, dynevent_foo_check_arg_fn, 0, ';');
+
+  arg_pair.lhs = type;
+  arg_pair.rhs = name;
+
+  ret = add_dynevent_arg_pair(cmd, &arg_pair);
+
+Again, the arg_pair is first initialized, in this case with a callback
+function used to check the sanity of the args (for example, that
+neither part of the pair is NULL), along with a character to be used
+to add an operator between the pair (here none) and a separator to be
+appended onto the end of the arg pair (here ';').
+
+Any number of dynevent_add_* calls can be made to build up the string
+(until its length surpasses cmd->maxlen).  When all the arguments have
+been added and the command string is complete, the only thing left to
+do is run the command, which happens by simply calling
+create_dynevent():
+
+  ret = create_dynevent(&cmd);
+
+At that point, if the return value is 0, the dynamic event has been
+created and is ready to use.
+
+See the dynevent_cmd function definitions themselves for the details
+of the API.
-- 
2.14.1

