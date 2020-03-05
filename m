Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBF5817A2FD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 11:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgCEKSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 05:18:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:58382 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgCEKSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 05:18:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7A4F7AE2D;
        Thu,  5 Mar 2020 10:18:46 +0000 (UTC)
Subject: Re: xen boot PVH guest with linux 5.6.0-rc4-ish kernel: general
 protection fault, RIP: 0010:__pv_queued_spin_lock_slowpath
To:     Sander Eikelenboom <linux@eikelenboom.it>
Cc:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <d323139d-97ef-0c76-8ec6-a669f5b0ba2d@eikelenboom.it>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <bb3965c5-6724-b261-260b-d07e40176802@suse.com>
Date:   Thu, 5 Mar 2020 11:18:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d323139d-97ef-0c76-8ec6-a669f5b0ba2d@eikelenboom.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.03.20 18:52, Sander Eikelenboom wrote:
> Hi Juergen,
> 
> Just tested a 5.6.0-rc4'ish kernel (8b614cb8f1dcac8ca77cf4dd85f46ef3055f8238, so it includes the xen fixes from x86 trees).
> Xen is the latest xen-unstable, dom0 kernel is 5.5.7.
> 
> During boot of the PVH guest I got the splat below.
> With a 5.5.7 kernel the guest boots fine.

There were 2 bugs. I have sent the patches.

Interesting, though, that you did see only one of them (I hit the
same bug as you did only after fixing the xenbus problem).


Juergen
