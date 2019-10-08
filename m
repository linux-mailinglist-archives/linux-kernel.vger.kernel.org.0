Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 358F3CEFD5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 02:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbfJHAPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 20:15:40 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36662 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbfJHAPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 20:15:40 -0400
Received: from turingmachine.home (unknown [IPv6:2804:431:c7f4:ff3d:d711:794d:1c68:5ed3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tonyk)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C60AE28E972;
        Tue,  8 Oct 2019 01:15:35 +0100 (BST)
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, kernel@collabora.com, krisman@collabora.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v2 1/1] blk-mq: fill header with kernel-doc
Date:   Mon,  7 Oct 2019 21:14:16 -0300
Message-Id: <20191008001416.12656-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Insert documentation for structs, enums and functions at header file.
Format existing and new comments at struct blk_mq_ops as
kernel-doc comments.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
Hello,

This patch is an effort to enhance the documentation of the multiqueue
API. To check if the comments are confirming to kernel-doc format, you
first need to apply a patch[1] solving a bug around the `__cacheline...`
directive. Then, just run

./scripts/kernel-doc -none include/linux/blk-mq.h

to check that there is no warning at this documentation. I've done my
best at the source to check the purpose of each struct and its members,
but please let me know if I get something wrong.

Changes since v2:
- Fix the meaning of PDU
- Uses nested comments for long structs
- Slight reword member definition to look closer to work made at commit
"block: Document all members of blk_mq_tag_set and bkl_mq_queue_map"

