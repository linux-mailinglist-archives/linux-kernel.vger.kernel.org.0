Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48ECD5A999
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2019 10:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfF2IgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jun 2019 04:36:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60162 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726766AbfF2IgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 04:36:16 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5111617CCFCEA3BB6C2F;
        Sat, 29 Jun 2019 16:36:08 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sat, 29 Jun
 2019 16:36:02 +0800
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: allocate blocks for pinned file
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190627170504.71700-1-jaegeuk@kernel.org>
 <20190628153614.GA27114@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <fd9f2e99-e07b-8542-42bf-e9e41a03c148@huawei.com>
Date:   Sat, 29 Jun 2019 16:36:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190628153614.GA27114@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/6/28 23:36, Jaegeuk Kim wrote:
> This patch allows fallocate to allocate physical blocks for pinned file.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Looks good to me now.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
