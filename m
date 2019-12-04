Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C351112EE6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 16:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfLDPrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 10:47:32 -0500
Received: from ms.lwn.net ([45.79.88.28]:59874 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727878AbfLDPrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:47:31 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7F2D22D5;
        Wed,  4 Dec 2019 15:47:30 +0000 (UTC)
Date:   Wed, 4 Dec 2019 08:47:29 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Amol Grover <frextrite@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: Re: [PATCH] doc: listRCU: Add some more listRCU patterns in the
 kernel
Message-ID: <20191204084729.184480f3@lwn.net>
In-Reply-To: <20191204153958.GA17404@google.com>
References: <20191203063941.6981-1-frextrite@gmail.com>
        <20191203064132.38d75348@lwn.net>
        <20191204082412.GA6959@workstation-kernel-dev>
        <20191204074833.44bcc079@lwn.net>
        <20191204153958.GA17404@google.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Dec 2019 10:39:58 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:

> Actually I had asked Amol privately to add the backticks. It appeared
> super weird in my browser when some function calls were rendered
> monospace while others weren't. Not all functions were successfully
> cross referenced for me. May be it is my kernel version?

If you have an example of a failure to cross-reference a function that
has kerneldoc comments *that are included in the toctree*, I'd like to see
it; that's a bug.

Changing the font on functions without anything to cross-reference to is
easy enough and should probably be done; I'll look into it when I get a
chance.

Thanks,

jon
