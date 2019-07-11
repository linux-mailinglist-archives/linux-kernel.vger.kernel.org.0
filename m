Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE4DA64F8A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 02:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfGKAZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 20:25:35 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40210 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfGKAZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 20:25:30 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hlMtr-00010e-MO; Thu, 11 Jul 2019 00:25:27 +0000
Date:   Thu, 11 Jul 2019 01:25:27 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        sfr@canb.auug.org.au
Subject: Re: next-20190708: kernel BUG at lib/lockref.c:189, softlockups in
 shrink_dcache...?
Message-ID: <20190711002527.GD17978@ZenIV.linux.org.uk>
References: <20190710201311.GA8519@amd>
 <20190710170912.dd53d6539127bb5b7536788d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710170912.dd53d6539127bb5b7536788d@linux-foundation.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 05:09:12PM -0700, Andrew Morton wrote:
> On Wed, 10 Jul 2019 22:13:11 +0200 Pavel Machek <pavel@ucw.cz> wrote:
> 
> > Hi!
> > 
> > I'm getting some nastyness from lockref / memory management.
> > 
> > Any ideas? Any ideas who to talk to?
> > 
> 
> I'd be suspecting Al's a99d7580f66e737 ("Teach shrink_dcache_parent()
> to cope with mixed-filesystem shrink lists").

It is, and it's already fixed.  See 9bdebc2bd1c4 with fixes folded in;
the incremental is

diff --git a/fs/dcache.c b/fs/dcache.c
index d8732cf2e302..01b8cae41a71 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1555,7 +1555,9 @@ void shrink_dcache_parent(struct dentry *parent)
 		d_walk(parent, &data, select_collect2);
 		if (data.victim) {
 			struct dentry *parent;
+			spin_lock(&data.victim->d_lock);
 			if (!shrink_lock_dentry(data.victim)) {
+				spin_unlock(&data.victim->d_lock);
 				rcu_read_unlock();
 			} else {
 				rcu_read_unlock();
 
> This appears to have been added to -next around the -rc6 timeframe,
> which seems awfully late?

I'm not sure if I'll be asking to pull that series this window,
actually ;-/

Sigh...  This cycle had been a mess - spent a month or so very unpleasantly
sick ;-/
