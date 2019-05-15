Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5756E1EFB5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 13:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733022AbfEOLe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 07:34:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727283AbfEOLeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:34:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 522922053B;
        Wed, 15 May 2019 11:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557920064;
        bh=UKdAqxo5hGOoDMAl9NLSkpt4zg9p5OCAItHb4xUscto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0INscPJUwspjjab4+Ys0uyPkmH3TYHvz0F5xmbtnQ+A6D3MDwqBqNrbGh64zhPHAH
         qkrpQ3WdcqkqAIQNM97IqfuuML5BH9yZH5XjOzjncOvYvGckk/vCJnSBkG+x4QATpQ
         Te7wIAaisgKKB5rhWXwslNrfah0Qp0vHk/YHWt+4=
Date:   Wed, 15 May 2019 13:30:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Remove double free
Message-ID: <20190515113019.GB11749@kroah.com>
References: <20190515090750.30647-1-tobin@kernel.org>
 <aa001c3b-f96e-2078-0861-315613ec33a0@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa001c3b-f96e-2078-0861-315613ec33a0@c-s.fr>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 11:26:03AM +0200, Christophe Leroy wrote:
> kobject_put() released index_dir->kobj

Yes, but what is that kobject enclosed in?

> but who will release 'index' ?

The final kobject_put() will do that, see cacheinfo_create_index_dir()
for the details.

And please do not top-post, you lost all context.

greg k-h
