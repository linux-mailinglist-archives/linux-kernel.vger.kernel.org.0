Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3BB81B48
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 15:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbfHENN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 09:13:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729407AbfHENNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:13:25 -0400
Received: from [192.168.0.101] (unknown [180.111.32.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 391732075B;
        Mon,  5 Aug 2019 13:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565010805;
        bh=LTRsxYOPK9boOsPL66WtkKRklA/LN8sc3TCoGIEsBok=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OYMIXGORSNofcJWEjw8n5bn8gs6jqLQUgv8dTd1fAOEv2EarcVp1404rX89V05U4Q
         jHWeohZ6WZcGQlNFItbc8uID/XmqNnnLc9WenDUHKEe1xhd1hoXaE5fW8Uof75OlgI
         1rCVUM4pyHsKfCxDil3CV+Vd94YPgx8q3bKGNvyo=
Subject: Re: [f2fs-dev] [PATCH] f2fs: cleanup the code in build_sit_entries.
To:     Lihong Kou <koulihong@huawei.com>, yuchao0@huawei.com,
        jaegeuk@kernel.org
Cc:     linux-kernel@vger.kernel.org, fangwei1@huawei.com,
        linux-f2fs-devel@lists.sourceforge.net
References: <1565003632-124792-1-git-send-email-koulihong@huawei.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <632c947b-2c44-b48d-e80e-0f6c43ac2f6d@kernel.org>
Date:   Mon, 5 Aug 2019 21:13:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1565003632-124792-1-git-send-email-koulihong@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-8-5 19:13, Lihong Kou wrote:
> We do not need to set the SBI_NEED_FSCK flag in the error paths, if we
> return error here, we will not update the checkpoint flag, so the code
> is useless, just remove it.
> 
> Signed-off-by: Lihong Kou <koulihong@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
