Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C32B05945E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 08:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfF1Gsd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 28 Jun 2019 02:48:33 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:36596 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfF1Gsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 02:48:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id CEDF46089331;
        Fri, 28 Jun 2019 08:48:28 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 3lpGg--qV6w5; Fri, 28 Jun 2019 08:48:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 817816089332;
        Fri, 28 Jun 2019 08:48:28 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vZ0P4sgDZbfv; Fri, 28 Jun 2019 08:48:28 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 46B946089331;
        Fri, 28 Jun 2019 08:48:28 +0200 (CEST)
Date:   Fri, 28 Jun 2019 08:48:28 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     chengzhihao1@huawei.com
Cc:     david oberhollenzer <david.oberhollenzer@sigma-star.at>,
        david <david@sigma-star.at>,
        boris brezillon <boris.brezillon@free-electrons.com>,
        yi zhang <yi.zhang@huawei.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <455367016.19242.1561704508169.JavaMail.zimbra@nod.at>
In-Reply-To: <1561698143-5027-1-git-send-email-chengzhihao1@huawei.com>
References: <1561698143-5027-1-git-send-email-chengzhihao1@huawei.com>
Subject: Re: [PATCH RFC] mtd: ubi: Add fastmap sysfs attribute
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Topic: Add fastmap sysfs attribute
Thread-Index: LGtMcgAbFQrQ8WTgV4gLe2Q2i5xyZw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhihao Cheng,

----- Ursprüngliche Mail -----
> +	else if (attr == &dev_fastmap)
> +		ret = sprintf(buf, "%d\n", ubi->fm ? 1 : 0);
> 	else

I fear this is not correct. ubi->fm is an internal data structure
of UBI.
UBI sets it to NULL while it updates fastmap, and updates it later.
So userspace would see false negatives.

Thanks,
//richard
