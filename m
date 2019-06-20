Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAE4E4CD8B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 14:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731807AbfFTMRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 08:17:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730886AbfFTMRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 08:17:42 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C4732080C;
        Thu, 20 Jun 2019 12:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561033061;
        bh=4HHw+Qp9H8V6fIHDzF9H81gSOxHTNJsMIKqmfY8FN5U=;
        h=Date:From:To:Cc:Subject:From;
        b=wWnIlZri2kxT/nVZV5on/30xs5MxQPQKduIZbSz+ZVepm9GPxHfB+ByXIoEp7twuA
         Gw0iqjZ7/1r7svIJ4PFNskjJDTa5Lm6YrYpyGIkGZF3BrHbnef7COwAnqg2u0rPkPV
         S13vc9/seZPKRGMkLHjOKNGZQV8GXBjy20WLrZDI=
Date:   Thu, 20 Jun 2019 21:17:37 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: No invalid histogram error
Message-Id: <20190620211737.993b09619af1fc58222549b4@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

I'm trying to use histogram on a synthetic event, but faced an odd situation.

There is a synthetic event, which has foo and bar.

/sys/kernel/debug/tracing # cat synthetic_events 
testevent	int foo; int bar

And when I tried to add hist on trigger, both foo and bar can be used as below.

/sys/kernel/debug/tracing # echo "hist:keys=bar" > events/synthetic/testevent/trigger 
/sys/kernel/debug/tracing # echo "hist:keys=foo" > events/synthetic/testevent/trigger 

And, when I missed to specify the sort key, it failed

/sys/kernel/debug/tracing # echo "hist:keys=foo:sort=bar" > events/synthetic/testevent/trigger 
sh: write error: Invalid argument

But no error on error_log file.

/sys/kernel/debug/tracing # cat error_log 
/sys/kernel/debug/tracing #

Could you add some error message? What about below?

[ 5422.134656] hist:synthetic:testevent: error: Sort key must be one of keys.
  Command: keys=foo;sort=bar
                               ^

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
