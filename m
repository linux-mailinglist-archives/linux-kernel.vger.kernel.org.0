Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECAE07B4D5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 23:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387610AbfG3VMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 17:12:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56302 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387589AbfG3VMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 17:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AGT1mgQtN5O2bIid/hu8bvBZ4cnh5dILbEAlwsJ2UQI=; b=Y32wwVnvQptTDs1tFyneR3G+v
        mM09R9HulyVgjPBUUvr8xYdw0iAywC8XTUoto27LWdETdu6cMXiIEYMe6HAQN/M6gAQ/g2Cbg0yQn
        3fpFyyN23da2X4h3s6VHWClcpcdb//FHKWbceFK9m2xYm3qMoZrWqsXMCr49TGeDnr4W4PLH9dTan
        SaLXDygYI/LTJprMuzBRgf1b65Jdq6py0lYFyIqDC5qTvndXNd6MonX3+Ce0RwLXGoEx7Lptycoph
        L+ayjFvfARUkUtE9FuBke2CMMTzM19vXEJoEO2SWaqSEcu7Lk5tIISOeM9i3F1mZVFuhvjUD/rKCw
        86w0BqZoQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hsZQQ-00076B-UB; Tue, 30 Jul 2019 21:12:50 +0000
Date:   Tue, 30 Jul 2019 14:12:50 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Tri Vo <trong@android.com>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] idr: Document calling context for IDA APIs mustn't use
 locks
Message-ID: <20190730211250.GD4700@bombadil.infradead.org>
References: <20190730210752.157700-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730210752.157700-1-swboyd@chromium.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 02:07:52PM -0700, Stephen Boyd wrote:
> The documentation for these functions indicates that callers don't need
> to hold a lock while calling them, but that documentation is only in one
> place under "IDA Usage". Let's state the same information on each IDA
> function so that it's clear what the calling context requires.
> Furthermore, let's document ida_simple_get() with the same information
> so that callers know how this API works.

I don't want people to use ida_simple_get() any more.  Use ida_alloc()
instead.

> - * Context: Any context.
> + * Context: Any context. It is safe to call this function without
> + * synchronisation in your code.

I prefer "without locking" to "without synchronisation" ...

