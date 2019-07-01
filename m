Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7382F5BB6D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 14:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfGAMYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 08:24:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40312 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbfGAMYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 08:24:05 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hhvLi-00052n-Lp; Mon, 01 Jul 2019 14:23:58 +0200
Date:   Mon, 1 Jul 2019 14:23:58 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kselftest@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC 3/3] Revert "rcutorture: Tweak kvm options"
Message-ID: <20190701122358.nzebpuunp6o5jxhx@linutronix.de>
References: <20190701040415.219001-1-joel@joelfernandes.org>
 <20190701040415.219001-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190701040415.219001-3-joel@joelfernandes.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-01 00:04:15 [-0400], Joel Fernandes (Google) wrote:
> This reverts commit a6fda6dab93c2c06ef4b8cb4b9258df6674d2438 which
> causes kvm.sh to not run on my machines. The qemu-system-x86_64 command
> runs but does nothing.

Nope. I would like to know *why* you need 'noapic' to work. Is it a
brand new or old qemu-system-x86_64?

> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Sebastian
