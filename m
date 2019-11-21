Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 574B9105248
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 13:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfKUMay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 07:30:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35884 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfKUMay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 07:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SHnW3DpA9GShnJzkqm3FRZ8Dv49uP+5rhGD1oRyhB/U=; b=NKT21b6rhvpl86JwDqjPxioRJ
        vVxpx148pLNeM3D5oTxYsMI3opwNCkk8nc2QenVqUlDXh6kRNDj9BhkkgjzmnBnHygx5GnD285XRY
        lYhnPaRbNzvCNdSJ8YB4p9jjxgE4Z4u3X+7ndzHAtvFezqOH1B/unF6+QV518ZOvTzD48GomZaW18
        SZS0YfRdYVdEU7/AqUa6OhVBy5ctO0DV7Khdo4m5TxjkcpghGlbRL8rCG5r9Qr+dL2YUrrpsPuKo1
        2CRS0K6BW83FyuirEz6RDgIT4nKMwQsPn2ntQG0xHm+3y9spOc8QARudH2PTJH3nbQZO5QOnG2sv1
        Vg73jEs+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iXlbn-0003sd-7d; Thu, 21 Nov 2019 12:30:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1FEC030068E;
        Thu, 21 Nov 2019 13:29:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 02224201DD6AF; Thu, 21 Nov 2019 13:30:48 +0100 (CET)
Date:   Thu, 21 Nov 2019 13:30:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     YT Chang <yt.chang@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/1] sched: panic, when call schedule with preemption
 disable
Message-ID: <20191121123048.GQ4097@hirez.programming.kicks-ass.net>
References: <1574323985-24193-1-git-send-email-yt.chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574323985-24193-1-git-send-email-yt.chang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 04:13:05PM +0800, YT Chang wrote:
> When preemption is disable, call schedule() is incorrect behavior.
> Suggest to panic directly rather than depend on panic_on_warn.

Why!?