[1] https://lkml.org/lkml/2019/9/17/820
---
 include/linux/blk-mq.h | 207 +++++++++++++++++++++++++++++++++--------
 1 file changed, 167 insertions(+), 40 deletions(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e0fce93ac127..8b745f229789 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -10,74 +10,153 @@ struct blk_mq_tags;
 struct blk_flush_queue;
 
 /**
- * struct blk_mq_hw_ctx - State for a hardware queue facing the hardware block device
+ * struct blk_mq_hw_ctx - State for a hardware queue facing the hardware
+ * block device
  */
 struct blk_mq_hw_ctx {
 	struct {
+		/** @lock: Lock for accessing dispatch queue */
 		spinlock_t		lock;
+		/**
+		 * @dispatch: Queue of dispatched requests, waiting for
+		 * workers to send them to the hardware.
+		 */
 		struct list_head	dispatch;
-		unsigned long		state;		/* BLK_MQ_S_* flags */
+		 /**
+		  * @state: BLK_MQ_S_* flags. Define the state of the hw
+		  * queue (active, scheduled to restart, stopped).
+		  */
+		unsigned long		state;
 	} ____cacheline_aligned_in_smp;
 
+	/**
+	 * @run_work: Worker for dispatch scheduled requests to hardware.
+	 * BLK_MQ_CPU_WORK_BATCH workers will be assigned to a CPU, then the
+	 * following ones will be assigned to the next_cpu.
+	 */
 	struct delayed_work	run_work;
+	/** @cpumask: Map of available CPUs. */
 	cpumask_var_t		cpumask;
+	/**
+	 * @next_cpu: Index of CPU/workqueue to be used in the next batch
+	 * of workers.
+	 */
 	int			next_cpu;
+	/**
+	 * @next_cpu_batch: Counter of how many works letf in the batch before
+	 * changing to the next CPU. A batch has the size
+	 * of BLK_MQ_CPU_WORK_BATCH.
+	 */
 	int			next_cpu_batch;
 
-	unsigned long		flags;		/* BLK_MQ_F_* flags */
+	/** @flags: BLK_MQ_F_* flags. Define the behaviour of the queue. */
+	unsigned long		flags;
 
+	/** @sched_data: Data to support schedulers. */
 	void			*sched_data;
+	/** @queue: Queue of request to be dispatched. */
 	struct request_queue	*queue;
+	/** @fq: Queue of requests to be flushed from memory to storage. */
 	struct blk_flush_queue	*fq;
 
+	/**
+	 * @driver_data: Pointer to data owned by the block driver that created
+	 * this hctx
+	 */
 	void			*driver_data;
 
+	/**
+	 * @ctx_map: Bitmap for each software queue. If bit is on, there is a
+	 * pending request.
+	 */
 	struct sbitmap		ctx_map;
 
+	/**
+	 * @dispatch_from: Queue to be used when there is no scheduler
+	 * was selected.
+	 */
 	struct blk_mq_ctx	*dispatch_from;
+	/**
+	 * @dispatch_busy: Number used by blk_mq_update_dispatch_busy() to
+	 * decide if the hw_queue is busy using Exponential Weighted Moving
+	 * Average algorithm.
+	 */
 	unsigned int		dispatch_busy;
 
+	/** @type: HCTX_TYPE_* flags. Type of hardware queue. */
 	unsigned short		type;
+	/** @nr_ctx: Number of software queues. */
 	unsigned short		nr_ctx;
+	/** @ctxs:	Array of software queues. */
 	struct blk_mq_ctx	**ctxs;
 
+	/** @dispatch_wait_lock: Lock for dispatch_wait queue. */
 	spinlock_t		dispatch_wait_lock;
+	/**
+	 * @dispatch_wait: Waitqueue for dispatched requests. Request here will
+	 * be processed when percpu_ref_is_zero(&q->q_usage_counter) evaluates
+	 * true for q as a request_queue.
+	 */
 	wait_queue_entry_t	dispatch_wait;
+	/** @wait_index: Index of next wait queue to be used. */
 	atomic_t		wait_index;
 
+	/** @tags: Request tags. */
 	struct blk_mq_tags	*tags;
+	/** @sched_tags: Request tags for schedulers. */
 	struct blk_mq_tags	*sched_tags;
 
+	/** @queued: Number of queued requests. */
 	unsigned long		queued;
+	/** @run: Number of dispatched requests. */
 	unsigned long		run;
 #define BLK_MQ_MAX_DISPATCH_ORDER	7
+	/** @dispatched: Number of dispatch requests by queue. */
 	unsigned long		dispatched[BLK_MQ_MAX_DISPATCH_ORDER];
 
+	/** @numa_node: NUMA node the storage adapter has been connected to. */
 	unsigned int		numa_node;
+	/** @queue_num: Index of this hardware queue. */
 	unsigned int		queue_num;
 
+	/** @nr_active:	Number of active tags. */
 	atomic_t		nr_active;
 
+	/** @cpuhp_dead: List to store request if some CPU die. */
 	struct hlist_node	cpuhp_dead;
+	/** @kobj: Kernel object for sysfs. */
 	struct kobject		kobj;
 
+	/** @poll_considered: Count times blk_poll() was called. */
 	unsigned long		poll_considered;
+	/** @poll_invoked: Count how many requests blk_poll() polled. */
 	unsigned long		poll_invoked;
+	/** @poll_success: Count how many polled requests were completed. */
 	unsigned long		poll_success;
 
 #ifdef CONFIG_BLK_DEBUG_FS
+	/**
+	 * @debugfs_dir: debugfs directory for this hardware queue. Named
+	 * as cpu<cpu_number>.
+	 */
 	struct dentry		*debugfs_dir;
+	/** @sched_debugfs_dir:	debugfs directory for the scheduler. */
 	struct dentry		*sched_debugfs_dir;
 #endif
 
+	/** @hctx_list:	List of all hardware queues. */
 	struct list_head	hctx_list;
 
-	/* Must be the last member - see also blk_mq_hw_ctx_size(). */
+	/**
+	 * @srcu: Sleepable RCU. Use as lock when type of the hardware queue is
+	 * blocking (BLK_MQ_F_BLOCKING). Must be the last member - see also
+	 * blk_mq_hw_ctx_size().
+	 */
 	struct srcu_struct	srcu[0];
 };
 
 /**
- * struct blk_mq_queue_map - ctx -> hctx mapping
+ * struct blk_mq_queue_map - Map software queues to hardware queues
  * @mq_map:       CPU ID to hardware queue index map. This is an array
  *	with nr_cpu_ids elements. Each element has a value in the range
  *	[@queue_offset, @queue_offset + @nr_queues).
@@ -92,10 +171,17 @@ struct blk_mq_queue_map {
 	unsigned int queue_offset;
 };
 
+/**
+ * enum hctx_type - Type of hardware queue
+ * @HCTX_TYPE_DEFAULT:	All I/O not otherwise accounted for.
+ * @HCTX_TYPE_READ:	Just for READ I/O.
+ * @HCTX_TYPE_POLL:	Polled I/O of any kind.
+ * @HCTX_MAX_TYPES:	Number of types of hctx.
+ */
 enum hctx_type {
-	HCTX_TYPE_DEFAULT,	/* all I/O not otherwise accounted for */
-	HCTX_TYPE_READ,		/* just for READ I/O */
-	HCTX_TYPE_POLL,		/* polled I/O of any kind */
+	HCTX_TYPE_DEFAULT,
+	HCTX_TYPE_READ,
+	HCTX_TYPE_POLL,
 
 	HCTX_MAX_TYPES,
 };
@@ -147,6 +233,12 @@ struct blk_mq_tag_set {
 	struct list_head	tag_list;
 };
 
+/**
+ * struct blk_mq_queue_data - Data about a request inserted in a queue
+ *
+ * @rq:   Data about the block IO request.
+ * @last: If it is the last request in the queue.
+ */
 struct blk_mq_queue_data {
 	struct request *rq;
 	bool last;
@@ -174,81 +266,101 @@ typedef bool (busy_fn)(struct request_queue *);
 typedef void (complete_fn)(struct request *);
 typedef void (cleanup_rq_fn)(struct request *);
 
-
+/**
+ * struct blk_mq_ops - list of callback functions that implements block driver
+ * behaviour.
+ */
 struct blk_mq_ops {
-	/*
-	 * Queue request
+	/**
+	 * @queue_rq: Queue a new request from block IO.
 	 */
 	queue_rq_fn		*queue_rq;
 
-	/*
-	 * If a driver uses bd->last to judge when to submit requests to
-	 * hardware, it must define this function. In case of errors that
-	 * make us stop issuing further requests, this hook serves the
+	/**
+	 * @commit_rqs: If a driver uses bd->last to judge when to submit
+	 * requests to hardware, it must define this function. In case of errors
+	 * that make us stop issuing further requests, this hook serves the
 	 * purpose of kicking the hardware (which the last request otherwise
 	 * would have done).
 	 */
 	commit_rqs_fn		*commit_rqs;
 
-	/*
-	 * Reserve budget before queue request, once .queue_rq is
+	/**
+	 * @get_budget: Reserve budget before queue request, once .queue_rq is
 	 * run, it is driver's responsibility to release the
 	 * reserved budget. Also we have to handle failure case
 	 * of .get_budget for avoiding I/O deadlock.
 	 */
 	get_budget_fn		*get_budget;
+	/**
+	 * @put_budget: Release the reserved budget.
+	 */
 	put_budget_fn		*put_budget;
 
-	/*
-	 * Called on request timeout
+	/**
+	 * @timeout: Called on request timeout.
 	 */
 	timeout_fn		*timeout;
 
-	/*
-	 * Called to poll for completion of a specific tag.
+	/**
+	 * @poll: Called to poll for completion of a specific tag.
 	 */
 	poll_fn			*poll;
 
+	/**
+	 * @complete: Mark the request as complete.
+	 */
 	complete_fn		*complete;
 
-	/*
-	 * Called when the block layer side of a hardware queue has been
-	 * set up, allowing the driver to allocate/init matching structures.
-	 * Ditto for exit/teardown.
+	/**
+	 * @init_hctx: Called when the block layer side of a hardware queue has
+	 * been set up, allowing the driver to allocate/init matching
+	 * structures.
 	 */
 	init_hctx_fn		*init_hctx;
+	/**
+	 * @exit_hctx: Ditto for exit/teardown.
+	 */
 	exit_hctx_fn		*exit_hctx;
 
-	/*
-	 * Called for every command allocated by the block layer to allow
-	 * the driver to set up driver specific data.
+	/**
+	 * @init_request: Called for every command allocated by the block layer
+	 * to allow the driver to set up driver specific data.
 	 *
 	 * Tag greater than or equal to queue_depth is for setting up
 	 * flush request.
-	 *
-	 * Ditto for exit/teardown.
 	 */
 	init_request_fn		*init_request;
+	/**
+	 * @exit_request: Ditto for exit/teardown.
+	 */
 	exit_request_fn		*exit_request;
-	/* Called from inside blk_get_request() */
+
+	/**
+	 * @initialize_rq_fn: Called from inside blk_get_request().
+	 */
 	void (*initialize_rq_fn)(struct request *rq);
 
-	/*
-	 * Called before freeing one request which isn't completed yet,
-	 * and usually for freeing the driver private data
+	/**
+	 * @cleanup_rq: Called before freeing one request which isn't completed
+	 * yet, and usually for freeing the driver private data.
 	 */
 	cleanup_rq_fn		*cleanup_rq;
 
-	/*
-	 * If set, returns whether or not this queue currently is busy
+	/**
+	 * @busy: If set, returns whether or not this queue currently is busy.
 	 */
 	busy_fn			*busy;
 
+	/**
+	 * @map_queues: This allows drivers specify their own queue mapping by
+	 * overriding the setup-time function that builds the mq_map.
+	 */
 	map_queues_fn		*map_queues;
 
 #ifdef CONFIG_BLK_DEBUG_FS
-	/*
-	 * Used by the debugfs implementation to show driver-specific
+	/**
+	 * @show_rq: Used by the debugfs implementation to show driver-specific
 	 * information about a request.
 	 */
 	void (*show_rq)(struct seq_file *m, struct request *rq);
@@ -391,14 +503,29 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q);
 
 unsigned int blk_mq_rq_cpu(struct request *rq);
 
-/*
+/**
+ * blk_mq_rq_from_pdu - cast a PDU to a request
+ * @pdu: the PDU (Protocol Data Unit) to be casted
+ *
+ * Return: request
+ *
  * Driver command data is immediately after the request. So subtract request
- * size to get back to the original request, add request size to get the PDU.
+ * size to get back to the original request.
  */
 static inline struct request *blk_mq_rq_from_pdu(void *pdu)
 {
 	return pdu - sizeof(struct request);
 }
+
+/**
+ * blk_mq_rq_to_pdu - cast a request to a PDU
+ * @rq: the request to be casted
+ *
+ * Return: pointer to the PDU
+ *
+ * Driver command data is immediately after the request. So add request to get
+ * the PDU.
+ */
 static inline void *blk_mq_rq_to_pdu(struct request *rq)
 {
 	return rq + 1;
-- 
2.23.0

