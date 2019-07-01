Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3295D42DB6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 19:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388068AbfFLRwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 13:52:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40352 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387793AbfFLRwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JMNn8UaGTOpyvj+ruZQU6xAEQkuuPXT/CSFoXKWYSTg=; b=nvZjGRppi4S3cpkBc8m3JTdjYT
        FWvUaQjWBjaIvXGpfqmjKo+Q9hH5l0xcbBIV/CXd3TSGC61MPcEwsYCZsFfFXOuakydSmKugeufPf
        JNZaEvrbxhA/Z266bAXOLvQHdSveVg/oracJB21QFYlYZ/I+9z0DfQDjNc95GsKWzwE15QpwT5Kd7
        AmPiGw0s7bcI9sIYy5/s4A0h8bIilnzuUL1j0jXG/uJf27lvXKDtN8c1Y0lNyI/thm2y9JLKuR7KI
        aXpFuM+DYb8bDPtreaoucaSo64FMPAW4x2PsGTaKbEGv0eYRaqAeuJd73+Mr8atVnNZc1vEvsnkDw
        srPlKzPg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hb7Pj-0002AT-Un; Wed, 12 Jun 2019 17:51:59 +0000
Date:   Wed, 12 Jun 2019 10:51:59 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     gorcunov@gmail.com, linux-mm@kvack.org,
        Laurent Dufour <ldufour@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [RFC PATCH] binfmt_elf: Protect mm_struct access with mmap_sem
Message-ID: <20190612175159.GF32656@bombadil.infradead.org>
References: <20190612142811.24894-1-mkoutny@suse.com>
 <20190612170034.GE32656@bombadil.infradead.org>
 <20190612172914.GC9638@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190612172914.GC9638@blackbody.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 07:29:15PM +0200, Michal Koutn� wrote:
> On Wed, Jun 12, 2019 at 10:00:34AM -0700, Matthew Wilcox <willy@infradead.org> wrote:
> > On Wed, Jun 12, 2019 at 04:28:11PM +0200, Michal Koutn� wrote:
> > > -	/* N.B. passed_fileno might not be initialized? */
> > > +
> > 
> > Why did you delete this comment?
> The variable got removed in
>     d20894a23708 ("Remove a.out interpreter support in ELF loader")
> so it is not relevant anymore.

Better put that in the changelog for v2 then.  or even make it a
separate patch.

