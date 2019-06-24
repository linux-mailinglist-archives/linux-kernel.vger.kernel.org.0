Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC8751C3F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 22:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731675AbfFXUZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 16:25:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49274 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfFXUZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 16:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AUV6wzqFGOvsTTeYrR44Nj82du0wTNXHOtoyFZVKw/Y=; b=j/0ZkCN2v0H11dfDEeqkL4AYn
        on/3Xy4NrfW7jBQyzTJWA8q1xmXX+StrLMqf7itI6KyaOrGm/x0YttA2qu5AUnttrPzKy0kXNeyzI
        zrysCBLf3ajYzaFYV1GV8ZFFBfxqJkaEwEk1b9Vv44nebFziM3nSZdzgs7/m+cc4gKLYm+bjcTiUo
        mh3fgd5Bqne+hZArmoUFHC32rHNtz9EwRZaBe37ZL1MWQQtWa8vBxM8pB6QTESvWNCJUNLI0l0FQy
        oiCHCDNRglo9Fn4hxR4bjWQuAfTYIRubPxlZHCNTuwDBA3GjsBxTUTe06cRg7a8rNFnFyUgEsHSGm
        xsMkSutDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfVWb-0003Yj-G7; Mon, 24 Jun 2019 20:25:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 11E5520A0EACA; Mon, 24 Jun 2019 22:25:12 +0200 (CEST)
Date:   Mon, 24 Jun 2019 22:25:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] get_maintainer: Add --cc option
Message-ID: <20190624202512.GK3436@hirez.programming.kicks-ass.net>
References: <20190624130323.14137-1-bigeasy@linutronix.de>
 <20190624133333.GW3419@hirez.programming.kicks-ass.net>
 <9528bb2c4455db9e130576120c8b985b9dd94e3d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9528bb2c4455db9e130576120c8b985b9dd94e3d.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 07:27:47AM -0700, Joe Perches wrote:
> On Mon, 2019-06-24 at 15:33 +0200, Peter Zijlstra wrote:
> > On Mon, Jun 24, 2019 at 03:03:23PM +0200, Sebastian Andrzej Siewior wrote:
> > > The --cc adds a Cc: prefix infront of the email address so it can be
> > > used by other Scripts directly instead of adding another wrapper for
> > > this.
> 
> Not sure I like the "--cc" option naming.
> Maybe "--prefix [string]" to be a bit more generic.
> 
> > Would it make sense to make '--cc' imply --no-roles --no-rolestats ?
> 
> Maybe.
> 
> It's also unlikely to be sensibly used with mailing
> lists so maybe --nol too.

Is there also an option to exclude moderated lists? --no-s doesn't seem
to do that. I hate it when people cross-post to moderated lists, and
this thing just made me do it :-(
