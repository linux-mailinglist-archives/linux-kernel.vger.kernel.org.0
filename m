Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 528DF11B97C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 18:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbfLKRAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 12:00:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:42046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730618AbfLKRAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 12:00:53 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D886B214AF;
        Wed, 11 Dec 2019 17:00:52 +0000 (UTC)
Date:   Wed, 11 Dec 2019 12:00:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     Sven Schnelle <svens@stackframe.org>,
        linux-trace-devel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: ftrace histogram sorting broken on BE architecures
Message-ID: <20191211120051.711582ee@gandalf.local.home>
In-Reply-To: <1576082238.2833.8.camel@kernel.org>
References: <20191211123316.GD12147@stackframe.org>
        <20191211103557.7bed6928@gandalf.local.home>
        <20191211110959.2baeb70f@gandalf.local.home>
        <1576082238.2833.8.camel@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2019 10:37:18 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> > Tom,
> > 
> > Correct me if I'm wrong, from what I can tell, all sums and keys are
> > u64 unless they are a string. Thus, I believe this patch should not
> > have any issues.  
> 
> The sums are u64, but the keys may not be.  I'll take a look and see,

Are they? I see in create_key_field:

	key_size = ALIGN(key_size, sizeof(u64));

Which to me seems that we'll have nothing smaller than sizeof(u64).

> but I'm out today and won't be able to look into it until tomorrow, if
> that's ok.

No rush.

I'll start the testing of this patch if you come back and say its
fine ;-) That takes a full day.

-- Steve
