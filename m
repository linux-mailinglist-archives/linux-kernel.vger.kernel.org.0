Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9169DC8C2C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 16:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfJBO7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 10:59:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:45962 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726070AbfJBO7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 10:59:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C15BCABD3;
        Wed,  2 Oct 2019 14:59:09 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH] x86/xen: Return from panic notifier
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     james@dingwall.me.uk, xen-devel@lists.xenproject.org,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
References: <20191001151633.1659-1-boris.ostrovsky@oracle.com>
 <9b3f955c-ad76-601f-2b58-fa9dc4608c72@suse.com>
 <924f41b2-7779-9c56-9b71-56523756ecdc@oracle.com>
 <5650904d-b616-5ee7-216a-a0ac28d7426d@suse.com>
 <9d6b6b00-a3b1-95b4-7633-597c0094ab90@oracle.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <63155d02-1082-3f26-6c2f-76aa3b753302@suse.com>
Date:   Wed, 2 Oct 2019 16:59:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9d6b6b00-a3b1-95b4-7633-597c0094ab90@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.10.2019 16:14, Boris Ostrovsky wrote:
> On 10/2/19 9:42 AM, Jan Beulich wrote:
>>
>> I can only guess that the thinking probably was that e.g. external
>> dumping (by the tool stack) would be more reliable (including but
>> not limited to this meaning less change of state from when the
>> original crash reason was detected) than having the domain dump
>> itself.
> 
> 
> We could register an external dumper (controlled by a boot option
> perhaps, off by default) that will call directly into hypervisor with
> SHUTDOWN_crash. That will guarantee that we will complete the notifier
> chain without relying on priorities. (Of course this still won't address
> a possible new feature in panic() that might be called post-dumping)
> 
> If you think it's worth doing this can be easily added.

Well, I think this is the better option than potentially
pingponging between the two extremes, because one wants it the
way it currently is and another wants it the way this patch
changes things to.

Jan
