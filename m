Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93C11132507
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 12:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgAGLhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 06:37:47 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:51818 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727177AbgAGLhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 06:37:46 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 845B656D4FB73F553C27;
        Tue,  7 Jan 2020 19:37:44 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 7 Jan 2020
 19:37:41 +0800
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: code cleanup for
 f2fs_statfs_project()
To:     Chengguang Xu <cgxu519@mykernel.net>, <jaegeuk@kernel.org>,
        <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200104142004.12883-1-cgxu519@mykernel.net>
 <20200104142004.12883-2-cgxu519@mykernel.net>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <56985674-6c24-3332-7542-33e850942f57@huawei.com>
Date:   Tue, 7 Jan 2020 19:37:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200104142004.12883-2-cgxu519@mykernel.net>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/1/4 22:20, Chengguang Xu wrote:
> Calling min_not_zero() to simplify complicated prjquota
> limit comparison in f2fs_statfs_project().
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
