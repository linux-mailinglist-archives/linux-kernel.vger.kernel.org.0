Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 960AF16F7F5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 07:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgBZG1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 01:27:05 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:33484 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726089AbgBZG1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 01:27:05 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B0D083520EA08317C573;
        Wed, 26 Feb 2020 14:27:01 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.195) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Wed, 26 Feb 2020
 14:26:51 +0800
Subject: Re: [RFC PATCH] Use IS_ENABLED() instead of #ifdefs
To:     Christophe Leroy <christophe.leroy@c-s.fr>, <mpe@ellerman.id.au>,
        <linuxppc-dev@lists.ozlabs.org>, <diana.craciun@nxp.com>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <npiggin@gmail.com>, <keescook@chromium.org>,
        <kernel-hardening@lists.openwall.com>, <oss@buserror.net>
CC:     <linux-kernel@vger.kernel.org>, <zhaohongjiang@huawei.com>
References: <92d936b83e47f6a65866ca2d39a0d5bfefba6279.1582693094.git.christophe.leroy@c-s.fr>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <071e97e0-2772-76bf-2434-03769fc71c5a@huawei.com>
Date:   Wed, 26 Feb 2020 14:26:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <92d936b83e47f6a65866ca2d39a0d5bfefba6279.1582693094.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.221.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



�� 2020/2/26 13:04, Christophe Leroy д��:
> ---
> This works for me. Only had to leave the #ifdef around the map_mem_in_cams()
> Also had to set linear_sz and ram for the alternative case, otherwise I get


Great. Thank you for the illustration.

Jason

