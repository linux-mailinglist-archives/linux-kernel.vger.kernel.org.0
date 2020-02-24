Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 806D316A9C6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 16:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgBXPS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 10:18:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:43148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727448AbgBXPSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:18:25 -0500
Received: from tzanussi-mobl7 (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 944CC2082F;
        Mon, 24 Feb 2020 15:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582557505;
        bh=DLu6CZLAqXOcMgBMtSpGhIIlVElRiTBD+R4gl8NONQc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=U/uYHEDH/7IANEj/CJorA6T9DdSZroRnJMpGPMH5ukJ8OEnzjqhTVen3gJkNTfY/z
         VZHMMqdxVXLkGPPHBwcQhLwTanRCtAvkR7wO/PVXnZzv/sg3loHaaLoNbMatz3H1z4
         rxJIn+UqIX5hXLUj8mgkYOkqFYAg6SP4eiztbftw=
Message-ID: <1582557503.12738.22.camel@kernel.org>
Subject: Re: [PATCH RT 20/25] kmemleak: Cosmetic changes
From:   Tom Zanussi <zanussi@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>
Date:   Mon, 24 Feb 2020 09:18:23 -0600
In-Reply-To: <20200224091204.xzn6cheydarek6ex@linutronix.de>
References: <cover.1582320278.git.zanussi@kernel.org>
         <c3cf47877f79afa92634bf376488c8aa71378a26.1582320278.git.zanussi@kernel.org>
         <20200224091204.xzn6cheydarek6ex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-02-24 at 10:12 +0100, Sebastian Andrzej Siewior wrote:
> On 2020-02-21 15:24:48 [-0600], zanussi@kernel.org wrote:
> > From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > 
> > v4.14.170-rt75-rc1 stable review patch.
> > If anyone has any objections, please let me know.
> 
> This makes no sense to apply it. I updated my patch in the RT queue
> to
> what has been sent (and later merged) upstream. Then I was forced to
> sync the non-rebase branch with the rebase branch. This is the
> result.
> 
> What should be applied instead is
> 	fb2c57edcb943 ("kmemleak: Change the lock of kmemleak_object to
> raw_spinlock_t")
> 

I did apply that patch (as patch 14/25 of this series).  This patch
seemed like it was adding some comment bits mised for that one, which
is all it does.

Thanks,

Tom

> from the v4.19-RT branch.
> 
> Sebastian
