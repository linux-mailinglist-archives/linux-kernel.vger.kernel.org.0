Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6275016BEEF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 11:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbgBYKiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 05:38:08 -0500
Received: from ms.lwn.net ([45.79.88.28]:53230 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729417AbgBYKiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 05:38:08 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 16998738;
        Tue, 25 Feb 2020 10:38:06 +0000 (UTC)
Date:   Tue, 25 Feb 2020 03:38:02 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] efi/libstub: add libstub/mem.c to documentation
 tree
Message-ID: <20200225033802.4e7c09d7@lwn.net>
In-Reply-To: <CAKv+Gu9sjOS7S+T42UcdnA2JCwgKawRJAdKHcwXWQXQaHSPZDQ@mail.gmail.com>
References: <20200221035832.144960-1-xypron.glpk@gmx.de>
        <20200225032500.5b6be465@lwn.net>
        <CAKv+Gu9sjOS7S+T42UcdnA2JCwgKawRJAdKHcwXWQXQaHSPZDQ@mail.gmail.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2020 11:26:01 +0100
Ard Biesheuvel <ardb@kernel.org> wrote:

> > Given that this patch depends on work in the efi tree, I'm assuming that
> > the docs changes will go in via that path as well.
> >  
> 
> Can I take that as an acked-by?
> 
Yes, of course:

  Acked-by: Jonathan Corbet <corbet@lwn.net>

jon
