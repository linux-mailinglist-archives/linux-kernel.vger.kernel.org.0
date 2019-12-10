Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD86118206
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 09:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfLJIRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 03:17:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:38224 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727048AbfLJIRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 03:17:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9CC40B321;
        Tue, 10 Dec 2019 08:17:39 +0000 (UTC)
Subject: Re: [PATCH v5 1/2] xenbus/backend: Add memory pressure handler
 callback
To:     SeongJae Park <sj38.park@gmail.com>, sjpark@amazon.com
Cc:     axboe@kernel.dk, konrad.wilk@oracle.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        pdurrant@amazon.com, roger.pau@citrix.com,
        xen-devel@lists.xenproject.org, SeongJae Park <sjpark@amazon.de>
References: <20191210080628.5264-1-sjpark@amazon.de>
 <20191210080628.5264-2-sjpark@amazon.de>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <7260cdce-7488-5045-0572-021a0ef191ac@suse.com>
Date:   Tue, 10 Dec 2019 09:17:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191210080628.5264-2-sjpark@amazon.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.12.19 09:06, SeongJae Park wrote:
> Granting pages consumes backend system memory.  In systems configured
> with insufficient spare memory for those pages, it can cause a memory
> pressure situation.  However, finding the optimal amount of the spare
> memory is challenging for large systems having dynamic resource
> utilization patterns.  Also, such a static configuration might lack a
> flexibility.
> 
> To mitigate such problems, this commit adds a memory reclaim callback to
> 'xenbus_driver'.  Using this facility, 'xenbus' would be able to monitor
> a memory pressure and request specific devices of specific backend
> drivers which causing the given pressure to voluntarily release its
> memory.
> 
> That said, this commit simply requests every callback registered driver
> to release its memory for every domain, rather than issueing the
> requests to the drivers and the domain in charge.  Such things will be
> done in a futur.  Also, this commit focuses on memory only.  However, it
> would be ablt to be extended for general resources.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
