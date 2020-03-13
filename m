Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A28B5183F2F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 03:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgCMCkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 22:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbgCMCkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 22:40:07 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D92720724;
        Fri, 13 Mar 2020 02:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584067207;
        bh=6V5034ysnLgvvbSebr5dC4ZNWLB0UT9n3wnteW3uwVg=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=bFp9D0vhlP+/Nd+KFmxl+82cn0PsqhUEpxB5XwFyHQiV77McJLVnJRe1WVjA178F7
         hqJb18K8x5AEblp+Bua24KMYvCqDp6UuV7KduvZ4oOQrZAa/yQj7Nn/Fwn9bzcAJLZ
         aPsc5XgLPxRq/Eu7sVyrDroDksuBijPXwHu/JHrQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2A3EF35226F6; Thu, 12 Mar 2020 19:40:07 -0700 (PDT)
Date:   Thu, 12 Mar 2020 19:40:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH RFC tip/core/rcu 0/2] Fix RCU idle-exit problem and comment
Message-ID: <20200313024007.GA27492@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series fixes a brown-paper-bag NMI self-deadlock bug located by
Thomas Gleixner and adds comments:

1.	Don't acquire lock in NMI handler in rcu_nmi_enter_common().

2.	Add comments marking transitions between RCU watching and not.

These pass light rcutorture testing, and seem like v5.8 material.

							Thanx, Paul

------------------------------------------------------------------------

 tree.c |   31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)
