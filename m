Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E94F017DACC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 09:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgCIIY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 04:24:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53614 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726384AbgCIIYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:24:55 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 38DD2BE6200921C94290;
        Mon,  9 Mar 2020 16:24:50 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 9 Mar 2020
 16:24:49 +0800
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix wrong check on
 F2FS_IOC_FSSETXATTR
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <kernel-team@android.com>, Daniel Rosenberg <drosen@google.com>
References: <20200305234822.178708-1-jaegeuk@kernel.org>
 <20200307002440.GA7944@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <55177f3a-ced2-2954-6f86-4f4f663d4bb8@huawei.com>
Date:   Mon, 9 Mar 2020 16:24:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200307002440.GA7944@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/7 8:24, Jaegeuk Kim wrote:
> This fixes the incorrect failure when enabling project quota on casefold-enabled
> file.
> 
> Cc: Daniel Rosenberg <drosen@google.com>
> Cc: kernel-team@android.com
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
