Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 526FE153B01
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 23:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgBEWas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 17:30:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:48490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbgBEWar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:30:47 -0500
Received: from oasis.local.home (unknown [81.144.254.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDDBA2072B;
        Wed,  5 Feb 2020 22:25:33 +0000 (UTC)
Date:   Wed, 5 Feb 2020 17:25:29 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        paulmck@kernel.org, frextrite@gmail.com, rcu@vger.kernel.org,
        madhuparnabhowmik04@gmail.com
Subject: Re: [PATCH] kernel/trace: Use rcu_assign_pointer() for setting
 fgraph hash pointers
Message-ID: <20200205172529.4282a0d1@oasis.local.home>
In-Reply-To: <20200205221808.54576-1-joel@joelfernandes.org>
References: <20200205221808.54576-1-joel@joelfernandes.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  5 Feb 2020 17:18:08 -0500
"Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:

> set_ftrace_early_graph() sets pointers without any explicit
> release-barriers. Let us use rcu_assign_pointer() to ensure the same.
> 
> Note that ftrace_early_graph() calls ftrace_graph_set_hash() which does
> do mutex_unlock(&ftrace_lock); which should imply a release barrier.
> However it is better to not depend on it and just use
> rcu_assign_pointer() which should also avoid sparse errors in the
> future.

This is going to have to wait for the next merge window, as I'm already
*very* late, and I've pushed the limit to what I will add at this time
frame.

-- Steve

