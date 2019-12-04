Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0B55113025
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 17:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfLDQjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 11:39:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33354 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfLDQjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 11:39:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yvkwdjWV2dbRxadhAu73uSRbz7briKKaZny4sqBY6X8=; b=DJmo/VirsXbpSShLj09KSNK+p
        5k6VBQitayqm0j2cbIaaDt8yL0EJHqYOM+faM4lNuiV3tFZjtLp+iK1CYH3TNnFcFu/iceLRUJLme
        jT4W2CJz2WYRGxUgl+EyWku7J+mOTvdDIWqW5eSuhvGNHo12Y6ehasmXjOVm2S1ybhe1y2BPaS2dp
        10ZzW5cECFmfzZCnFrKqO+3G7b24xbSTL2Cq+yJtCMFxGNyHm47Pn46aPJWr0wUDNuWp+wU/r0rza
        v5+sMZ4rEXxa4J4TRYOABigbwHd/RqAAF1swr18rWyhZyr7HmT6UPc6u3yQIuWk7uxRyA4EPH8saA
        kg92Z+DpA==;
Received: from [2601:1c0:6280:3f0::3deb]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1icXgN-0006RZ-8o; Wed, 04 Dec 2019 16:39:19 +0000
Subject: Re: [PATCH] Documentation: filesystems: automount-support: Change
 reference to document autofs.txt to autofs.rst
From:   Randy Dunlap <rdunlap@infradead.org>
To:     madhuparnabhowmik04@gmail.com, corbet@lwn.net, mchehab@kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20191204100941.6268-1-madhuparnabhowmik04@gmail.com>
 <09c9f538-8698-37c4-c5c0-2107a96ae859@infradead.org>
Message-ID: <724aa2b7-1f45-5162-67b9-3f64beaa2951@infradead.org>
Date:   Wed, 4 Dec 2019 08:39:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <09c9f538-8698-37c4-c5c0-2107a96ae859@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/19 8:38 AM, Randy Dunlap wrote:
> On 12/4/19 2:09 AM, madhuparnabhowmik04@gmail.com wrote:
>> From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
>>
>> This patch fixes the following documentation build warning:
>>
>> Warning: Documentation/filesystems/automount-support.txt references
>>  a file that doesn't exist: Documentation/filesystems/autofs.txt
>>
>> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
>> ---
>>  .../filesystems/automount-support.txt         |    2 +-
>>  doc.txt                                       |  492 ++
>>  four.txt                                      | 7656 +++++++++++++++++
>>  fs/nfs/dir.c                                  |    2 +-
>>  scripts/pnmtologo                             |  Bin 0 -> 18112 bytes
>>  5 files changed, 8150 insertions(+), 2 deletions(-)
>>  create mode 100644 doc.txt
>>  create mode 100644 four.txt
>>  create mode 100755 scripts/pnmtologo
> 
> Hi,
> 
> It seems that there are some files in this patch that should not be here.
> 

Sorry, I see your other patch now.  Thanks.

-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
