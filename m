Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E643695439
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 04:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbfHTCSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 22:18:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55424 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbfHTCSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 22:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Tp82Oys/nScyrDH/CuhI9QgzS0XZpkXnLw5V4Yw1ea0=; b=hba94z2Dtx8XP+8apmc+0TyMn
        7O1HrIgrwlsxMtl2/Kadn1ztJ3+Cj5S502/duMphnlNzqq5KXLxhJIR7Y+24vxiOXb4rd2u4IEl2R
        JH24+eMmEFlmGnQ91QQlAcjriBCFOqkchXXMDYja4jIWseOfYF0LknPIk6IKSkZ8dHIrfLOoP/l95
        xnw8huZyC7rGiDsp5PKSlSVmZrjPBOSWzpXYMYUZHJRmcLpTF/yO3bCMG3CDOp4azuNm5o0usH7ho
        xcIaH+SY4EiRizq507osu6+Kv+D8omsBxWOfusGGk+neoJFP8NlZ27jGkCMzzcNNBe0lta60AWh6A
        P3ojKujdg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hztjJ-0004vh-Ax; Tue, 20 Aug 2019 02:18:37 +0000
Date:   Mon, 19 Aug 2019 19:18:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch 00/44] posix-cpu-timers: Cleanup and consolidation
Message-ID: <20190820021837.GA9594@infradead.org>
References: <20190819143141.221906747@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819143141.221906747@linutronix.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 04:31:41PM +0200, Thomas Gleixner wrote:
> The series applies on top of:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
> 
> and is available from git as well:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.timers/core

It seems like this basically reverts the last patch in timers/core
again.  Do you really want to keep that or start with a better baseline?
