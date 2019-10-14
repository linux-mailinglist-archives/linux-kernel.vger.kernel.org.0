Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD61FD5B71
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 08:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbfJNGgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 02:36:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:51340 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726406AbfJNGgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 02:36:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 36BE7B0BD;
        Mon, 14 Oct 2019 06:36:31 +0000 (UTC)
Date:   Sun, 13 Oct 2019 23:35:11 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>, 1vier1@web.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 2/6] ipc/mqueue.c: Remove duplicated code
Message-ID: <20191014063511.dpbu3u6qoxr3ogn5@linux-p48b>
References: <20191012054958.3624-1-manfred@colorfullife.com>
 <20191012054958.3624-3-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191012054958.3624-3-manfred@colorfullife.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Oct 2019, Manfred Spraul wrote:

>Patch entirely from Davidlohr:
>pipelined_send() and pipelined_receive() are identical, so merge them.
>

Sorry, yeah feel free to add my:

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>

>Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
>Cc: Davidlohr Bueso <dave@stgolabs.net>
>---
> ipc/mqueue.c | 31 ++++++++++++++++++-------------
> 1 file changed, 18 insertions(+), 13 deletions(-)
>
>diff --git a/ipc/mqueue.c b/ipc/mqueue.c
>index 3d920ff15c80..be48c0ba92f7 100644
>--- a/ipc/mqueue.c
>+++ b/ipc/mqueue.c
>@@ -918,17 +918,12 @@ SYSCALL_DEFINE1(mq_unlink, const char __user *, u_name)
>  * The same algorithm is used for senders.
>  */
>
>-/* pipelined_send() - send a message directly to the task waiting in
>- * sys_mq_timedreceive() (without inserting message into a queue).
>- */
>-static inline void pipelined_send(struct wake_q_head *wake_q,
>+static inline void __pipelined_op(struct wake_q_head *wake_q,
> 				  struct mqueue_inode_info *info,
>-				  struct msg_msg *message,
>-				  struct ext_wait_queue *receiver)
>+				  struct ext_wait_queue *this)
> {
>-	receiver->msg = message;
>-	list_del(&receiver->list);
>-	wake_q_add(wake_q, receiver->task);
>+	list_del(&this->list);
>+	wake_q_add(wake_q, this->task);
> 	/*
> 	 * Rely on the implicit cmpxchg barrier from wake_q_add such
> 	 * that we can ensure that updating receiver->state is the last
>@@ -937,7 +932,19 @@ static inline void pipelined_send(struct wake_q_head *wake_q,
> 	 * yet, at that point we can later have a use-after-free
> 	 * condition and bogus wakeup.
> 	 */
>-	receiver->state = STATE_READY;
>+        this->state = STATE_READY;
>+}
>+
>+/* pipelined_send() - send a message directly to the task waiting in
>+ * sys_mq_timedreceive() (without inserting message into a queue).
>+ */
>+static inline void pipelined_send(struct wake_q_head *wake_q,
>+				  struct mqueue_inode_info *info,
>+				  struct msg_msg *message,
>+				  struct ext_wait_queue *receiver)
>+{
>+	receiver->msg = message;
>+	__pipelined_op(wake_q, info, receiver);
> }
>
> /* pipelined_receive() - if there is task waiting in sys_mq_timedsend()
>@@ -955,9 +962,7 @@ static inline void pipelined_receive(struct wake_q_head *wake_q,
> 	if (msg_insert(sender->msg, info))
> 		return;
>
>-	list_del(&sender->list);
>-	wake_q_add(wake_q, sender->task);
>-	sender->state = STATE_READY;
>+	__pipelined_op(wake_q, info, sender);
> }
>
> static int do_mq_timedsend(mqd_t mqdes, const char __user *u_msg_ptr,
>-- 
>2.21.0
>
