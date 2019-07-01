Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 051E8239C7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 16:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731561AbfETOWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 10:22:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:48868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388903AbfETOWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:22:00 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ED1521851;
        Mon, 20 May 2019 14:21:59 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hSjAs-0003UC-KK; Mon, 20 May 2019 10:21:58 -0400
Message-Id: <20190520142158.515655871@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 20 May 2019 10:20:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Frank Ch. Eigler" <fche@redhat.com>
Subject: [RFC][PATCH 13/14 v2] function_graph: Implement fgraph_reserve_data() and
 fgraph_retrieve_data()
References: <20190520142001.270067280@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Added functions that can be called by a fgraph_ops entryfunc and retfunc to
store state between the entry of the function being traced to the exit of
the same function. The fgraph_ops entryfunc() may call fgraph_reserve_data()
to store up to 4 words onto the task's shadow ret_stack and this then can be
retrived by fgraph_retrieve_data() called by the corresponding retfunc().

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h |   3 +
 kernel/trace/fgraph.c  | 244 +++++++++++++++++++++++++++++++++++------
 2 files changed, 213 insertions(+), 34 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index a0bdd1745e56..5b252dc9c1e6 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -757,6 +757,9 @@ struct fgraph_ops {
 	int				idx;
 };
 
+void *fgraph_reserve_data(int size_bytes);
+void *fgraph_retrieve_data(void);
+
 /*
  * Stack of return addresses for functions
  * of a thread.
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index c225b04bcd00..f087a46fa473 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -36,25 +36,36 @@
  * bits: 14 - 15	Type of storage
  *			  0 - reserved
  *			  1 - fgraph_array index
+ *			  2 - reservered data
  * For fgraph_array_index:
  *  bits: 16 - 23	The fgraph_ops fgraph_array index
  *
+ * For reserved data:
+ *  bits: 16 - 17	The size in words that is stored
+ *
  * That is, at the end of function_graph_enter, if the first and forth
  * fgraph_ops on the fgraph_array[] (index 0 and 3) needs their retfunc called
- * on the return of the function being traced, this is what will be on the
- * task's shadow ret_stack: (the stack grows upward)
+ * on the return of the function being traced, and the forth fgraph_ops
+ * stored two words of data, this is what will be on the task's shadow
+ * ret_stack: (the stack grows upward)
+ *
+ * |                                     | <- task->curr_ret_stack
+ * +-------------------------------------+
+ * | (3 << FGRAPH_ARRAY_SHIFT)|type:1|(5)| ( 3 for index of fourth fgraph_ops)
+ * +-------------------------------------+
+ * | (3 << FGRAPH_DATA_SHIFT)|type:2|(4) | ( Data with size of 2 words)
+ * +-------------------------------------+ ( It is 4 words from the ret_stack)
+ * |         STORED DATA WORD 2          |
+ * |         STORED DATA WORD 1          |
+ * +-------------------------------------+
+ * | (0 << FGRAPH_ARRAY_SHIFT)|type:1|(1)| ( 0 for index of first fgraph_ops)
+ * +-------------------------------------+
+ * | struct ftrace_ret_stack             |
+ * |   (stores the saved ret pointer)    |
+ * +-------------------------------------+
+ * |             (X) | (N)               | ( N words away from last ret_stack)
+ * |                                     |
  *
- * |                                  | <- task->curr_ret_stack
- * +----------------------------------+
- * | (3 << FGRAPH_ARRAY_SHIFT)|(2)    | ( 3 for index of fourth fgraph_ops)
- * +----------------------------------+
- * | (0 << FGRAPH_ARRAY_SHIFT)|(1)    | ( 0 for index of first fgraph_ops)
- * +----------------------------------+
- * | struct ftrace_ret_stack          |
- * |   (stores the saved ret pointer) |
- * +----------------------------------+
- * |             (X) | (N)            | ( N words away from previous ret_stack)
- * |                                  |
  *
  * If a backtrace is required, and the real return pointer needs to be
  * fetched, then it looks at the task's curr_ret_stack index, if it
@@ -75,12 +86,17 @@
 enum {
 	FGRAPH_TYPE_RESERVED	= 0,
 	FGRAPH_TYPE_ARRAY	= 1,
+	FGRAPH_TYPE_DATA	= 2,
 };
 
 #define FGRAPH_ARRAY_SIZE	16
 #define FGRAPH_ARRAY_MASK	((1 << FGRAPH_ARRAY_SIZE) - 1)
 #define FGRAPH_ARRAY_SHIFT	(FGRAPH_TYPE_SHIFT + FGRAPH_TYPE_SIZE)
 
+#define FGRAPH_DATA_SIZE	2
+#define FGRAPH_DATA_MASK	((1 << FGRAPH_DATA_SIZE) - 1)
+#define FGRAPH_DATA_SHIFT	(FGRAPH_TYPE_SHIFT + FGRAPH_TYPE_SIZE)
+
 /* Currently the max stack index can't be more than register callers */
 #define FGRAPH_MAX_INDEX	FGRAPH_ARRAY_SIZE
 
