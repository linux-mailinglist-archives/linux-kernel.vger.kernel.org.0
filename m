Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6889916AA81
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 16:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgBXPwh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Feb 2020 10:52:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50465 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbgBXPwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:52:37 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1j6G26-0006oN-7y; Mon, 24 Feb 2020 16:52:34 +0100
Date:   Mon, 24 Feb 2020 16:52:34 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH RT 20/25] kmemleak: Cosmetic changes
Message-ID: <20200224155234.brdcpecpfboyjjon@linutronix.de>
References: <cover.1582320278.git.zanussi@kernel.org>
 <c3cf47877f79afa92634bf376488c8aa71378a26.1582320278.git.zanussi@kernel.org>
 <20200224091204.xzn6cheydarek6ex@linutronix.de>
 <1582557503.12738.22.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1582557503.12738.22.camel@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-24 09:18:23 [-0600], Tom Zanussi wrote:
> > What should be applied instead is
> > 	fb2c57edcb943 ("kmemleak: Change the lock of kmemleak_object to
> > raw_spinlock_t")
> > 
> 
> I did apply that patch (as patch 14/25 of this series).  This patch
> seemed like it was adding some comment bits mised for that one, which
> is all it does.

Bah. So I saw that (#14/25), considered okay but while looking at this
patch I was comparing against v4.14.164-rt73 and forgot about it…

> Thanks,
> 
> Tom

Sebastian.
