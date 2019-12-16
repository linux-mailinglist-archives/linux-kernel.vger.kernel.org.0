Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8333312070C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 14:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfLPNYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 08:24:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:42800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727601AbfLPNYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:24:32 -0500
Received: from [192.168.0.114] (unknown [58.212.132.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12214206CB;
        Mon, 16 Dec 2019 13:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576502671;
        bh=sO+1csfL+rYIgxzSfCDi9aMrtpcShiJGeaFwuQB9DyQ=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=N7AJRz+H6lX1XsWIhoqKRICOBi1fEcPJ2g8h6xveE/XA/75uj8I+JZLgivmpheGnW
         at3PW2Zervh5vOpiR5f8Qqy5dB8zhqFyP6HKCEhbiRMUYUndrELUBg1o0KW5yn0H3g
         cJGlC6R2EA0vnKLsNARVa+58iVR0OLUW+l+e97kk=
Subject: Re: [f2fs-dev] [RFC PATCH v5] f2fs: support data compression
To:     Markus Elfring <Markus.Elfring@web.de>,
        Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
References: <20191216062806.112361-1-yuchao0@huawei.com>
 <594c3b59-b6f0-0e87-6acb-04161e555d7e@web.de>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org
From:   Chao Yu <chao@kernel.org>
Message-ID: <a50e477f-3bc0-d975-e8ff-ffb51704d91f@kernel.org>
Date:   Mon, 16 Dec 2019 21:24:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <594c3b59-b6f0-0e87-6acb-04161e555d7e@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-16 19:32, Markus Elfring wrote:
> …
>> +++ b/fs/f2fs/compress.c
>> @@ -0,0 +1,1139 @@
> …
>> +bool f2fs_is_compressed_page(struct page *page)
>> +{
>> +	if (!PagePrivate(page))
>> +		return false;
>> +	if (!page_private(page))
>> +		return false;
>> +	if (IS_ATOMIC_WRITTEN_PAGE(page) || IS_DUMMY_WRITTEN_PAGE(page))
>> +		return false;
> …
>
> How do you think about to combine condition checks like the following?
>
> +	if (!PagePrivate(page) || !page_private(page) ||
> +	    IS_ATOMIC_WRITTEN_PAGE(page) || IS_DUMMY_WRITTEN_PAGE(page))
> +		return false;

That's f2fs coding style, I guess it will a little bit easiler to understand one 
single condition than understanding combined one.

Thanks,

>
>
> Would you like to apply similar transformations at other source code places?
>
> Regards,
> Markus
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>