@@ -96,6 +112,8 @@ enum {
 
 #define RET_STACK(t, index) ((struct ftrace_ret_stack *)(&(t)->ret_stack[index]))
 
+#define FGRAPH_MAX_DATA_SIZE (sizeof(long) * 4)
+
 /*
  * Each fgraph_ops has a reservered unsigned long at the end (top) of the
  * ret_stack to store task specific state.
@@ -110,21 +128,44 @@ static int fgraph_array_cnt;
 
 static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
 
+static inline int __get_index(unsigned long val)
+{
+	return val & FGRAPH_RET_INDEX_MASK;
+}
+
+static inline int __get_type(unsigned long val)
+{
+	return (val >> FGRAPH_TYPE_SHIFT) & FGRAPH_TYPE_MASK;
+}
+
+static inline int __get_array(unsigned long val)
+{
+	return (val >> FGRAPH_ARRAY_SHIFT) & FGRAPH_ARRAY_MASK;
+}
+
+static inline int __get_data(unsigned long val)
+{
+	return (val >> FGRAPH_DATA_SHIFT) & FGRAPH_DATA_MASK;
+}
+
 static inline int get_ret_stack_index(struct task_struct *t, int offset)
 {
-	return current->ret_stack[offset] & FGRAPH_RET_INDEX_MASK;
+	return __get_index(current->ret_stack[offset]);
 }
 
 static inline int get_fgraph_type(struct task_struct *t, int offset)
 {
-	return (current->ret_stack[offset] >> FGRAPH_TYPE_SHIFT) &
-		FGRAPH_TYPE_MASK;
+	return __get_type(current->ret_stack[offset]);
 }
 
 static inline int get_fgraph_array(struct task_struct *t, int offset)
 {
-	return (current->ret_stack[offset] >> FGRAPH_ARRAY_SHIFT) &
-		FGRAPH_ARRAY_MASK;
+	return __get_array(current->ret_stack[offset]);
+}
+
+static inline int get_data_idx(struct task_struct *t, int offset)
+{
+	return __get_data(current->ret_stack[offset]);
 }
 
 /* ftrace_graph_entry set to this to tell some archs to run function graph */
@@ -161,6 +202,121 @@ static void ret_stack_init_task_vars(unsigned long *ret_stack)
 	memset(gvals, 0, sizeof(*gvals) * FGRAPH_ARRAY_SIZE);
 }
 
+/**
+ * fgraph_reserve_data - Reserve storage on the task's ret_stack
+ * @size_bytes: The size in bytes to reserve (max of 4 words in size)
+ *
+ * Reserves space of up to 4 words (in word increments) on the
+ * task's ret_stack shadow stack, for a given fgraph_ops during
+ * the entryfunc() call. If entryfunc() returns zero, the storage
+ * is discarded. An entryfunc() can only call this once per iteration.
+ * The fgraph_ops retfunc() can retrieve this stored data with
+ * fgraph_retrieve_data().
+ *
+ * Returns: On success, a pointer to the data on the stack.
+ *   Otherwise, NULL if there's not enough space left on the
+ *   ret_stack for the data, or if fgraph_reserve_data() was called
+ *   more than once for a single entryfunc() call.
+ */
+void *fgraph_reserve_data(int size_bytes)
+{
+	unsigned long val;
+	void *data;
+	int curr_ret_stack = current->curr_ret_stack;
+	int data_size;
+	int size;
+
+	if (size_bytes > FGRAPH_MAX_DATA_SIZE)
+		return NULL;
+
+	/* Convert to number of longs + data word */
+	data_size = ALIGN(size_bytes, sizeof(long)) / sizeof(long) + 1;
+
+	/* The size to add to ret_stack (including the reserve word) */
+	size = data_size + 1;
+
+	val = current->ret_stack[curr_ret_stack - 1];
+
+	switch (__get_type(val)) {
+	case FGRAPH_TYPE_RESERVED:
+		/*
+		 * A reserve word is only saved after the ret_stack
+		 * or after a data storage, not after an fgraph_array
+		 * entry. It's OK if its after the ret_stack in which
+		 * case the index will be one, but if the index is
+		 * greater than 1 it means it's a double call to
+		 * fgraph_reserve_data()
+		 */
+		if (__get_index(val) > 1)
+			return NULL;
+		/*
+		 * Leave the reserve in case the entryfunc() doesn't
+		 * want to be recorded.
+		 */
+		break;
+	case FGRAPH_TYPE_ARRAY:
+		break;
+	default:
+		return NULL;
+	}
+	data = &current->ret_stack[curr_ret_stack];
+
+	curr_ret_stack += size;
+	if (unlikely(curr_ret_stack >= SHADOW_STACK_MAX_INDEX))
+		return NULL;
+
+	val = __get_index(val) + size;
+
+	/* Set the last word to be reserved */
+	current->ret_stack[curr_ret_stack - 1] = val;
+
+	/* Make sure interrupts see this */
+	barrier();
+	current->curr_ret_stack = curr_ret_stack;
+	/* Again sync with interrupts, and reset reserve */
+	current->ret_stack[curr_ret_stack - 1] = val;
+
+	val = (data_size << FGRAPH_DATA_SHIFT) |
+		(FGRAPH_TYPE_DATA << FGRAPH_TYPE_SHIFT) |
+		(val - 1);
+
+	/* Save the data header */
+	current->ret_stack[curr_ret_stack - 2] = val;
+
+	return data;
+}
+
+/**
+ * fgraph_retrieve_data - Retrieve stored data from fgraph_reserve_data()
+ *
+ * This is to be called by a fgraph_ops retfunc(), to retrieve data that
+ * was stored by the fgraph_ops entryfunc() on the function entry.
+ * That is, this will retrieve the data that was reserved on the
+ * entry of the function that corresponds to the exit of the function
+ * that the fgraph_ops retfunc() is called on.
+ *
+ * Returns: The stored data from fgraph_reserve_data() called by the
+ *    matching entryfunc() for the retfunc() this is called from.
+ *   Or NULL if there was nothing stored.
+ */
+void *fgraph_retrieve_data(void)
+{
+	unsigned long val;
+	int curr_ret_stack = current->curr_ret_stack;
+
+	/* Top of stack is the fgraph_ops */
+	val = current->ret_stack[curr_ret_stack - 1];
+	/* Check if there's nothing between the fgraph_ops and ret_stack */
+	if (__get_index(val) == 1)
+		return NULL;
+	val = current->ret_stack[curr_ret_stack - 2];
+	if (__get_type(val) != FGRAPH_TYPE_DATA)
+		return NULL;
+
+	return &current->ret_stack[curr_ret_stack -
+				   (__get_data(val) + 1)];
+}
+
 /**
  * fgraph_get_task_var - retrieve a task specific state variable
  * @gops: The ftrace_ops that owns the task specific variable
@@ -330,6 +486,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 			 unsigned long frame_pointer, unsigned long *retp)
 {
 	struct ftrace_graph_ent trace;
+	int save_curr_ret_stack;
 	int offset;
 	int start;
 	int type;
@@ -357,8 +514,10 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 			atomic_inc(&current->trace_overrun);
 			break;
 		}
+		save_curr_ret_stack = current->curr_ret_stack;
 		if (ftrace_ops_test(&gops->ops, func, NULL) &&
 		    gops->entryfunc(&trace, gops)) {
+			/* Note, curr_ret_stack could change by enryfunc() */
 			offset = current->curr_ret_stack;
 			/* Check the top level stored word */
 			type = get_fgraph_type(current, offset - 1);
