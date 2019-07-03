Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98F845C76D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 04:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfGBCoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 22:44:30 -0400
Received: from gate.crashing.org ([63.228.1.57]:56659 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfGBCoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:44:30 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x622iI61015588;
        Mon, 1 Jul 2019 21:44:19 -0500
Message-ID: <38d777292f5335b5ea5f8fd7c0b58c514dda525a.camel@kernel.crashing.org>
Subject: Re: WARNING: refcount bug in kobject_add_internal
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org
Cc:     Muchun Song <smuchun@gmail.com>
Date:   Tue, 02 Jul 2019 12:44:18 +1000
In-Reply-To: <000000000000106b11058ca6f7f2@google.com>
References: <000000000000106b11058ca6f7f2@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Munchun, is this what your patch fixes ?


On Mon, 2019-07-01 at 16:27 -0700, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 726e41097920a73e4c7c33385dcc0debb1281e18
> Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date:   Tue Jul 10 00:29:10 2018 +0000
> 
>      drivers: core: Remove glue dirs from sysfs earlier
> 
> bisection log:  
> https://syzkaller.appspot.com/x/bisect.txt?x=140d6739a00000
> start commit:   6fbc7275 Linux 5.2-rc7
> git tree:       upstream
> final crash:    
> https://syzkaller.appspot.com/x/report.txt?x=160d6739a00000
> console output: 
> https://syzkaller.appspot.com/x/log.txt?x=120d6739a00000
> kernel config:  
> https://syzkaller.appspot.com/x/.config?x=bff6583efcfaed3f
> dashboard link: 
> https://syzkaller.appspot.com/bug?extid=32259bb9bc1a487ad206
> syz repro:      
> https://syzkaller.appspot.com/x/repro.syz?x=115bad39a00000
> C reproducer:   
> https://syzkaller.appspot.com/x/repro.c?x=1241bdd5a00000
> 
> Reported-by: syzbot+32259bb9bc1a487ad206@syzkaller.appspotmail.com
> Fixes: 726e41097920 ("drivers: core: Remove glue dirs from sysfs
> earlier")
> 
> For information about bisection process see: 
> https://goo.gl/tpsmEJ#bisection

