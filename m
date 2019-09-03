Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C725A727B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 20:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbfICSTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 14:19:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:44170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbfICSTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 14:19:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B805321897;
        Tue,  3 Sep 2019 18:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567534789;
        bh=sZ9Pc23+pIpH3xhR8mnJ/YptPq7C/EftEWGYfNbPqiI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dh7G22g6v9ojEhQhVyP1bQ/i7z2f1oIkxxHtCGOY6RDiXWQD7u7/QSXHRgbGwau/n
         uHPXNz2NgbAskDei6VvjB7YxC5hId24MVESEYTJbvsJSrtgEo9mW6G0YdSBJaT3Q38
         zuiFU2GN38N73ixi1XEPwHFyLkiFXe75E1Ey/NBI=
Date:   Tue, 3 Sep 2019 20:19:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        devel@driverdev.osuosl.org,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: exfat: cleanup braces for if/else statements
Message-ID: <20190903181946.GA14349@kroah.com>
References: <20190903164732.14194-1-vvidic@valentin-vidic.from.hr>
 <20190903173249.GL1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903173249.GL1131@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 06:32:49PM +0100, Al Viro wrote:
> On Tue, Sep 03, 2019 at 06:47:32PM +0200, Valentin Vidic wrote:
> > +			} else if (uni == 0xFFFF) {
> >  				skip = TRUE;
> 
> While we are at it, could you get rid of that 'TRUE' macro?
> Or added
> 
> #define THE_TRUTH_AND_THATS_CUTTIN_ME_OWN_THROAT true
> 
> if you want to properly emphasize it...

No, we don't :)

I cleaned up a bunch of those, there are a lot more still left, it is a
mess...