@@ -392,6 +551,9 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 			barrier();
 			current->ret_stack[offset] = val;
 			cnt++;
+		} else {
+			/* Clear out any saved storage */
+			current->curr_ret_stack = save_curr_ret_stack;
 		}
 	}
 
@@ -502,10 +664,10 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 	struct ftrace_ret_stack *ret_stack;
 	struct ftrace_graph_ret trace;
 	unsigned long ret;
-	int offset;
+	int curr_ret_stack;
+	int stop_at;
 	int index;
 	int idx;
-	int i;
 
 	ret_stack = ftrace_pop_return_trace(&trace, &ret, frame_pointer);
 
@@ -518,24 +680,38 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 
 	trace.rettime = trace_clock_local();
 
-	offset = current->curr_ret_stack - 1;
-	index = get_ret_stack_index(current, offset);
+	curr_ret_stack = current->curr_ret_stack;
+	index = get_ret_stack_index(current, curr_ret_stack - 1);
+
+	stop_at = curr_ret_stack - index;
 
 	/* index has to be at least one! Optimize for it */
-	i = 0;
 	do {
-		idx = get_fgraph_array(current, offset - i);
-		fgraph_array[idx]->retfunc(&trace, fgraph_array[idx]);
-		i++;
-	} while (i < index);
+		unsigned long val;
+
+		val = current->ret_stack[curr_ret_stack - 1];
+		switch (__get_type(val)) {
+		case FGRAPH_TYPE_ARRAY:
+			idx = __get_array(val);
+			fgraph_array[idx]->retfunc(&trace, fgraph_array[idx]);
+			/* Fall through */
+		case FGRAPH_TYPE_RESERVED:
+			curr_ret_stack--;
+			break;
+		case FGRAPH_TYPE_DATA:
+			curr_ret_stack -= __get_data(val);
+			break;
+		default:
+			WARN_ONCE(1, "Bad fgraph ret_stack data type %d",
+				  __get_type(val));
+			curr_ret_stack--;
+		}
+		/* Make sure interrupts see the update after the above */
+		barrier();
+		current->curr_ret_stack = curr_ret_stack;
+	} while (curr_ret_stack > stop_at);
 
-	/*
-	 * The ftrace_graph_return() may still access the current
-	 * ret_stack structure, we need to make sure the update of
-	 * curr_ret_stack is after that.
-	 */
-	barrier();
-	current->curr_ret_stack -= index + FGRAPH_RET_INDEX;
+	current->curr_ret_stack -= FGRAPH_RET_INDEX;
 	current->curr_ret_depth--;
 	return ret;
 }
-- 
2.20.1


