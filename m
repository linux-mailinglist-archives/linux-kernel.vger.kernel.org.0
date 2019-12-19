Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3691266D8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 17:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfLSQ3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 11:29:17 -0500
Received: from ms.lwn.net ([45.79.88.28]:37118 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfLSQ3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 11:29:15 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C81922E5;
        Thu, 19 Dec 2019 16:29:14 +0000 (UTC)
Date:   Thu, 19 Dec 2019 09:29:13 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Amol Grover <frextrite@gmail.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: Re: [PATCH v2] doc: listRCU: Add some more listRCU patterns in the
 kernel
Message-ID: <20191219092913.76ca933e@lwn.net>
In-Reply-To: <20191206080750.21745-1-frextrite@gmail.com>
References: <20191203063941.6981-1-frextrite@gmail.com>
        <20191206080750.21745-1-frextrite@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 Dec 2019 13:37:51 +0530
Amol Grover <frextrite@gmail.com> wrote:

> - Add more information about listRCU patterns taking examples
> from audit subsystem in the linux kernel.
> 
> - The initially written audit examples are kept, even though they are
> slightly different in the kernel.
> 
> - Modify inline text for better passage quality.
> 
> - Fix typo in code-blocks and improve code comments.
> 
> - Add text formatting (italics, bold and code) for better emphasis.
> 
> Patch originally submitted at
> https://lore.kernel.org/patchwork/patch/1082804/
> 
> Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Amol Grover <frextrite@gmail.com>

Paul, what's your wish regarding this one?  Do you want to pick it up, or
should I ... ?

jon
