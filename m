Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7BD79E8E1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 15:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfH0NRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 09:17:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfH0NRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:17:32 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41C86206BF;
        Tue, 27 Aug 2019 13:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566911851;
        bh=gBY1Hf6Ol8oNw7i9sKfkkUV86Bt0XlKupuLcyhWkc3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2Y8Lm6DjGIhFxEi+Vbcu4R56+GWnALp0VlF30VdY2vZHrCodSt4vuQgg3KuXml8gj
         1kOWtaVaNjDjbvmjm0OaRVvQ1fuXAiVb4bfPiEtMR1jctZSl0kkljmcnVfGebTD3nZ
         uRgUzmB9n0y4WJxgz1WA8rdzxJvjHD+BhAdhD7d0=
Date:   Tue, 27 Aug 2019 15:17:28 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 38/38] posix-cpu-timers: Utilize timerqueue for storage
Message-ID: <20190827131727.GA25843@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192922.835676817@linutronix.de>
 <20190827004846.GM14309@lenoir>
 <alpine.DEB.2.21.1908270807080.1939@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908270807080.1939@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 08:08:06AM +0200, Thomas Gleixner wrote:
> On Tue, 27 Aug 2019, Frederic Weisbecker wrote:
> 
> > On Wed, Aug 21, 2019 at 09:09:25PM +0200, Thomas Gleixner wrote:
> > >  /**
> > > @@ -92,14 +130,10 @@ struct posix_cputimers {
> > >  
> > >  static inline void posix_cputimers_init(struct posix_cputimers *pct)
> > >  {
> > > -	pct->timers_active = 0;
> > > -	pct->expiry_active = 0;
> > 
> > No more need to initialize these?
> > 
> > > +	memset(pct->bases, 0, sizeof(pct->bases));
> 
> memset() does that IIRC :)

But those two fields aren't part of pct->bases, are they? :)
