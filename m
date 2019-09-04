Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87C39A80E3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 13:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbfIDLHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 07:07:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50932 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbfIDLHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:07:18 -0400
Received: from [213.220.153.21] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1i5T84-0004L3-0j; Wed, 04 Sep 2019 11:07:12 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     hridya@google.com
Cc:     arve@android.com, christian@brauner.io, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, joel@joelfernandes.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        maco@android.com, tkjos@android.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [RESEND PATCH v3 0/2] Add default binderfs devices
Date:   Wed,  4 Sep 2019 13:07:02 +0200
Message-Id: <20190904110704.8606-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190808222727.132744-1-hridya@google.com>
References: <20190808222727.132744-1-hridya@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

This is a resend of Hridya's series to add default binderfs devices. No
semantical changes were made. Only Joel's Acks were added by me.

Binderfs was created to help provide private binder devices to
containers in their own IPC namespace. Currently, every time a new binderfs
instance is mounted, its private binder devices need to be created via
IOCTL calls. This patch series eliminates the effort for creating
the default binder devices for each binderfs instance by creating them
automatically.

/* v0 */
Link: https://lore.kernel.org/lkml/20190801223556.209184-1-hridya@google.com

/* v1 */
Link: https://lore.kernel.org/lkml/20190806184007.60739-1-hridya@google.com

/* v2 */
Link: https://lore.kernel.org/lkml/20190808222727.132744-1-hridya@google.com/

Thanks!
Christian

Hridya Valsaraju (2):
  binder: Add default binder devices through binderfs when configured
  binder: Validate the default binderfs device names.

 drivers/android/binder.c          |  5 +++--
 drivers/android/binder_internal.h |  2 ++
 drivers/android/binderfs.c        | 35 ++++++++++++++++++++++++++++---
 3 files changed, 37 insertions(+), 5 deletions(-)

-- 
2.23.0

