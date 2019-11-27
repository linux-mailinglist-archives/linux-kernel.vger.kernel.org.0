Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6194310AABB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 07:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfK0GpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 01:45:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:43446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbfK0GpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 01:45:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 790952070B;
        Wed, 27 Nov 2019 06:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574837110;
        bh=hJjnJpvAzqdeAsTsokS3rCLCV3qwPqmSDZW6dQSF1eo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jUNx9Xyc2qwrIo1HfX3Z/aJeuLJusVn3TnKD+o40DYtCGh0kmNrKjZ5S+4bC30uUq
         uK0NUilu33GZTd+hn43vcEXUbfzdJ34BfBjeo0wwtMYTdyKMkpTybQu1PYyGSX/BV3
         rOgMVKkp/lV7gz+4pXlye7ifMAJMoraFjqOXfmaA=
Date:   Wed, 27 Nov 2019 07:45:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Or Cohen <orcohen@paloaltonetworks.com>, textshell@uchuujin.de,
        Daniel Vetter <daniel.vetter@ffwll.ch>, sam@ravnborg.org,
        mpatocka@redhat.com, ghalat@redhat.com,
        linux-kernel@vger.kernel.org, jwilk@jwilk.net,
        Nadav Markus <nmarkus@paloaltonetworks.com>,
        syzkaller@googlegroups.com
Subject: Re: Bug report - slab-out-of-bounds in vcs_scr_readw
Message-ID: <20191127064507.GC1711684@kroah.com>
References: <CAM6JnLeEnvjjQPyLeh+8dt5wGNud_vks5k_eXJZy2T1H7ao=hQ@mail.gmail.com>
 <20191104152428.GA2252441@kroah.com>
 <nycvar.YSQ.7.76.1911041648280.30289@knanqh.ubzr>
 <CAM6JnLdrzCPOYyfTdmriFo7cRaGM4p2OEPd_0MHa3_WemamffA@mail.gmail.com>
 <nycvar.YSQ.7.76.1911041928030.30289@knanqh.ubzr>
 <c30fc539-68a8-65d7-226c-6f8e6fd8bdfb@suse.com>
 <CAM6JnLe88xf8hO0F=_Ni+irNt40+987tHmz9ZjppgxhnMnLxpw@mail.gmail.com>
 <a0550a96-a7db-60d7-c4ac-86be8c8dd275@suse.com>
 <nycvar.YSQ.7.76.1911051030580.30289@knanqh.ubzr>
 <nycvar.YSQ.7.76.1911261652290.8537@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1911261652290.8537@knanqh.ubzr>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 04:55:32PM -0500, Nicolas Pitre wrote:
> Greg, could you apply this please?

Yes, I will, but I don't seem to have it in my email archives anywhere,
was it burried in that long thread?

thanks,

greg k-h
