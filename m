Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B37687A8F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 14:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406884AbfHIMxx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 9 Aug 2019 08:53:53 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:51995 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726091AbfHIMxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 08:53:52 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 17943319-1500050 
        for multiple; Fri, 09 Aug 2019 13:53:46 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        Martin Wilck <Martin.Wilck@suse.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <ad70d1985e8d0227dc55fedeec769de166e63ae0.camel@suse.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <ad70d1985e8d0227dc55fedeec769de166e63ae0.camel@suse.com>
Message-ID: <156535522344.29541.9312856809559678262@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: 5.3-rc3: Frozen graphics with kcompactd migrating i915 pages
Date:   Fri, 09 Aug 2019 13:53:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Wilck (2019-08-09 13:41:42)
> This happened to me today, running kernel 5.3.0-rc3-1.g571863b-default
> (5.3-rc3 with just a few patches on top), after starting a KVM virtual
> machine. The X screen was frozen. Remote login via ssh was still
> possible, thus I was able to retrieve basic logs.
> 
> sysrq-w showed two blocked processes (kcompactd0 and KVM). After a
> minute, the same two processes were still blocked. KVM seems to try to
> acquire a lock that kcompactd is holding. kcompactd is waiting for IO
> to complete on pages owned by the i915 driver.

My bad, it's known. We haven't decided on whether to revert the
unfortunate recursive locking (and so hit another warn elsewhere) or to
ignore the dirty pages (and so risk losing data across swap).

cb6d7c7dc7ff ("drm/i915/userptr: Acquire the page lock around set_page_dirty()")
-Chris
