Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1553416F79B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 06:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgBZFrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 00:47:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:39510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgBZFrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 00:47:53 -0500
Received: from [192.168.0.217] (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1254206E2;
        Wed, 26 Feb 2020 05:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582696073;
        bh=P593FGjMiFSyqNhPqxCl6EBKFcqaO+XUWMo+/sOtY50=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ExGlz+jzi6fzSq8Sb7OpeytLapzqH+r/7nxMr7PfXGOG5pp5VvATzQb0GfJHc5jug
         1nOheQNzThP534NEZnbaX5JkV/Fhm6IIVDuIEcfuOhu8+y9Cnfkn5wbqI+6roXcru1
         7Yh0/rA3+Fr49sbwXEt5UJvPppP1p+7CDeBgcqfU=
Subject: Re: [patch 6/8] x86/entry: Move irq tracing to syscall_slow_exit_work
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20200225220801.571835584@linutronix.de>
 <20200225221305.813084267@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <e6951061-a397-21e5-3bb7-72de97d37d49@kernel.org>
Date:   Tue, 25 Feb 2020 21:47:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200225221305.813084267@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/20 2:08 PM, Thomas Gleixner wrote:
> which removes the ASM IRQ tracepoints.

It's still after we re-enter rcuidle.  Is tracing actually okay?

I always had the impression that tracing was okay in rcuidle mode
because the tracing code was smart enough to do the right thing, but
your patch 3/8 changelog says:

Anything before enter_from_user_mode() is not safe to be traced or probed.


--Andy
