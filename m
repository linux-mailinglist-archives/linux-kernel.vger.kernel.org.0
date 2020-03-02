Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D66D2175BDA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 14:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgCBNh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 08:37:58 -0500
Received: from sym2.noone.org ([178.63.92.236]:39072 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727702AbgCBNh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 08:37:58 -0500
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 48WLn00jDYzvjc1; Mon,  2 Mar 2020 14:37:55 +0100 (CET)
Date:   Mon, 2 Mar 2020 14:37:55 +0100
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pty: define and set show_fdinfo only if procfs is
 enabled
Message-ID: <20200302133755.tne3x7tibad4vmiq@distanz.ch>
References: <20200302104954.2812-1-tklauser@distanz.ch>
 <20200302105153.GA39968@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302105153.GA39968@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-02 at 11:51:53 +0100, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> On Mon, Mar 02, 2020 at 11:49:53AM +0100, Tobias Klauser wrote:
> > Follow the pattern used with other *_show_fdinfo functions and only
> > define and use pty_show_fdinfo if CONFIG_PROC_FS is set.
> 
> if proc_fs is not set, it will not be used anyway, right?

Right, it should never get called.

> I'd rather keep #ifdef out of the .c files than add this.  How much
> memory does it save, and are you using a system without procfs that
> needs this savings?

The savings are marginal, so no I don't strictly need this. I just
figured all other *_show_fdinfo functions in the tree are #ifdef'ed in
the same way and it would be nice to be consistent.

Thanks
