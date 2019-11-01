Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32ED6EC0FB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 11:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbfKAKFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 06:05:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5248 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728048AbfKAKFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 06:05:51 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 263B1D67FC4C1998E218;
        Fri,  1 Nov 2019 18:05:49 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 1 Nov 2019
 18:05:46 +0800
Subject: Re: [RFC PATCH v2] f2fs: support data compression
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20191029092730.109428-1-yuchao0@huawei.com>
 <20191031160105.GC60005@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <33c09ea0-b521-77b7-dd84-a3ede003a793@huawei.com>
Date:   Fri, 1 Nov 2019 18:05:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191031160105.GC60005@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/11/1 0:01, Jaegeuk Kim wrote:
>> +f2fs-$(CONFIG_FS_COMPRESSION) += compress.o
> CONFIG_F2FS_FS_COMPRESSION?

Fixed.

> 
>> +#ifdef F2FS_FS_COMPRESSION
> Do we need this?

Ditto.

> 
>> +bool f2fs_is_compress_backend_ready(struct inode *inode)
>> +{
>> +	if (!f2fs_compressed_file(inode))
>> +		return true;
> #ifdef F2FS_FS_COMPRESSION
>> +	return f2fs_cops[F2FS_I(inode)->i_compress_algorithm];
> #else
> 	return -EOPNOTSUPP;
> #endif

Ditto, I kept return value as boolean.

> 
