Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7078570EB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 20:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfFZSn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 14:43:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbfFZSn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 14:43:28 -0400
Received: from linux-8ccs (ip5f5adbbc.dynamic.kabel-deutschland.de [95.90.219.188])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38C3D20659;
        Wed, 26 Jun 2019 18:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561574607;
        bh=3TBLLk6wLcUnDfjG98IQu8SFRff4fUj3n5OjjYJB6sM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iLmqEE0O6gxXsxIYBGCGtFAEnrrx4qDSBhsYQhC7FEyIeQblQpqsiuN8XXZcaW9ks
         RFEVrdafYFD27+VdH5qOT3TnO31Gs+Ut2XAya2VU6VU41URWbd3WcFnkrXFEPSSBPP
         wwGu2zjBzSfObh2+m9tb3tttTuQUBRBxB5ydm8nk=
Date:   Wed, 26 Jun 2019 20:43:22 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        namit@vmware.com, cj.chengjian@huawei.com, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org
Subject: Re: [PATCH] modules: fix compile error if don't have strict module
 rwx
Message-ID: <20190626184322.GB16326@linux-8ccs>
References: <1561455628-50795-1-git-send-email-yangyingliang@huawei.com>
 <20190625192115.GA27913@linux-8ccs>
 <5D12E83B.9000209@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5D12E83B.9000209@huawei.com>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Yang Yingliang [26/06/19 11:36 +0800]:
>
>
>On 2019/6/26 3:21, Jessica Yu wrote:
>>+++ Yang Yingliang [25/06/19 17:40 +0800]:
>>>If CONFIG_ARCH_HAS_STRICT_MODULE_RWX is not defined,
>>>we need stub for module_enable_nx() and module_enable_x().
>>>
>>>If CONFIG_ARCH_HAS_STRICT_MODULE_RWX is defined, but
>>>CONFIG_STRICT_MODULE_RWX is disabled, we need stub for
>>>module_enable_nx.
>>>
>>>Move frob_text() outside of the CONFIG_STRICT_MODULE_RWX,
>>>because it is needed anyway.
>>
>>Maybe include a fixes tag?
>>
>>Fixes: 2eef1399a866 ("modules: fix BUG when load module with rodata=n")
>OK, I will add it in v2.

No need to, I've added the fixes tag and queued it up on modules-next. Thanks!

Jessica
