Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41B8A8D446
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 15:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfHNNKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 09:10:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38009 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfHNNKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:10:42 -0400
Received: from [213.220.153.21] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1hxt32-0003Hp-Jz; Wed, 14 Aug 2019 13:10:40 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Cc:     oleg@redhat.com, alistair23@gmail.com, ebiederm@xmission.com,
        arnd@arndb.de, dalias@libc.org, torvalds@linux-foundation.org,
        adhemerval.zanella@linaro.org, fweimer@redhat.com,
        palmer@sifive.com, macro@wdc.com, zongbox@gmail.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk, hpa@zytor.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 0/1] waitid: process group enhancement
Date:   Wed, 14 Aug 2019 15:07:31 +0200
Message-Id: <20190814130732.23572-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <CAKmqyKMJPQAOKn11xepzAwXOd4e9dU0Cyz=A0T-uMEgUp5yJjA@mail.gmail.com>
References: <CAKmqyKMJPQAOKn11xepzAwXOd4e9dU0Cyz=A0T-uMEgUp5yJjA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey everyone,

This patch adds support for waiting on the current process group by
specifying waitid(P_PGID, 0, ...) as discussed in [1]. The details why
we need to do this are in the commit message of [PATCH 1/1] so I won't
repeat them here.

I've picked this up since the thread has gone stale and parts of
userspace are actually blocked by this.

Note that the patch has been changed to be more closely aligned with the
P_PIDFD changes to waitid() I have sitting in my for-next branch (cf. [2]).
This makes the merge conflict a little simpler and picks up on the
coding style discussions that guided the P_PIDFD patchset.

There was some desire to get this feature in with 5.3 (cf. [3]).
But given that this is a new feature for waitid() and for the sake of
avoiding any merge conflicts I would prefer to land this in the 5.4
merge window together with the P_PIDFD changes.

Thanks!
Christian

/* References */
[1]: https://www.sourceware.org/ml/libc-alpha/2019-07/msg00587.html
[2]: https://lore.kernel.org/lkml/20190727222229.6516-1-christian@brauner.io/
[3]: https://www.sourceware.org/ml/libc-alpha/2019-08/msg00304.html

Eric W. Biederman (1):
  waitid: Add support for waiting for the current process group

 kernel/exit.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

-- 
2.22.0

