Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B552C3346
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 13:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732618AbfJALrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 07:47:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60633 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfJALrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:47:46 -0400
Received: from [213.220.153.21] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iFGd5-00077f-Es; Tue, 01 Oct 2019 11:47:43 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 0/2] document clone3 and struct clone_args
Date:   Tue,  1 Oct 2019 13:47:00 +0200
Message-Id: <20191001114701.24661-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

This adds missing kernel-docs for the clone3() syscall and its argument
struct clone_args. I somehow failed to add this right away.

I intend to include this in my rc2 pull request.

Thanks!
Christian

Christian Brauner (2):
  fork: add kernel-doc for clone3
  sched: add kernel-doc for struct clone_args

 include/uapi/linux/sched.h | 26 ++++++++++++++++++++++++--
 kernel/fork.c              | 11 +++++++++++
 2 files changed, 35 insertions(+), 2 deletions(-)

-- 
2.23.0

