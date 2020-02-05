Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 187B3152444
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 01:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgBEAsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 19:48:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:35206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727673AbgBEAsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 19:48:06 -0500
Received: from oasis.local.home (unknown [213.120.252.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6E0B214AF;
        Wed,  5 Feb 2020 00:48:03 +0000 (UTC)
Date:   Tue, 4 Feb 2020 19:47:59 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] bootconfig: Only load bootconfig if "bootconfig" is
 on the kernel cmdline
Message-ID: <20200204194759.188eef89@oasis.local.home>
In-Reply-To: <20200205090610.fa3d0dcd5b2fea22e40991cf@kernel.org>
References: <20200204110446.2c2616cd@oasis.local.home>
        <20200205090610.fa3d0dcd5b2fea22e40991cf@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Feb 2020 09:06:10 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

>
> 
> Thanks for adding this feature :) This looks good to me.
> Please add my ack when you fix the error message of "config=bootconfig".

I'm changing it to just "bootconfig", is that OK with you?

-- Steve

> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Thank you!
> 
