Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 795342CA56
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 17:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfE1PaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 11:30:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbfE1PaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:30:00 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3192E20883;
        Tue, 28 May 2019 15:29:59 +0000 (UTC)
Date:   Tue, 28 May 2019 11:29:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trace: Avoid memory leak in predicate_parse()
Message-ID: <20190528112956.4cf2dd9c@gandalf.local.home>
In-Reply-To: <1a9137e1-bcc3-787f-267c-8b76dea41fbb@gmail.com>
References: <20190528134659.4041-1-tomasbortoli@gmail.com>
        <20190528104400.388e4c3f@gandalf.local.home>
        <1a9137e1-bcc3-787f-267c-8b76dea41fbb@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 May 2019 17:18:59 +0200
Tomas Bortoli <tomasbortoli@gmail.com> wrote:

> >> +	memset(prog_stack, 0, nr_preds * sizeof(*prog_stack));
> >> +  
> > 
> > Can you instead just switch the allocation of prog_stack to use
> > kcalloc()?  
> 
> kmalloc_array() is safe against arithmetic overflow of the arguments.
> Using kcalloc() directly we wouldn't check for that. Not really ideal in
> my opinion. And there's no kcalloc_array() apparently!

But doesn't kcalloc() simply call kmalloc_array() with the GFP_ZERO
flag?

-- Steve
