Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECD1D5C1A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 09:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbfJNHRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 03:17:16 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:33871 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730109AbfJNHRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 03:17:15 -0400
Received: from [78.40.148.177] (helo=localhost)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iJubD-00030W-Es; Mon, 14 Oct 2019 08:16:59 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 14 Oct 2019 08:16:58 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     paulmck@kernel.org
Cc:     linux-kernel@lists.codethink.co.uk,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: add declarations of undeclared items
In-Reply-To: <20191012044430.GG2689@paulmck-ThinkPad-P72>
References: <20191011170824.30228-1-ben.dooks@codethink.co.uk>
 <20191012044430.GG2689@paulmck-ThinkPad-P72>
Message-ID: <7acbcc9b901304f8f55cc1cece802785@codethink.co.uk>
X-Sender: ben.dooks@codethink.co.uk
User-Agent: Roundcube Webmail/1.3.10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-10-12 05:44, Paul E. McKenney wrote:
> On Fri, Oct 11, 2019 at 06:08:24PM +0100, Ben Dooks wrote:
>> The rcu_state, rcu_rnp_online_cpus and rcu_dynticks_curr_cpu_in_eqs
>> do not have declarations in a header. Add these to remove the
>> following sparse warnings:
>> 
>> kernel/rcu/tree.c:87:18: warning: symbol 'rcu_state' was not declared. 
>> Should it be static?
>> kernel/rcu/tree.c:191:15: warning: symbol 'rcu_rnp_online_cpus' was 
>> not declared. Should it be static?
>> kernel/rcu/tree.c:297:6: warning: symbol 
>> 'rcu_dynticks_curr_cpu_in_eqs' was not declared. Should it be static?
>> 
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> Good catch!
> 
> However, these guys (plus one more) are actually used only in the
> kernel/rcu/tree.o translation unit, so they can be marked static.
> I made this change as shown below with your Reported-by.
> 
> Seem reasonable?

yes, thanks.

