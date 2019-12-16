Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B411120728
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 14:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfLPN20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 08:28:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:44338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727601AbfLPN20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:28:26 -0500
Received: from [192.168.0.114] (unknown [58.212.132.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC3C0206CB;
        Mon, 16 Dec 2019 13:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576502905;
        bh=en62J9Sle+YYjeP96DqQn4yayB6lPx6YOVyC3LY1Kis=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=dbGzyJj4vH71sNkYyLTdAqtPy1ugCsqngU/6RSks1Og8gfuhSodwPMPwzEwhunxwl
         FIlvIXutM7Pca1Vn7QSzPyR3RrEXn4vBEOCBraj/GbxH2hjDROvOF6VqDVuFDoChqQ
         E4YdEa6hbIMxg6jYKvelWonDkjDPiL7aL4CVpALc=
Subject: Re: [RFC PATCH v5] f2fs: support data compression
To:     Markus Elfring <Markus.Elfring@web.de>,
        Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
References: <20191216062806.112361-1-yuchao0@huawei.com>
 <0ab8c593-d043-cdf6-7805-f7bceba8e519@web.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <0677a4fd-62a5-ad98-fd02-ae7d5a9cb501@kernel.org>
Date:   Mon, 16 Dec 2019 21:28:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <0ab8c593-d043-cdf6-7805-f7bceba8e519@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-16 19:51, Markus Elfring wrote:
> …
>> +++ b/fs/f2fs/f2fs.h
> …
>> +#ifdef CONFIG_F2FS_FS_COMPRESSION
>> +bool f2fs_is_compressed_page(struct page *page);
> …
>
> Can the following adjustment make sense?
>
> +bool f2fs_is_compressed_page(const struct page *page);
>
>
> Would you like to improve const-correctness at any more source code places?

I can't figure out a good reason to do that for f2fs internal functions...

Thanks,

>
> Regards,
> Markus
>
