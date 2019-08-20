Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A524095242
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 02:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbfHTAOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 20:14:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33902 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728578AbfHTAOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 20:14:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 615E6189D6DB;
        Tue, 20 Aug 2019 00:14:40 +0000 (UTC)
Received: from ovpn-117-150.phx2.redhat.com (ovpn-117-150.phx2.redhat.com [10.3.117.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF4235D9CD;
        Tue, 20 Aug 2019 00:14:38 +0000 (UTC)
Message-ID: <b12aa6442bd12c725beb8e381083e6880dbd9206.camel@redhat.com>
Subject: Re: [RFC v2] rcu/tree: Try to invoke_rcu_core() if in_irq() during
 unlock
From:   Scott Wood <swood@redhat.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Mon, 19 Aug 2019 19:14:38 -0500
In-Reply-To: <20190818214948.GA134430@google.com>
References: <20190818214948.GA134430@google.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Tue, 20 Aug 2019 00:14:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-08-18 at 17:49 -0400, Joel Fernandes (Google) wrote:
> When we're in hard interrupt context in rcu_read_unlock_special(), we
> can still benefit from invoke_rcu_core() doing wake ups of rcuc
> threads when the !use_softirq parameter is passed.  This is safe
> to do so because:

What is the benefit, beyond skipping the irq work overhead?  Is there some
reason to specifically want the rcuc thread woken rather than just getting
into the scheduler (and thus rcu_note_context_switch) as soon as possible?

-Scott


