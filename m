Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80F511496A3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jan 2020 17:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgAYQdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jan 2020 11:33:01 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:33922 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgAYQdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 11:33:01 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ivOMd-002TGu-VY; Sat, 25 Jan 2020 16:32:52 +0000
Date:   Sat, 25 Jan 2020 16:32:51 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/adfs: bigdir: Fix an error code in adfs_fplus_read()
Message-ID: <20200125163251.GL23230@ZenIV.linux.org.uk>
References: <20200124101537.z6n242eovocfbdha@kili.mountain>
 <20200125092930.GQ25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125092930.GQ25745@shell.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 09:29:30AM +0000, Russell King - ARM Linux admin wrote:
> On Fri, Jan 24, 2020 at 01:15:37PM +0300, Dan Carpenter wrote:
> > This code accidentally returns success, but it should return the
> > -EIO error code from adfs_fplus_validate_header().
> > 
> > Fixes: d79288b4f61b ("fs/adfs: bigdir: calculate and validate directory checkbyte")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Good catch.
> 
> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
> 
> Al, please apply, thanks.

Applied and pushed out.
