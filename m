Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0273D6381A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 16:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfGIOof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 10:44:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfGIOoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 10:44:34 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06ECC21537;
        Tue,  9 Jul 2019 14:44:32 +0000 (UTC)
Date:   Tue, 9 Jul 2019 10:44:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuahkhan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] selftests/ftrace: Select an existing function in
 kprobe_eventname test
Message-ID: <20190709104431.7599939c@gandalf.local.home>
In-Reply-To: <20190709214402.ffe8b206485dec2ec28eeb3a@kernel.org>
References: <20190322150923.1b58eca5@gandalf.local.home>
        <20190708191026.GA8307@calabresa>
        <20190708152214.0304ec7e@gandalf.local.home>
        <20190709214402.ffe8b206485dec2ec28eeb3a@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2019 21:44:02 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > Masami, can you ack this, and Shuah, can you take it?  
> 
> Yeah anyway,
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks Masami,

Shuah, want to take this in your tree?

-- Steve
