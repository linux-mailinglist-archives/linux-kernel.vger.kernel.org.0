Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45993CFC29
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 16:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfJHORC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 10:17:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41298 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfJHORB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l9Gyq38LaeYddeGuisMrwC7W1W2X2MQMdHRXsX7Odc8=; b=q7aOEk8jQ0RZ6MkcvlqcPH4v7
        kStA71izKvQ0vm0IUzZHhToJREX+IWGHtXbBkBmWzkbyCAm9pCUjZbR6kLYP1KTC7nvxBLkKUb17z
        dbtcLo96Hwfbjv672rvY/Brk8w9ZvvkRCB2BvvY1RbXWL840q3yzwexcWRk9bRpzBIoLFY9FX6d+0
        evXDuD9rBV/p4Vgr4rHw6JRUHwDNuuHjhdrZlyqWa+sQXx5MtoXSDwuKHZ7Qsu9cRt28HBuP27nun
        1jYa1VDKrmqS1eOcFAqPSDOtUzVzTt2DGzN5zsncKhkJji2uliDdtsPpt2Y2ZCWx9iooaEIafZO2B
        7z/6W7Qeg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHqI8-0001Qx-Fd; Tue, 08 Oct 2019 14:16:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7A106305EE1;
        Tue,  8 Oct 2019 16:15:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D8182202801A0; Tue,  8 Oct 2019 16:16:42 +0200 (CEST)
Date:   Tue, 8 Oct 2019 16:16:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Phil Auld <pauld@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v3 04/10] sched/fair: rework load_balance
Message-ID: <20191008141642.GQ2294@hirez.programming.kicks-ass.net>
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
 <1568878421-12301-5-git-send-email-vincent.guittot@linaro.org>
 <c752dd1a-731e-aae3-6a2c-aecf88901ac0@arm.com>
 <CAKfTPtBQNJfNmBqpuaefsLzsTrGxJ=2bTs+tRdbOAa9J3eKuVw@mail.gmail.com>
 <31cac0c1-98e4-c70e-e156-51a70813beff@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31cac0c1-98e4-c70e-e156-51a70813beff@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 11:47:59AM +0100, Valentin Schneider wrote:

> Yeah, right shift on signed negative values are implementation defined.

Seriously? Even under -fno-strict-overflow? There is a perfectly
sensible operation for signed shift right, this stuff should not be
undefined.
