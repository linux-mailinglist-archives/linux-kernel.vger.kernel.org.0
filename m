Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5444E116C90
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 12:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfLILws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 06:52:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:44330 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727074AbfLILwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:52:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1E517B15F;
        Mon,  9 Dec 2019 11:52:17 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH 3/4] xen/interface: don't discard pending work
 in FRONT/BACK_RING_ATTACH
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Paul Durrant <pdurrant@amazon.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20191205140123.3817-1-pdurrant@amazon.com>
 <20191205140123.3817-4-pdurrant@amazon.com>
 <20191209114137.GT980@Air-de-Roger>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <5777c17b-9028-2525-1322-6c05f1ce3aab@suse.com>
Date:   Mon, 9 Dec 2019 12:52:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191209114137.GT980@Air-de-Roger>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.12.19 12:41, Roger Pau Monné wrote:
> On Thu, Dec 05, 2019 at 02:01:22PM +0000, Paul Durrant wrote:
>> Currently these macros will skip over any requests/responses that are
>> added to the shared ring whilst it is detached. This, in general, is not
>> a desirable semantic since most frontend implementations will eventually
>> block waiting for a response which would either never appear or never be
>> processed.
>>
>> NOTE: These macros are currently unused. BACK_RING_ATTACH(), however, will
>>        be used in a subsequent patch.
>>
>> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> 
> Those headers come from Xen, and should be modified in Xen first and
> then imported into Linux IMO.

In theory, yes. But the Xen variant doesn't contain the ATTACH macros.


Juergen
