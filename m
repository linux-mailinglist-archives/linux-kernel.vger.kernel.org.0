Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 178721126C1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 10:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfLDJO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 04:14:59 -0500
Received: from merlin.infradead.org ([205.233.59.134]:59088 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfLDJO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 04:14:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ze/GQOZbaeIXq6JrvkaIDBtmgtEHGOqhn5uCBmHdF9g=; b=id/Ecr3j6GF6mMKEOyen8Zi4c
        ZQ2Hd5tPDJBwLZc/1pkGYkD+iBSsAQjoAcRHL0meYWETEg+5fAKNzggdRXasllVFYixIUDovMIXlI
        9WR5O2fCD1BD7AN4iep+oGGnNwmmO37K2xbq9gVp9QaxjWPdyv6tm6h7Bve4bJxoI6Psi6lxnUoM8
        9Wk4r6FmcLxTt/8E6HL9fkWfwKG1+FbPNizYmhb2q5vwFrWaBOVDN50hdzbGzkEk7aVUov0yGByfN
        PE7hBxHExDrKIZlEIUF9Q9joRxqucpMp1xvSRUHCzGqdOmDcf35Cqm2XGnusm380JRp+0pjlqFqKX
        bRcBUMAEw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1icQkH-00042f-Em; Wed, 04 Dec 2019 09:14:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BDFE33006E3;
        Wed,  4 Dec 2019 10:13:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 49078200A908B; Wed,  4 Dec 2019 10:14:50 +0100 (CET)
Date:   Wed, 4 Dec 2019 10:14:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86: Optimise x86 IP checksum code
Message-ID: <20191204091450.GQ2844@hirez.programming.kicks-ass.net>
References: <c92db041c78e4d81a70aaf4249393901@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c92db041c78e4d81a70aaf4249393901@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 11:52:09AM +0000, David Laight wrote:

> I did get about 12 bytes/clock using adox/adcx but that would need run-time
> patching and some AMD cpu that support the instructions run them very slowly.

Isn't that was we have alternative_call() for?
