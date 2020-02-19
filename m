Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9441C164DD6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 19:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgBSSmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 13:42:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:53458 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbgBSSmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 13:42:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C0348B22A;
        Wed, 19 Feb 2020 18:42:30 +0000 (UTC)
Subject: Re: [PATCH V2] xen: Enable interrupts when calling _cond_resched()
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
References: <87tv3mq1rm.fsf@nanos.tec.linutronix.de>
 <8808612b-11c2-f7b8-f027-7ff92e992c50@suse.com>
 <87h7zmpr1k.fsf@nanos.tec.linutronix.de>
 <878skypjrh.fsf@nanos.tec.linutronix.de>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <a2dee352-409b-1c6b-e7f0-bcbbf5d71a95@suse.com>
Date:   Wed, 19 Feb 2020 19:42:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <878skypjrh.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.02.20 18:30, Thomas Gleixner wrote:
> xen_maybe_preempt_hcall() is called from the exception entry point
> xen_do_hypervisor_callback with interrupts disabled.
> 
> _cond_resched() evades the might_sleep() check in cond_resched() which
> would have caught that and schedule_debug() unfortunately lacks a check
> for irqs_disabled().
> 
> Enable interrupts around the call and use cond_resched() to catch future
> issues.
> 
> Fixes: fdfd811ddde3 ("x86/xen: allow privcmd hypercalls to be preempted")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen

