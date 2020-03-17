Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5EAB1886EE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 15:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgCQOKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 10:10:10 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46588 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgCQOKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Bqv+/prboe8KB6HPWMsnaQmGMROTZ6mPlw8hYvqD134=; b=jOKzqxyyi78LtaoMb+wGjDpSyF
        /BMB/eRM49OuzK4n0TvU3RXARowYvEABzpOs1Uih4P3m7C1HnEWL8rHKE3ZNM02T1A1mM6ORoZyJl
        LdyT7P3h4z1dw7xw1/9AlDixwsLD3Bhpmm5TzE0bxSKb4RT6q0MxYS6hOh549vWZbaq+2FedUF/XD
        Z6vnyNJNtseD9XCT5Nwb7m32ppp4qR2HzdFdWMwzUwxVZK5PLUmHj+UPIJU9eUiuU771EYSvDnPuU
        r0JQMGzkpx2X00wWGL27mQ/gqJxQo7lAmoHJr+xqnAS9+XwXgMRQdEWOb1joqFaki0qlpr+qNvYCR
        5jwZGHOw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jECv0-00083z-TC; Tue, 17 Mar 2020 14:10:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2FA57300606;
        Tue, 17 Mar 2020 15:10:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1C20123D7668A; Tue, 17 Mar 2020 15:10:02 +0100 (CET)
Date:   Tue, 17 Mar 2020 15:10:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC][PATCH 08/16] Optimize find_section_by_name()
Message-ID: <20200317141002.GB20730@hirez.programming.kicks-ass.net>
References: <20200312134107.700205216@infradead.org>
 <20200312135041.875820323@infradead.org>
 <alpine.LSU.2.21.2003171321170.2339@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2003171321170.2339@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 01:22:23PM +0100, Miroslav Benes wrote:
> > @@ -193,6 +198,7 @@ static int read_sections(struct elf *elf
> >  		sec->len = sec->sh.sh_size;
> >  
> >  		hash_add(elf->section_hash, &sec->hash, sec->idx);
> > +		hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
> >  	}
> 
> Don't you need to the same in elf_create_section()?

Yes, already fixed. Noticed it yesterday when I was addressing Josh's
comments.

