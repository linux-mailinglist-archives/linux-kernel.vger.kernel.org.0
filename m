Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE0C511BCD8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 20:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbfLKT0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 14:26:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:59830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfLKT0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 14:26:05 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9F8F20836;
        Wed, 11 Dec 2019 19:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576092365;
        bh=ogOM2KoOKE3GWBSMbQW90cGC/wifD+Cza71yanM54lk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YdJvLdJmTdyrazqy5/ba/amy0ASA9/7joFIdlcr6k/Vna8On6CaBhnzsbv7R9ySiv
         6qCnMkjB1bWCiQTf1nHpm9dwzHlqRskdaxtLYFraSizqj2SgJGBajTJLYZJh0Lr7hL
         iq7nuFZEZ55pBHotx18SoWGS/3aUIzRfEQ7XbOMs=
Message-ID: <1576092363.2833.20.camel@kernel.org>
Subject: Re: ftrace histogram sorting broken on BE architecures
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sven Schnelle <svens@stackframe.org>,
        linux-trace-devel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 11 Dec 2019 13:26:03 -0600
In-Reply-To: <20191211120051.711582ee@gandalf.local.home>
References: <20191211123316.GD12147@stackframe.org>
         <20191211103557.7bed6928@gandalf.local.home>
         <20191211110959.2baeb70f@gandalf.local.home>
         <1576082238.2833.8.camel@kernel.org>
         <20191211120051.711582ee@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Wed, 2019-12-11 at 12:00 -0500, Steven Rostedt wrote:
> On Wed, 11 Dec 2019 10:37:18 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > > Tom,
> > > 
> > > Correct me if I'm wrong, from what I can tell, all sums and keys
> > > are
> > > u64 unless they are a string. Thus, I believe this patch should
> > > not
> > > have any issues.  
> > 
> > The sums are u64, but the keys may not be.  I'll take a look and
> > see,
> 
> Are they? I see in create_key_field:
> 
> 	key_size = ALIGN(key_size, sizeof(u64));
> 
> Which to me seems that we'll have nothing smaller than sizeof(u64).
> 

Yeah, that makes them effectively u64 in this case, so I'd agree.

Tom

