Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C84E438E5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 17:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387846AbfFMPJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 11:09:41 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49624 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732353AbfFMN5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EfkBDDJMAt8xHDi7ZXze+FifO3HHeyNpCl8Ua4IB4Hw=; b=sJaw5Jvm/53ODTnP+j7SLhgVw
        uwOx8DIEUh/dq09/tZ/MYU0fn9HKlghiyako+Bm7U1uhJlNaGaqj+4T9n06SOri9YAsdvTzeRhR9L
        hIQL+s4VFH9fLFYpo+xs/c8LtyT1BrbAB0awMcEbrLYigGKn7yH3ZcMQovkPXlKyMBqHpe12uPgkR
        tstzCs2YS4vpXCa5kJTCGCdJgvztTxSeqN4vY+cajCasaKF924GBX1Qw85sBQznWR6jJcOVeDFHI/
        /ZaCPUcCYMgypt5VsamGB+j8LGrv2dXj9XbqMVYG4bVXLZM3DsrccxP8Ofb9aqB0d+4buTMN2i8SZ
        UVhFC5sxg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbQDy-0004GC-7a; Thu, 13 Jun 2019 13:57:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 01D8120316592; Thu, 13 Jun 2019 15:57:04 +0200 (CEST)
Message-Id: <20190613135445.318096781@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 13 Jun 2019 15:54:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, mingo@kernel.org, bp@alien8.de,
        tglx@linutronix.de, luto@kernel.org, namit@vmware.com,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] x86/percpu semantics and fixes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I still have these patches sitting in my queue and figured I'd repost them.

Last time Linus proposed a "+m" alternative approach, but that generates far
far worse code (I've lost the patch and not re-ran those numbers, but I suppose
I can redo if found important).

These patches have been through 0day for a while.

