Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC57B1B188
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 09:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfEMHzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 03:55:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52384 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbfEMHzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 03:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=o6Rg9AFzu3xtSgxocTnQYX1DHwYY26QqjZV0zMsV5zQ=; b=20sa5qkL4roz196zuNWMbOgko
        zyYrFWyBJbu9V8PhHZymhWNZqcSTplBpVeCN3VuYpOGqGFniF6Vt1wJjQ9k5e+DhH2JslBiCYVCd4
        i2qddjoUfD/tkXqbmRrW3w5G3l4aNBG25cXR+KTtQF+mjaV/jjypU+8GgWv2ILcpRmFPRB1dKIst7
        j4zcHMm6jIRf/sxtmgEZZx7M+mKjY7+bO+3d8F4TjO8oo31pTecy/NS8J7I76r2LyDQk+MwecQedQ
        nJ5ARVskbeDBAq1AlVWXnhLSj7DVTBVVjw5EEySiZjI1BBlC+T1sjWUQjZIedlAR9V2pieq4T9VE3
        5p+YeiAnQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQ5o8-0005Ge-JP; Mon, 13 May 2019 07:55:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 545E22029F87A; Mon, 13 May 2019 09:55:35 +0200 (CEST)
Date:   Mon, 13 May 2019 09:55:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Ingo Molnar <mingo@redhat.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: remove redundant assignment to variable utime
Message-ID: <20190513075535.GI2623@hirez.programming.kicks-ass.net>
References: <20190511131849.4513-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190511131849.4513-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2019 at 02:18:49PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable utime is being assigned a value however this is never
> read and later it is being reassigned to a new value. The assignment
> is redundant and hence can be removed.
> 
> Addresses-Coverity: ("Unused Value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Argh. not again.. still no.
