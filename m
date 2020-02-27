Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54BBA170E0A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 02:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgB0Bzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 20:55:47 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10699 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728145AbgB0Bzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 20:55:47 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1B158BC9F0B0FD770580;
        Thu, 27 Feb 2020 09:55:44 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.195) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Thu, 27 Feb 2020
 09:55:38 +0800
Subject: Re: [PATCH v3 0/6] implement KASLR for powerpc/fsl_booke/64
To:     Daniel Axtens <dja@axtens.net>, <mpe@ellerman.id.au>,
        <linuxppc-dev@lists.ozlabs.org>, <diana.craciun@nxp.com>,
        <christophe.leroy@c-s.fr>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <npiggin@gmail.com>, <keescook@chromium.org>,
        <kernel-hardening@lists.openwall.com>, <oss@buserror.net>
CC:     <linux-kernel@vger.kernel.org>, <zhaohongjiang@huawei.com>
References: <20200206025825.22934-1-yanaijie@huawei.com>
 <87tv3drf79.fsf@dja-thinkpad.axtens.net>
 <8171d326-5138-4f5c-cff6-ad3ee606f0c2@huawei.com>
 <87r1yhr2x1.fsf@dja-thinkpad.axtens.net>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <25e995fa-f9f4-8ba6-c62b-dc8bccd28cbe@huawei.com>
Date:   Thu, 27 Feb 2020 09:55:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <87r1yhr2x1.fsf@dja-thinkpad.axtens.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.221.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/2/26 19:41, Daniel Axtens 写道:
> I suspect that you will find it easier to convince people to accept a
> change to %pK than removal:)
> 
> BTW, I have a T4240RDB so I might be able to test this series at some
> point - do I need an updated bootloader to pass in a random seed, or is
> the kernel able to get enough randomness by itself? (Sorry if this is
> explained elsewhere in the series, I have only skimmed it lightly!)
> 

Thanks. It will be great if you have time to test this series.

You do not need an updated bootloader becuase the kernel is
using timer base as a simple source of entropy. This is enough for
testing the KASLR code itself.

Jason

> Regards,
> Daniel

