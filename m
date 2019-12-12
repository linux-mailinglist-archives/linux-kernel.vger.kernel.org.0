Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0AE511D4E2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 19:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbfLLSHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 13:07:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:55324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730305AbfLLSHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:07:32 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AE2D21556;
        Thu, 12 Dec 2019 18:07:31 +0000 (UTC)
Date:   Thu, 12 Dec 2019 13:07:29 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     Sven Schnelle <svens@stackframe.org>,
        linux-trace-devel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: ftrace histogram sorting broken on BE architecures
Message-ID: <20191212130729.05091d3a@gandalf.local.home>
In-Reply-To: <1576092363.2833.20.camel@kernel.org>
References: <20191211123316.GD12147@stackframe.org>
        <20191211103557.7bed6928@gandalf.local.home>
        <20191211110959.2baeb70f@gandalf.local.home>
        <1576082238.2833.8.camel@kernel.org>
        <20191211120051.711582ee@gandalf.local.home>
        <1576092363.2833.20.camel@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2019 13:26:03 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> > Are they? I see in create_key_field:
> > 
> > 	key_size = ALIGN(key_size, sizeof(u64));
> > 
> > Which to me seems that we'll have nothing smaller than sizeof(u64).
> >   
> 
> Yeah, that makes them effectively u64 in this case, so I'd agree.

Hi Tom,

Does this mean it's good to go? It just passed my test suite, and I can
send it to Linus now.

-- Steve
