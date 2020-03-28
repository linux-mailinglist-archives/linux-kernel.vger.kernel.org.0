Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 912E419634C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Mar 2020 04:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgC1DNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 23:13:17 -0400
Received: from tartarus.angband.pl ([54.37.238.230]:47178 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgC1DNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 23:13:17 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1jI1u5-0007vu-4a; Sat, 28 Mar 2020 04:12:57 +0100
Date:   Sat, 28 Mar 2020 04:12:57 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Chen Wandun <chenwandun@huawei.com>, jslaby@suse.com,
        gregkh@linuxfoundation.org, daniel.vetter@ffwll.ch,
        sam@ravnborg.org, b.zolnierkie@samsung.com, lukas@wunner.de,
        ghalat@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] vt: fix a warning when kmalloc alloc large memory
Message-ID: <20200328031257.GA30454@angband.pl>
References: <20200328021340.27315-1-chenwandun@huawei.com>
 <nycvar.YSQ.7.76.2003272232340.2671@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.YSQ.7.76.2003272232340.2671@knanqh.ubzr>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 10:55:14PM -0400, Nicolas Pitre wrote:
> On Sat, 28 Mar 2020, Chen Wandun wrote:
> 
> > If the memory size that use kmalloc() to allocate exceed MAX_ORDER pages,
> > it will hit the WARN_ON_ONCE(!(gfp_mask & __GFP_NOWARN)), so add memory
> > allocation flag __GFP_NOWARN to silence a warning, othervise, it will
> > cause panic if panic_on_warn is enable.
> 
> Wow! How do you manage that? You need something like a 1024x1024 text 
> screen to get such a big memory allocation.

ioctl(VT_RESIZE) allows up to 32767x32767, unprivileged for a local user.
That's 4GB per console.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁ in the beginning was the boot and root floppies and they were good.
⢿⡄⠘⠷⠚⠋⠀                                       -- <willmore> on #linux-sunxi
⠈⠳⣄⠀⠀⠀⠀
