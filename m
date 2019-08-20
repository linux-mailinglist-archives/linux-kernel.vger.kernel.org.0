Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 513DA96259
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 16:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbfHTOZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 10:25:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:49306 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729137AbfHTOZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:25:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7C78AAB0;
        Tue, 20 Aug 2019 14:25:31 +0000 (UTC)
Message-ID: <1566311130.11678.21.camel@suse.com>
Subject: Re: WARNING in kmem_cache_alloc_trace
From:   Oliver Neukum <oneukum@suse.com>
To:     syzbot <syzbot+0e7b6b6001ca8ed655f6@syzkaller.appspotmail.com>,
        andreyknvl@google.com, syzkaller-bugs@googlegroups.com,
        balbi@kernel.org, gregkh@linuxfoundation.org,
        chunfeng.yun@mediatek.com, stern@rowland.harvard.edu,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Tue, 20 Aug 2019 16:25:30 +0200
In-Reply-To: <000000000000d61cbf05908c97e2@google.com>
References: <000000000000d61cbf05908c97e2@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 20.08.2019, 06:40 -0700 schrieb syzbot:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer still triggered  
> crash:
> WARNING in yurex_write/usb_submit_urb

It looks to me like we have two issues here. The driver is simply not
ready to deal with concurrent writers. Is that one of the test cases?

	Regards
		Oliver

