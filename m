Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF911206B8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 14:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfLPNMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 08:12:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:35460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727688AbfLPNMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:12:05 -0500
Received: from [192.168.0.114] (unknown [58.212.132.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DB3D2053B;
        Mon, 16 Dec 2019 13:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576501925;
        bh=Q0pBmJyHoGMcfoxMIO9NR0WcibYzLY+o67Wbt+x0BVY=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=jVmrChrSC3D3pKVsHt3mju/obeBFQ2If4PtAalDYDKiA9Mfld0zFCz7ywgxW4Hnuo
         qHix+BXzyMfiaxoxi8Ee2TFw4kiom/n6imwsgyWyZVV0/nGepdpSXFR8/k0xf9urou
         h4PjvoVc7Nn/zCCOJOXWuMztwcgYPj53ezBAEMsA=
Subject: Re: [RFC PATCH v5] f2fs: support data compression
To:     Markus Elfring <Markus.Elfring@web.de>,
        Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
References: <20191216062806.112361-1-yuchao0@huawei.com>
 <a69924ee-2729-3835-da9d-4fa0062c5737@web.de>
Cc:     linux-kernel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <5c26d7ea-1fa1-1277-2735-5d5b221c2de0@kernel.org>
Date:   Mon, 16 Dec 2019 21:12:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <a69924ee-2729-3835-da9d-4fa0062c5737@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-16 19:08, Markus Elfring wrote:
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>
> How do you think about to avoid a duplicate tag here?

Don't worry, will remove unneeded tags when resending formal patch.

>
> Regards,
> Markus
>
