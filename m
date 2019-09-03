Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC803A66DE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 12:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbfICKzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 06:55:41 -0400
Received: from nautica.notk.org ([91.121.71.147]:33023 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727969AbfICKzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 06:55:41 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id EAF20C009; Tue,  3 Sep 2019 12:55:38 +0200 (CEST)
Date:   Tue, 3 Sep 2019 12:55:23 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     ericvh@gmail.com, lucho@ionkov.net, davem@davemloft.net,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: 9p: Fix possible null-pointer dereferences in
 p9_cm_event_handler()
Message-ID: <20190903105523.GA29600@nautica>
References: <20190724103948.5834-1-baijiaju1990@gmail.com>
 <20190724125545.GA12982@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190724125545.GA12982@nautica>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jia-Ju,

Dominique Martinet wrote on Wed, Jul 24, 2019:
> Jia-Ju Bai wrote on Wed, Jul 24, 2019:
> > In p9_cm_event_handler(), there is an if statement on 260 to check
> > whether rdma is NULL, which indicates that rdma can be NULL.
> > If so, using rdma->xxx may cause a possible null-pointer dereference.
> 
> The final dereference (complete(&rdma->cm_done) line 285) has been here
> from the start, so we would have seen crashes by now if rdma could be
> null at this point.
> 
> Let's do it the other way around and remove the useless "if (rdma)" that
> has been here from day 1 instead ; I basically did the same with
> c->status a few months ago (from a coverity report)...

Did you get anywhere with this, or should I submit a new patch myself ?
In the later case I'll tag this as Reported-by you

Thanks,
-- 
Dominique
