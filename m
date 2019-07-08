Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF5AC62C49
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 01:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfGHXDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 19:03:52 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:36096 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfGHXDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 19:03:51 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 64690296E2;
        Mon,  8 Jul 2019 19:03:46 -0400 (EDT)
Date:   Tue, 9 Jul 2019 09:03:44 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Joshua Thompson <funaho@jurai.org>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] m68k/mac: Revisit floppy disc controller base
 addresses
In-Reply-To: <CAMuHMdW_ScrApPH1YZb8+64+wZjq9BGuF18KCF7--9D2gneXrg@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1907090902100.41@nippy.intranet>
References: <224218b529a5abb1d5dd5ce2103b685a10866577.1550182390.git.fthain@telegraphics.com.au> <CAMuHMdW_ScrApPH1YZb8+64+wZjq9BGuF18KCF7--9D2gneXrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jul 2019, Geert Uytterhoeven wrote:

> I guess the others do have aliases at 0x50000000? ...
> 

Right. Otherwise mac_scsi wouldn't work. See also, arch/m68k/mac/config.c:

                 * GMFH says that $5000 0000 - $50FF FFFF "wraps
                 * $5000 0000 - $5001 FFFF eight times" (!)
                 * mess.org says IIci and Color Classic do not alias
                 * I/O address space.

-- 
