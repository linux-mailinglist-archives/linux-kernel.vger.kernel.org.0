Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98542B42D4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 23:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391740AbfIPVPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 17:15:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387936AbfIPVPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:15:21 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88C5F2067B;
        Mon, 16 Sep 2019 21:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568668520;
        bh=Fs0y9JUSlibTZQvWEwkI3pgQrXFhF7eBFqsDxaA/jOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E868grcQhSA7z77z9zijgFbKZyZy9rBCnjdX7lj4aowDSn7qsYgylHYGRUm+iLk82
         PJQ4V9HJNlPCI6IgSej8FnwjBRFRW1wlOk44aVmt1tjaFohzx9wYDi5bmhOBSZCvfR
         olJF01TzUKzHj8gz2TfA58gTf127xs9ZUaH5AN9I=
Date:   Mon, 16 Sep 2019 22:15:16 +0100
From:   Will Deacon <will@kernel.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, peterz@infradead.org
Subject: Re: [PATCH] mm: remove redundant assignment of entry
Message-ID: <20190916211516.znruqltoqdeq7pml@willie-the-truck>
References: <20190708082740.21111-1-richardw.yang@linux.intel.com>
 <20190914000326.h4ruqmyvo3yisf52@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190914000326.h4ruqmyvo3yisf52@master>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2019 at 12:03:26AM +0000, Wei Yang wrote:
> On Mon, Jul 08, 2019 at 04:27:40PM +0800, Wei Yang wrote:
> >Since ptent will not be changed after previous assignment of entry, it
> >is not necessary to do the assignment again.
> >
> 
> Sounds this one is lost in the time line :-)

Don't think so -- looks like it's in linux-next [1] via akpm to me.

Will

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=b47011719e5c05aa9dc78fe76a7e46075f422a45
