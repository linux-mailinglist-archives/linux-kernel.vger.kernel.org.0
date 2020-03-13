Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43C75184F29
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 20:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgCMTMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 15:12:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40624 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgCMTMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 15:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IYwsBCA3RlJjyCT5vgHWwzTArzfWqbEX6MfRxtkA8do=; b=dnKZDwrXPOQlabkaDb9KvL/owf
        QH44f99OsQmNHe5Iih+IjGnH7wPyrTzn7QOjhWO8bITtnKd0og7htH3zqWANOao+qAIB4lsajZ5qN
        oi2dqGt/W3jBcTjON2RUs3n5oOI0nUgDVt+WFcXDXaujgU8c1fKEVhQLss/1ii2kuLnYN/8YERkn+
        GXKuTkacDyTwIQCbZKe6YQiB57XogAN/fCkMTK1rk9zkArw/j+9Opkq1Od4id6hcWL89Qbs+sz88l
        ZqCf7mXeilh/wxZNVSr48X4K5+PTMuxOE16CFyBShHFBM00YyYe4zzAb0Nm0ae08GXaxj0n4bLfg6
        uldbRz1A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCpjA-0005fS-N9; Fri, 13 Mar 2020 19:12:12 +0000
Date:   Fri, 13 Mar 2020 12:12:12 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] radix-tree: fix a typo
Message-ID: <20200313191212.GN22433@bombadil.infradead.org>
References: <20200313184909.4560-1-hqjagain@gmail.com>
 <20200313184909.4560-3-hqjagain@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313184909.4560-3-hqjagain@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 14, 2020 at 02:49:09AM +0800, Qiujun Huang wrote:
> "iff" -> "if"

> - *	This function can be called under rcu_read_lock iff the slot is not
> + *	This function can be called under rcu_read_lock if the slot is not

That's not a typo, it's a mathematician's shorthand for "if and only if".
I'm not excited about fixing problems in the radix tree code; better to
focus efforts on migrating users to the xarray.

http://git.infradead.org/users/willy/linux-dax.git/shortlog/refs/heads/xarray-conv
is an out of date effort to do every user.
