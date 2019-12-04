Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E088B112FCF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 17:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbfLDQRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 11:17:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54016 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728301AbfLDQRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 11:17:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oerg8XF/lOMDwxE9KdXGBz7kFCKApnqMtBiqtJcsso0=; b=MTCZfGEi5yab2rgkp5t3DFn/W
        keIJFZ5wdG9/ljCXKgSgFp4RSV4FsVB841Nhz7SNbs+1bfHssQfoFNHiB8AcUTPBsMgfDN0FZwoCM
        u0D4jf1ZCjg3nFknLbBIlyl+CZgOroKkSfqSxIli9Q+MdvsgZlWfoKwM7KcwL1Vw66lb3kDMBJvp9
        p7BH0hmSrMBKPSQJJifAFrpGQA6TZTACuHsfu264fK3chmQB+ygmJGZ4nmu5IvE61J7rN8SS64p0n
        VcdRxcCp63Yi37cUEVnKHzWyS5sd1Zn7qPodimgnJoEjLL4fHIJrqFUUJehlpxbTlvgHAcX8BgSny
        +LrhoRxaQ==;
Received: from [2601:1c0:6280:3f0::3deb]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1icXLG-0006Qf-83; Wed, 04 Dec 2019 16:17:30 +0000
Subject: Re: [PATCH]gen_initramfs_list.sh
To:     "Jory A. Pratt" <anarchy@gentoo.org>, linux-kernel@vger.kernel.org
References: <0e13a1b9-c1f7-5255-e7cd-507c62ed767f@gentoo.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a9fc51a5-278e-fe5d-1f4e-c7b968b9e12b@infradead.org>
Date:   Wed, 4 Dec 2019 08:17:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <0e13a1b9-c1f7-5255-e7cd-507c62ed767f@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/19 7:48 AM, Jory A. Pratt wrote:
> As stated in patch the script is a non posix bash script and should use
> bash instead of config_shell

Hi,
You will need to send this to some maintainer to merge it.

Maintainers don't usually scan LKML to pick up patches.

thanks.
-- 
~Randy
