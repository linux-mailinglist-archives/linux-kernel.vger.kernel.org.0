Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88D648DF4D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 22:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbfHNUuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 16:50:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50471 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbfHNUuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 16:50:44 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1hy0EE-0007JQ-7Q; Wed, 14 Aug 2019 20:50:42 +0000
Date:   Wed, 14 Aug 2019 22:50:41 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
        alistair23@gmail.com, ebiederm@xmission.com, arnd@arndb.de,
        dalias@libc.org, torvalds@linux-foundation.org,
        adhemerval.zanella@linaro.org, fweimer@redhat.com,
        palmer@sifive.com, macro@wdc.com, zongbox@gmail.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk, hpa@zytor.com
Subject: Re: [PATCH v3 1/1] waitid: Add support for waiting for the current
 process group
Message-ID: <20190814205040.d7shwe6u3jz6qmcc@wittgenstein>
References: <CAKmqyKMJPQAOKn11xepzAwXOd4e9dU0Cyz=A0T-uMEgUp5yJjA@mail.gmail.com>
 <20190814154400.6371-1-christian.brauner@ubuntu.com>
 <20190814154400.6371-2-christian.brauner@ubuntu.com>
 <20190814160917.GG11595@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190814160917.GG11595@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 06:09:17PM +0200, Oleg Nesterov wrote:
> On 08/14, Christian Brauner wrote:
> >
> > and a signal could come in between the system call that
> > retrieved the process gorup and the call to waitid that changes the
>                         ^^^^^
> > current process group.
> 
> I noticed this typo only because I spent 2 minutes or more trying to
> understand this sentence ;) But yes, a signal handler or another thread
> can change pgrp in between.
> 
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>

Applied-to:
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=pidfd
on top of P_PIDFD changes (cf. [1]) with merge conflict resolved (cf. [2]).
(All changes on top of v5.3-rc1.)

Merged-into:
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=for-next
and should show up in linux-next tomorrow.

Thanks!
Christian

/* References */
[1]: https://lore.kernel.org/r/20190727222229.6516-2-christian@brauner.io
[2]: patch after resolved merge-conflict:
 kernel/exit.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 64bb6893a37d..d2d74a7b81d1 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1596,10 +1596,13 @@ static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
 		break;
 	case P_PGID:
 		type = PIDTYPE_PGID;
-		if (upid <= 0)
+		if (upid < 0)
 			return -EINVAL;
 
-		pid = find_get_pid(upid);
+		if (upid)
+			pid = find_get_pid(upid);
+		else
+			pid = get_task_pid(current, PIDTYPE_PGID);
 		break;
 	case P_PIDFD:
 		type = PIDTYPE_PID;
