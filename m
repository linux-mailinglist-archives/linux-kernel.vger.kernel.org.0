Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61DE7116C55
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 12:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfLILdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 06:33:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:35408 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727188AbfLILdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:33:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EC5A7AAF1;
        Mon,  9 Dec 2019 11:33:48 +0000 (UTC)
Subject: Re: [PATCH 1/4] xenbus: move xenbus_dev_shutdown() into frontend
 code...
To:     Paul Durrant <pdurrant@amazon.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20191205140123.3817-1-pdurrant@amazon.com>
 <20191205140123.3817-2-pdurrant@amazon.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <38908166-6a4b-9dab-144c-71df691da167@suse.com>
Date:   Mon, 9 Dec 2019 12:33:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191205140123.3817-2-pdurrant@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.12.19 15:01, Paul Durrant wrote:
> ...and make it static
> 
> xenbus_dev_shutdown() is seemingly intended to cause clean shutdown of PV
> frontends when a guest is rebooted. Indeed the function waits for a
> conpletion which is only set by a call to xenbus_frontend_closed().
> 
> This patch removes the shutdown() method from backends and moves
> xenbus_dev_shutdown() from xenbus_probe.c into xenbus_probe_frontend.c,
> renaming it appropriately and making it static.

Is this a good move considering driver domains?

At least I'd expect the commit message addressing the expected behavior
with rebooting a driver domain and why this patch isn't making things
worse.


Juergen
