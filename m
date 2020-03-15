Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7956E185AFA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 08:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgCOHP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Mar 2020 03:15:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49192 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgCOHPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 03:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3BhhTZicH5xUbUerK6S39AGPkNI7YnPjRrsBT526CMQ=; b=CQRW/NYZrTlkhwsxEGK/UEyp7U
        EJacQMfqh7Qly61NnnAx3ig5CyQGcCOsMqx3xE3whHvjx4gKSja3gkm/cum9Iua+msZURyLizBcvE
        LaUOECPuY5HCieYkfdKIe6aA1J40AVSw9fhf+E++17bM8jnlxi8gbs11xDu1Yg6TyiOiaetqyto5+
        +d8Z5Hm/jwQDAt2kLrEwxdY/iBOQGGO3UyYEnVcNxb/Wn+u3jhvKbr2aMEuJ4aePN2/sZAylo/GrI
        pOSmaEmcvusQtSp24ZYdqK7CsJf8YsztX/3NA8MjmgbHJtK8HHPu2YZy8q9gQ8Ez/2cZIoTxZ6pZN
        KSnuyDew==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jDIlK-0001lp-JA; Sun, 15 Mar 2020 02:12:22 +0000
Date:   Sat, 14 Mar 2020 19:12:22 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coding-style.rst: Add fallthrough as an emacs keyword
Message-ID: <20200315021222.GU22433@bombadil.infradead.org>
References: <7a2977ea9baacd1580ff80689f2c8f20d45b069d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a2977ea9baacd1580ff80689f2c8f20d45b069d.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 14, 2020 at 02:13:59PM -0700, Joe Perches wrote:
> I've no idea how to remove the infinite monkeys jibe from the chinese translation

I don't think you should.  That's part of Linus' original text, and I
don't think it deters contributors.

> -uses are less than desirable (in fact, they are worse than random
> -typing - an infinite number of monkeys typing into GNU emacs would never
> -make a good program).
> +uses are less than desirable.
