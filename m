Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5769F14A842
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 17:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgA0Qn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 11:43:28 -0500
Received: from merlin.infradead.org ([205.233.59.134]:32874 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgA0Qn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 11:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Vo59eazjRN9sneTR+TOn1f5NbzjmTTR7B8rU8RzqXXU=; b=1dIs81Dx7J9GgAIEAO9HVNkRP
        uQKS7xWl7JJhT2lhszNuSVVue3njNwM03cbfw/gdBhKDlJfoaakqAtPGdwBLy49ttaLwADkZNxIAF
        //hoEN+Ccz0/0rgEPpEdM8wEy6B5P8YPlhYcMt0TdFxX/NxExTCsys5FCHC1oZt2Xxn8KMzTX8CPj
        9y6+DbiiingFpUeAKsCQh5lQQXrgvVxnMTDfq/rx7UHtYdSLnHBkoZ49ozuTpGwf9SXs1ocN8Dy/a
        0ch7UpcK1OLmg0gNiea2/CW7PADInoiTelMso6CqOB5UVfl+1/ErclOha/f9zGiGdwqqsF3ZY4tZY
        tOL/NOMNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iw7Tq-0002J8-FO; Mon, 27 Jan 2020 16:43:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E824D302C0F;
        Mon, 27 Jan 2020 17:41:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E1DE720146B7B; Mon, 27 Jan 2020 17:43:15 +0100 (CET)
Date:   Mon, 27 Jan 2020 17:43:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Juri Lelli <juri.lelli@gmail.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3]sched/rt: Stop for_each_process_thread() iterations in
 tg_has_rt_tasks()
Message-ID: <20200127164315.GJ14879@hirez.programming.kicks-ass.net>
References: <152415882713.2054.8734093066910722403.stgit@localhost.localdomain>
 <20180420092540.GG24599@localhost.localdomain>
 <0d7fbdab-b972-7f86-4090-b49f9315c868@virtuozzo.com>
 <854a5fb1-a9c1-023f-55ec-17fa14ad07d5@virtuozzo.com>
 <20180425194915.GH4064@hirez.programming.kicks-ass.net>
 <9f76872b-85e6-63bd-e503-fcaec69e28e3@virtuozzo.com>
 <20200123215616.GA14789@pauld.bos.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123215616.GA14789@pauld.bos.csb>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 04:56:19PM -0500, Phil Auld wrote:
> Peter, is there any chance of taking something like this?

Whoopsy, looks like this fell on the floor. Can do I suppose.

Thanks!
