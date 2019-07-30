Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1CD7AC8F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 17:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731732AbfG3PmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 11:42:10 -0400
Received: from foss.arm.com ([217.140.110.172]:34838 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbfG3PmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:42:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2580E28;
        Tue, 30 Jul 2019 08:42:09 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59F763F694;
        Tue, 30 Jul 2019 08:42:07 -0700 (PDT)
Date:   Tue, 30 Jul 2019 16:42:05 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH] kmemleak: Increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE default
 to 16K
Message-ID: <20190730154204.GC15386@arrakis.emea.arm.com>
References: <20190730154027.101525-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730154027.101525-1-drinkcat@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 11:40:27PM +0800, Nicolas Boichat wrote:
> The current default value (400) is too low on many systems (e.g.
> some ARM64 platform takes up 1000+ entries).
> 
> syzbot uses 16000 as default value, and has proved to be enough
> on beefy configurations, so let's pick that value.
> 
> This consumes more RAM on boot (each entry is 160 bytes, so
> in total ~2.5MB of RAM), but the memory would later be freed
> (early_log is __initdata).
> 
> Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
