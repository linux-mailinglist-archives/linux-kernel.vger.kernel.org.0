Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 692C7C9635
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 03:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfJCBdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 21:33:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfJCBdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:33:09 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8563D222C6;
        Thu,  3 Oct 2019 01:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066388;
        bh=1fqr3ZL8P5GTCI2tqHcwXhg1F5zE+CiEP/Jl//+mNEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WzY92k2lvoPuC4FnoD7Dhwv8n67xWKGFJje6yqXkujs1LEjBkIymOUlKH12dtJakT
         YIBHw2v2LNKox/4HobMDxRLiN5DxZk9ct+9iwNQeMDvq+354VhPTC1TmbmaKSAA0tv
         ufIl5oS1atNzLsC2VTOCyetwZcNLkUWsNg++lAlY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 5/8] rcu: Remove obsolete descriptions for rcu_barrier tracepoint
Date:   Wed,  2 Oct 2019 18:33:02 -0700
Message-Id: <20191003013305.12854-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003013243.GA12705@paulmck-ThinkPad-P72>
References: <20191003013243.GA12705@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 include/trace/events/rcu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 694bd04..afa8985 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -713,8 +713,6 @@ TRACE_EVENT_RCU(rcu_torture_read,
  *	"Begin": rcu_barrier() started.
  *	"EarlyExit": rcu_barrier() piggybacked, thus early exit.
  *	"Inc1": rcu_barrier() piggyback check counter incremented.
- *	"OfflineNoCB": rcu_barrier() found callback on never-online CPU
- *	"OnlineNoCB": rcu_barrier() found online no-CBs CPU.
  *	"OnlineQ": rcu_barrier() found online CPU with callbacks.
  *	"OnlineNQ": rcu_barrier() found online CPU, no callbacks.
  *	"IRQ": An rcu_barrier_callback() callback posted on remote CPU.
-- 
2.9.5

