Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32DD0CFF42
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 18:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfJHQvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 12:51:03 -0400
Received: from foss.arm.com ([217.140.110.172]:41268 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfJHQvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 12:51:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03AC31570;
        Tue,  8 Oct 2019 09:51:03 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CA553F6C4;
        Tue,  8 Oct 2019 09:51:02 -0700 (PDT)
Date:   Tue, 8 Oct 2019 17:51:00 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/kmemleak: skip late_init if not skip disable
Message-ID: <20191008165100.GC5694@arrakis.emea.arm.com>
References: <20190929095659.jzy3gtcj6vgd35j6@XZHOUW.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190929095659.jzy3gtcj6vgd35j6@XZHOUW.usersys.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Murphy,

On Sun, Sep 29, 2019 at 05:56:59PM +0800, Murphy Zhou wrote:
> Now if DEFAULT_OFF set to y, kmemleak_init will start the cleanup_work
> workqueue. Then late_init call will set kmemleak_initialized to 1, the
> cleaup workqueue will try to do cleanup, triggering:
> 
> [24.738773] ==================================================================
> [24.742784] BUG: KASAN: global-out-of-bounds in __kmemleak_do_cleanup+0x166/0x180

I don't think the invocation of kmemleak_do_cleanup() is the issue here.
It should be safe schedule the clean-up thread in case kmemleak was
disabled from boot. What you probably hit was a bug in
__kmemleak_do_cleanup() itself, fixed here:

http://lkml.kernel.org/r/20191004134624.46216-1-catalin.marinas@arm.com

With the above patch, I can no longer trigger the KASan warning.

-- 
Catalin
