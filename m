Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1B664602
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 14:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfGJMIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 08:08:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:34870 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbfGJMIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 08:08:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 296DBAC98;
        Wed, 10 Jul 2019 12:08:18 +0000 (UTC)
Subject: Re: [PATCH RESEND] Revert "x86/paravirt: Set up the
 virt_spin_lock_key after static keys get initialized"
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     Waiman Long <longman@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
References: <1561539429-29436-1-git-send-email-zhenzhong.duan@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <b7f9215d-f58a-3a97-06fe-95c1e6a9ac43@suse.com>
Date:   Wed, 10 Jul 2019 14:08:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1561539429-29436-1-git-send-email-zhenzhong.duan@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.06.19 10:57, Zhenzhong Duan wrote:
> This reverts commit ca5d376e17072c1b60c3fee66f3be58ef018952d.
> 
> Commit 8990cac6e5ea ("x86/jump_label: Initialize static branching
> early") adds jump_label_init() call in setup_arch() to make static
> keys initialized early, so we could use the original simpler code
> again.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>

Applied to xen/tip.git for-linus-5.3


Juergen
