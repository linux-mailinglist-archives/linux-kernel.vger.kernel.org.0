Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBA4C48B0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 09:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfJBHkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 03:40:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:60654 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbfJBHkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 03:40:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6A720ACFE;
        Wed,  2 Oct 2019 07:40:04 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH] x86/xen: Return from panic notifier
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        james@dingwall.me.uk, Juergen Gross <jgross@suse.com>
References: <20191001151633.1659-1-boris.ostrovsky@oracle.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <9b3f955c-ad76-601f-2b58-fa9dc4608c72@suse.com>
Date:   Wed, 2 Oct 2019 09:40:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191001151633.1659-1-boris.ostrovsky@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.10.2019 17:16, Boris Ostrovsky wrote:
> Currently execution of panic() continues until Xen's panic notifier
> (xen_panic_event()) is called at which point we make a hypercall that
> never returns.
> 
> This means that any notifier that is supposed to be called later as
> well as significant part of panic() code (such as pstore writes from
> kmsg_dump()) is never executed.

Back at the time when this was introduced into the XenoLinux tree,
I think this behavior was intentional for at least DomU-s. I wonder
whether you wouldn't want your change to further distinguish Dom0
and DomU behavior.

> There is no reason for xen_panic_event() to be this last point in
> execution since panic()'s emergency_restart() will call into
> xen_emergency_restart() from where we can perform our hypercall.

Did you consider, as an alternative, to lower the notifier's
priority?

Jan
