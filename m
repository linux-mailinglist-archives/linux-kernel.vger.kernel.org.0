Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE1CE1301A0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jan 2020 10:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgADJmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jan 2020 04:42:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:55204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbgADJmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 04:42:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F20A0222C4;
        Sat,  4 Jan 2020 09:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578130952;
        bh=fvPS1jOgtlGofazng3+BUa/0zzXE76N2DTLC2K2QeKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WK+jPOaPIFcy6c4cs0FiTvd6EtkUJIonagbvxsDOHicEAIKJK9WDIFNgBLvXKzcZi
         4JGbbBN6IOqTBjbgNI6UkY573tP86yCY8oxgGz0ccYSc9xpdLfJ0s9p/qalhuA0l/M
         Cmd5T53Z+KUQCMRVmaVVxoTor5/FcpOr9E+7aWFQ=
Date:   Sat, 4 Jan 2020 10:42:29 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/24] Consolidate dummy_con initialization
Message-ID: <20200104094229.GA1279126@kroah.com>
References: <20191218204002.30512-1-nivedita@alum.mit.edu>
 <20200103171223.GA1308999@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103171223.GA1308999@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2020 at 12:12:24PM -0500, Arvind Sankar wrote:
> On Wed, Dec 18, 2019 at 03:39:38PM -0500, Arvind Sankar wrote:
> > This series moves initialization of conswitchp to dummy_con into vt.c,
> > and configures DUMMY_CONSOLE unconditionally when CONFIG_VT is enabled.
> > 
> > The patches after the second one remove conswitchp = &dummy_con; from
> > the various architecture setup functions where it currently appears. If
> > the first two look ok, I was thinking of sending the others
> > individually.
> > 
> 
> Hi Greg/Jiri, happy new year!
> 
> Are you able to look at this series?
> 
> https://lore.kernel.org/lkml/20191218214506.49252-1-nivedita@alum.mit.edu/

It's in my review queue which is really long at the moment, sorry.
Please be patient.

greg k-h
