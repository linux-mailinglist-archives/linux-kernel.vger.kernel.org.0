Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93EF4CE0E9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 13:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfJGLwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 07:52:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbfJGLwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:52:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65D54206C2;
        Mon,  7 Oct 2019 11:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570449139;
        bh=P0InW+X58kvecTYf51KvYwPz7NETAdbIYRCKVp4cXB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dfkBjBIVkHv6tMP0EdwtUnlZqtH/8oXwZv9kpa9vrvFurPyen+/arsQEg0fqgRykE
         bsPGco6pE6BH8av70EHaYh0pkHzUpm8N+/VTyegPZtK5qpGXSNcH/a6G+IuWhWZAzc
         PiGLO0DzJJkpgR+qy5jvS16WqxzuFfa2xRfWBcFA=
Date:   Mon, 7 Oct 2019 13:52:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Dmitry Goldin <dgoldin@protonmail.ch>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH v2] kheaders: making headers archive reproducible
Message-ID: <20191007115217.GA835482@kroah.com>
References: <z4zhwEnRqCVnnV8RYwKbY9H_TEnHePR6grYfw1toELFA-iZidlp3T18y0w35JtWNghJQ3hwL23RrsKXIVJHYiv9wOsqmow33NU6LcHcFWyw=@protonmail.ch>
 <874l0k3hd0.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874l0k3hd0.fsf@igel.home>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 01:49:47PM +0200, Andreas Schwab wrote:
>   GEN     kernel/kheaders_data.tar.xz
> tar: unrecognized option '--sort=name'
> Try `tar --help' or `tar --usage' for more information.
> make[2]: *** [kernel/kheaders_data.tar.xz] Error 64
> make[1]: *** [kernel] Error 2
> make: *** [sub-make] Error 2
> $ tar --version
> tar (GNU tar) 1.26
> Copyright (C) 2011 Free Software Foundation, Inc.

Wow that's an old version of tar.  2011?  What happens if you use a more
modern one?

thanks,

greg k-h
