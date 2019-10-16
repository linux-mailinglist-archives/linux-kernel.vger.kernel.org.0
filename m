Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70891D8970
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 09:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388791AbfJPHbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 03:31:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48468 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388737AbfJPHbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:31:39 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iKdmO-0007Nm-2r; Wed, 16 Oct 2019 09:31:32 +0200
Date:   Wed, 16 Oct 2019 09:31:32 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 26/34] Documentation/RCU: Use CONFIG_PREEMPTION where
 appropriate
Message-ID: <20191016073131.b35nfcc3vzbm2pfk@linutronix.de>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
 <20191015191821.11479-27-bigeasy@linutronix.de>
 <20191016041330.GF2689@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191016041330.GF2689@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-15 21:13:30 [-0700], Paul E. McKenney wrote:
> Sadly, this one ran afoul of the .txt-to-.rst migration.  Even applying
> it against linus/master and cherry-picking it does not help.  I will
> defer it for the moment -- perhaps Mauro or Joel have some advice.

Don't worry about it then. Just point me to the tree once it is done.

> 							Thanx, Paul

Sebastian
