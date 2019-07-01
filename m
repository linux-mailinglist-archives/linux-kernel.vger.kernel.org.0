Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9A483501A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 21:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfFDTCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 15:02:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbfFDTCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 15:02:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84F622075C;
        Tue,  4 Jun 2019 19:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559674957;
        bh=OHd6h6SqmatjLqX221rCnsqaDitqTk1LE3dD1iixchA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HzDsQh8fhheFUMlik+jJwVJALLlFygf/JIbS8DkzuCyfzt+qdBxN2BbmZJcXac/Li
         u8x7K8VXEsFoq1p6801Qgo+njBOzvs89tzpoOOw6fsJNsdyxxBkBApAe84o4NGp09x
         1NkbtxzTs5KBL4oqaxEdNNv4IOLFylD+dCxkCm48=
Date:   Tue, 4 Jun 2019 21:02:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     Jiri Slaby <jslaby@suse.com>, Gen Zhang <blackgod016574@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "consolemap: Fix a memory leaking bug in
 drivers/tty/vt/consolemap.c"
Message-ID: <20190604190234.GA10572@kroah.com>
References: <20190604180039.gai2phwdxn7ias6n@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604180039.gai2phwdxn7ias6n@decadent.org.uk>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 07:00:39PM +0100, Ben Hutchings wrote:
> This reverts commit 84ecc2f6eb1cb12e6d44818f94fa49b50f06e6ac.
> 
> con_insert_unipair() is working with a sparse 3-dimensional array:
> 
> - p->uni_pgdir[] is the top layer
> - p1 points to a middle layer
> - p2 points to a bottom layer
> 
> If it needs to allocate a new middle layer, and then fails to allocate
> a new bottom layer, it would previously free only p2, and now it frees
> both p1 and p2.  But since the new middle layer was already registered
> in the top layer, it was not leaked.
> 
> However, if it looks up an *existing* middle layer and then fails to
> allocate a bottom layer, it now frees both p1 and p2 but does *not*
> free any other bottom layers under p1.  So it *introduces* a memory
> leak.
> 
> The error path also cleared the wrong index in p->uni_pgdir[],
> introducing a use-after-free.
> 
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>

Now applied, thanks.

Gen, please be careful with these types of "fixes"...

thanks,

greg k-h
