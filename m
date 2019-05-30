Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 832F02E998
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 02:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfE3AEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 20:04:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60058 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbfE3AEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 20:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oe7K7F0pG65IkqAKU9Ch52bqIbMoGlTq/PyErndd9/w=; b=IPJmI3M5EEqxfWWOneEy2WCON
        1EWRboyUjtgShu9FvjzbUo0xAy7RsCkCe5gkqlRqef8V/pCheFYG57TdZShbM3O/19Vv6RsLXJ/7v
        qr/JdpWLxXGepupO3S83gaZ2RkDgeS7KbEb64ZAfW+8rkAu9FHXIQH1KHv5xBLCE6VEmhl1FJwjRi
        57LCEK5vvzeUTId2ka7faHiB7cbdqnkH5bVkQV2jeVBdXyuWSmocIO3WvLws2Qz1l+2/ouri7xqiV
        AKDB+EH3OC/StCkNTaVM0koFSywjYhhRUPoAHBcsNpDe57v2UpwGUkDzuIIOgeUT62Oog80FlThe5
        L27gHa4nQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW8Yo-00023c-3a; Thu, 30 May 2019 00:04:46 +0000
Date:   Wed, 29 May 2019 17:04:45 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     dianzhangchen0@gmail.com, linux-kernel@vger.kernel.org,
        mhocko@kernel.org
Subject: Re: [PATCH] mm/slab_common.c: fix possible spectre-v1 in
 kmalloc_slab()
Message-ID: <20190530000445.GB23461@bombadil.infradead.org>
References: <20190529203106.GA26268@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529203106.GA26268@avx2>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 11:31:06PM +0300, Alexey Dobriyan wrote:
> > I think it makes more sense to sanitize size in size_index_elem(),
> > don't you?
> 
> > -	return (bytes - 1) / 8;
> > +	return array_index_nospec((bytes - 1) / 8, ARRAY_SIZE(size_index));
> 
> I think it should be fixed in poll.
> Literally every small variable kmalloc call is going through this function.

We could do that too, but don't we then have to audit every ioctl and
similar to see if there's a k(v)malloc based on a size passed from
userspace?
