Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3C9DFF81
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 10:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731185AbfJVIfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 04:35:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4704 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726978AbfJVIfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:35:45 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B58507510F0CE3AED697;
        Tue, 22 Oct 2019 16:35:42 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 22 Oct
 2019 16:35:41 +0800
Subject: Re: [PATCH v2] f2fs: fix to avoid memory leakage in f2fs_listxattr
To:     Randall Huang <huangrandall@google.com>, <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <efddfbc3-bd31-b9fb-48de-decb01d01001@huawei.com>
 <20191018065622.66404-1-huangrandall@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <5b27d560-8699-97af-844d-72de8a7a754c@huawei.com>
Date:   Tue, 22 Oct 2019 16:35:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191018065622.66404-1-huangrandall@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/18 14:56, Randall Huang wrote:
> In f2fs_listxattr, there is no boundary check before
> memcpy e_name to buffer.
> If the e_name_len is corrupted,
> unexpected memory contents may be returned to the buffer.
> 
> Signed-off-by: Randall Huang <huangrandall@google.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
