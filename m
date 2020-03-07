Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0943717D001
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Mar 2020 21:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgCGUbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Mar 2020 15:31:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41516 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgCGUbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 15:31:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p5Qje8RxBhHJAxKEW5syzh0nYVF7uA7bs9uSppk3M08=; b=e7S/y+jGeaZYjPv3GgTKNxpQxf
        l23Ue2dvWbUK9WtXReYLtOtzgPGQ5uRQ+sNZx6Op6KlijrYgbVC02sZgEgGW+lIEDlMrJfaJuF+PU
        5xURNpvLPrb6sXMo1B5EiRQAHQfnBWU198KA/6vaPozPye5JwLjfYp8UauCmSts3aJWT62EfG+sFI
        bmLqw3b7DZbpIdRrqDKDW7vGBiCknMAeijn00jjZph3bEvE/z8wowQzCeiGmSpxeYkFzwFPB46Cih
        3I52ubxBWlTLiCSW5S7HZ+40mtnV7SlYBRt/lWb6TUshPDssH/xORMLBm8iqAoaQPc874vXb0GG+i
        fjbDCIfQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jAg6f-0007l5-IJ; Sat, 07 Mar 2020 20:31:33 +0000
Date:   Sat, 7 Mar 2020 12:31:33 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Document genhd capability flags
Message-ID: <20200307203133.GC31215@bombadil.infradead.org>
References: <20200307145659.22657-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307145659.22657-1-steve@sk2.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 07, 2020 at 03:56:59PM +0100, Stephen Kitt wrote:
> The kernel documentation includes a brief section about genhd
> capabilities, but it turns out that the only documented
> capability (GENHD_FL_MEDIA_CHANGE_NOTIFY) isn't used any more.
> 
> This patch removes that flag, and documents the rest, based on my
> understanding of the current uses of these flags in the kernel. The
> documentation is kept in the header file, alongside the declarations,
> in the hope that it will be kept up-to-date in future; the kernel
> documentation is changed to include the documentation generated from
> the header file.
> 
> Because the ultimate goal is to provide some end-user
> documentation (or end-administrator documentation), the comments are
> perhaps more user-oriented than might be expected. Since the values
> are shown to users in hexadecimal, the documentation lists them in
> hexadecimal, and the constant declarations are adjusted to match.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
