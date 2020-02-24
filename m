Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09B3716A983
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 16:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgBXPMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 10:12:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:41496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727299AbgBXPMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:12:33 -0500
Received: from tzanussi-mobl7 (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC75F20828;
        Mon, 24 Feb 2020 15:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582557152;
        bh=AQYhxvZvMVrptS0QhvjHCAa/54ctaxS1WHoT3UinPzE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sd70c2dTlCALjNfgp3pTBEX6SynMPojLP5+NrY7Jo77NcR44fd78BGhxfyWgVb35i
         nHYwSnzIJCYJBD6uWDVA69Sfn83YP6lS+HD6mZO+cUWFTEo6xULhT4ma3oF+jgyzbQ
         PTA22AGjgNNlYwpskfVJOJClB2uBxoi85y0RpvZw=
Message-ID: <1582557150.12738.17.camel@kernel.org>
Subject: Re: [PATCH RT 17/25] x86/fpu: Don't cache access to
 fpu_fpregs_owner_ctx
From:   Tom Zanussi <zanussi@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>
Date:   Mon, 24 Feb 2020 09:12:30 -0600
In-Reply-To: <20200224085500.nub2zjcucwx2nwiw@linutronix.de>
References: <cover.1582320278.git.zanussi@kernel.org>
         <25549e4ff2e5d78e663cf6e5cd8ed108ef03ff44.1582320278.git.zanussi@kernel.org>
         <20200224085500.nub2zjcucwx2nwiw@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

Thanks for reviewing these..

On Mon, 2020-02-24 at 09:55 +0100, Sebastian Andrzej Siewior wrote:
> On 2020-02-21 15:24:45 [-0600], zanussi@kernel.org wrote:
> > From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > 
> > v4.14.170-rt75-rc1 stable review patch.
> > If anyone has any objections, please let me know.
> 
> Please don't apply this for the reasons I mentioned in
> 	https://lkml.kernel.org/r/20200122084352.nyqnlfaumjgnvgih@linut
> ronix.de
> 

Yeah, I missed this comment on the 4.19 series (somehow the patch
itself shows as 'not found' in the archives).

Will drop.

Thanks,

Tom

> I guess they still apply (haven't checked).
> 
> Sebastian
