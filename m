Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2F0695445
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 04:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfHTCVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 22:21:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55504 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfHTCVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 22:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XRniKhucbREzKtZCAppPDHYVHZNQTFrUFsH0ZViDASg=; b=KOPX0kGUVTP34mCFG9W8ajekp
        YaF5rGM8zZoqnQkD2TbSA83ViWffHO3OphDb4LRDFaCbLj1dnbdz2mVLTJUP9gAHt8uynF6tP77AG
        ADYAaFiHPT8Ya+X5KSOGc9kKoNA3WDTtaFKt9U4osT3h7VynFeWL+WVi9//0g5pBstsYZwSR++n1q
        da51dkiEo3tFNEagEjPLmf4wXJwWA+pO3NBtZRAnuBDm90QLiAlFQUvV+eoKn9iLiuP4TpE37RwlZ
        i65Y1W/VX4RGTRfJzkWvZdz1YERydsa/02IERevelr6/1TeShGZLVbEc5JCjBIZ2ujBqpVGNaYkfw
        vjcSy5Fdw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hztll-0006CS-Qw; Tue, 20 Aug 2019 02:21:09 +0000
Date:   Mon, 19 Aug 2019 19:21:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch 03/44] posix-timer: Use a callback for cancel
 synchronization
Message-ID: <20190820022109.GB9594@infradead.org>
References: <20190819143141.221906747@linutronix.de>
 <20190819143801.656864506@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819143801.656864506@linutronix.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	if (!WARN_ON_ONCE(kc->timer_wait_running))
> +		kc->timer_wait_running(timer);

This looks weird. The only place calling yor new method only does so
after checking that it is not set and actually warns if it set?
