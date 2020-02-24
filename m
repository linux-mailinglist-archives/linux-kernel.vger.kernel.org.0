Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4E4216A98C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 16:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgBXPOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 10:14:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:41932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727299AbgBXPOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:14:19 -0500
Received: from tzanussi-mobl7 (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5528A20828;
        Mon, 24 Feb 2020 15:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582557259;
        bh=fjrJ1bXxE6cy57s9WJjc99A+mzqTea0xUG76BrG1oBA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mQVtAWY1hnbrVbe9qoer+1isR+6YqCZgdwgQx7lcCG5b0gcFdqTRxAwB0WPJqc7Hd
         8Sn6ionAWL5lPuB1Ve317rNIgnz+Sl+euEvXyVARyV2H3t9VhuzJYRjJBtmRtLzEPn
         kap9YCccoUxLEf4baQFZjyHIRyv7uUJeOZQVu9aU=
Message-ID: <1582557257.12738.19.camel@kernel.org>
Subject: Re: [PATCH RT 19/25] userfaultfd: Use a seqlock instead of seqcount
From:   Tom Zanussi <zanussi@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>
Date:   Mon, 24 Feb 2020 09:14:17 -0600
In-Reply-To: <20200224090317.shfeuxfukkvxvqaf@linutronix.de>
References: <cover.1582320278.git.zanussi@kernel.org>
         <889f5b989b28eb7b29f21092432948cd12d97c48.1582320278.git.zanussi@kernel.org>
         <20200224090317.shfeuxfukkvxvqaf@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-02-24 at 10:03 +0100, Sebastian Andrzej Siewior wrote:
> On 2020-02-21 15:24:47 [-0600], zanussi@kernel.org wrote:
> > From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > 
> > v4.14.170-rt75-rc1 stable review patch.
> > If anyone has any objections, please let me know.
> 
> This is required but it is not part of the next "higher" tree
> (v4.19-RT). Which means if someone moves from v4.14-RT to the next
> tree
> (v4.19-RT in this case) that someone would have the bug again.
> 
> Could you please wait with such patches or did the I miss the v4.19-
> RT
> tree with this change?
> 

No, you didn't miss the 4.19 tree with this change - I got a little
ahead of 4.19 this time.  Will drop all the patches ahead of 4.19.

Thanks,

Tom

> Sebastian
