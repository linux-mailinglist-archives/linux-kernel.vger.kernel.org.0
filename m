Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC509E524C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 19:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409985AbfJYR3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 13:29:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:33728 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388862AbfJYR3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 13:29:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9CA70AEFF;
        Fri, 25 Oct 2019 17:29:11 +0000 (UTC)
Date:   Fri, 25 Oct 2019 10:27:49 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH -tip] locking/mutex: Complain upon api misuse wrt
 interrupt context
Message-ID: <20191025172749.ugi3hcehqbldit7i@linux-p48b>
References: <20191025033634.3330-1-dave@stgolabs.net>
 <20191025081037.GF4131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191025081037.GF4131@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Oct 2019, Peter Zijlstra wrote:
>No real objection, but should not lockdep already complain about this?
>__mutex_unlock_slowpath() takes ->wait_lock irq-unsafe, so then using it
>from an IRQ should generate an insta IRQ inversion report.

But we still have the unlock fastpath and the trylock scenarios which
don't take locks.

Thanks,
davidlohr
