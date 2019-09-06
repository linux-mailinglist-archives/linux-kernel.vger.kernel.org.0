Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E33CABA22
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 16:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393928AbfIFOCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 10:02:02 -0400
Received: from nautica.notk.org ([91.121.71.147]:53183 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388583AbfIFOCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:02:02 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 74656C009; Fri,  6 Sep 2019 16:02:00 +0200 (CEST)
Date:   Fri, 6 Sep 2019 16:01:45 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: make two arrays static const, makes object smaller
Message-ID: <20190906140145.GA16910@nautica>
References: <20190906133812.17196-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190906133812.17196-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin King wrote on Fri, Sep 06, 2019:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the arrays on the stack but instead make them
> static const. Makes the object code smaller by 386 bytes.
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   17443	   2076	      0	  19519	   4c3f	fs/9p/vfs_inode_dotl.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>   16897	   2236	      0	  19133	   4abd	fs/9p/vfs_inode_dotl.o
> 
> (gcc version 9.2.1, amd64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Fine with me, I'll pick it up for the next cycle.

There are a couple of static structs in net/9p that aren't const (but
could be); I guess the static is all that matters here?
(I'll try to go through and make the rest const when I have time
though, no harm there)

Thanks,
-- 
Dominique
