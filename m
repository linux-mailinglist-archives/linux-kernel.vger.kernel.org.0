Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B76156E4C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 18:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfFZQEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 12:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfFZQEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 12:04:15 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09AAE217D7;
        Wed, 26 Jun 2019 16:04:13 +0000 (UTC)
Date:   Wed, 26 Jun 2019 12:04:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Preisner <linux@tpreisner.de>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: add simple oneshot function tracer
Message-ID: <20190626120412.662e8cf9@gandalf.local.home>
In-Reply-To: <20190623120555.nka2357agpqovxla@stud.informatik.uni-erlangen.de>
References: <20190529104552.146fa97c@oasis.local.home>
        <20190612212935.4xq6dyua5d5vrrvj@stud.informatik.uni-erlangen.de>
        <20190617201627.647547c7@gandalf.local.home>
        <20190623120555.nka2357agpqovxla@stud.informatik.uni-erlangen.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jun 2019 14:05:55 +0200
Thomas Preisner <linux@tpreisner.de> wrote:


> I've created this tracer with kernel tailoring in mind since the
> tailoring process of e.g. undertaker heavily benefits from a more
> precise set of input data.
> 
> A "oneshot" option for the function tracer would be a viable
> possibility. However, this may add a lot of overhead (performance wise)
> in comparison to my current approach? After all, the use case of my
> tracer would be some sort of kernel activity monitoring during "normal
> usage" in order to get a grasp of (hopefully) all required kernel
> functions.

Coming back from vacation and not having this threaded in my inbox,
I have to ask (to help cache this back into my head), what was the
"current approach" compared to the "oneshot" option, and why would it
have better performance?

> 
> Also, there is no strong reason to add a new event type,
> this was just a means of reducing the collected data (which may as well
> be omitted since there is no real benefit).

+1

> 
> My "oneshot tracer" actually collects and outputs every parent in order
> to get a more thorough view on used kernel code. Therefore, I would
> suggest to keep this functionality and maybe make it configurable
> instead?

Configure which? (again, coming back from vacation, I need a refresher
on this ;-)

-- Steve
