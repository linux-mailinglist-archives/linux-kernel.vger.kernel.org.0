Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 157EB118057
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 07:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfLJGWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 01:22:44 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:40544 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726085AbfLJGWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 01:22:43 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9000BFB28A103D0B0033;
        Tue, 10 Dec 2019 14:22:42 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 10 Dec
 2019 14:22:39 +0800
Subject: Re: [f2fs-dev] [PATCH 5/6] f2fs: set GFP_NOFS when moving inline
 dentries
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20191209222345.1078-1-jaegeuk@kernel.org>
 <20191209222345.1078-5-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <98bf2199-9555-f679-cfd0-385aa4374ac9@huawei.com>
Date:   Tue, 10 Dec 2019 14:22:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191209222345.1078-5-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/12/10 6:23, Jaegeuk Kim wrote:
> Otherwise, it can cause circular locking dependency reported by mm.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
