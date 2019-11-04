Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA32EE2A5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 15:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbfKDOfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 09:35:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:51992 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728416AbfKDOfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:35:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8DE98AD17;
        Mon,  4 Nov 2019 14:35:04 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH] xen/events: remove event handling recursion
 detection
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20191104135812.2314-1-jgross@suse.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <40cba9d9-24b0-3141-4ba8-02e03049f1bf@suse.com>
Date:   Mon, 4 Nov 2019 15:35:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104135812.2314-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.11.2019 14:58, Juergen Gross wrote:
> __xen_evtchn_do_upcall() contains guards against being called
> recursively. This mechanism was introduced in the early pvops times
> (kernel 2.6.26) when there were still Xen versions around not honoring
> disabled interrupts for sending events to pv guests.
> 
> This was changed in Xen 3.0, which is much older than any Xen version
> supported by the kernel, so the recursion detection can be removed.

Would you mind pointing out which exact change(s) this was(were)?
It had always been my understanding that the recursion detection
was mainly to guard against drivers re-enabling interrupts
transiently in their handlers (which in turn may no longer be an
issue in modern Linux kernels).

Jan
