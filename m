Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22F8EFC9E3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 16:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfKNPZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 10:25:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:53748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbfKNPZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:25:53 -0500
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1399B206DC;
        Thu, 14 Nov 2019 15:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573745152;
        bh=3HN4CJA/3Iu8rHfBrlxotRbLmMG3aBOp/hgOx0NMsVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2SxLeD8A1x7/szpLe9JAjdGb9xWF7gVSVYgWB8Kba1GvrQt5m8b9buOIE5tWI+9yD
         mONY5LAaU6Wfsq7hZMSl61NIgGBVFxnjmaYXQy+S+oC0yQE3b4Jw2r4EkDOdvIL2nA
         tXPexsq6vuvT3InlPlEAJPvFU6dtWfNtF7jfo5GM=
Date:   Thu, 14 Nov 2019 16:25:49 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Pavel Machek <pavel@ucw.cz>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH 0/9] sched/nohz: Make the rest of kcpustat vtime aware
Message-ID: <20191114152548.GA17724@lenoir>
References: <20191106030807.31091-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106030807.31091-1-frederic@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 04:07:58AM +0100, Frederic Weisbecker wrote:
> So we fixed CPUTIME_SYSTEM on nohz_full, now is the turn for
> CPUTIME_USER, CPUTIME_NICE, CPUTIME_GUEST and CPUTIME_GUEST_NICE.
> 
> The tricky piece was to handle "nice-ness" correctly. I think I addressed
> most reviews (one year ago now) from peterz
> (https://lore.kernel.org/lkml/20181120141754.GW2131@hirez.programming.kicks-ass.net/)
> Among which:
> 
> * Merge patches that didn't make sense together
> * Clarify the changelog (I hope) and add comments
> * Also hook nice updates on __setscheduler_params()
> * Uninline a big function

Gentle ping :)
