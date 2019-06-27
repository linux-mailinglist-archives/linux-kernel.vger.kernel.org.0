Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB60A57D49
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 09:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfF0Hj6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 Jun 2019 03:39:58 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:41470 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfF0Hj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 03:39:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A3E9C6058371;
        Thu, 27 Jun 2019 09:39:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id tvWP0UWhmkVX; Thu, 27 Jun 2019 09:39:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 146576088966;
        Thu, 27 Jun 2019 09:39:54 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id r-gwNHDINXTn; Thu, 27 Jun 2019 09:39:54 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id D07A46058370;
        Thu, 27 Jun 2019 09:39:53 +0200 (CEST)
Date:   Thu, 27 Jun 2019 09:39:53 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <363893471.18166.1561621193771.JavaMail.zimbra@nod.at>
In-Reply-To: <20190627070745.9561-1-yamada.masahiro@socionext.com>
References: <20190627070745.9561-1-yamada.masahiro@socionext.com>
Subject: Re: [PATCH] mtd: abi: do not use C++ style comments in uapi header
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Topic: do not use C++ style comments in uapi header
Thread-Index: 2PQpdijhcDac/HQZ/2uT6aaag+Q+mw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Masahiro Yamada" <yamada.masahiro@socionext.com>
> An: "David Woodhouse" <dwmw2@infradead.org>, "Brian Norris" <computersforpeace@gmail.com>, "Marek Vasut"
> <marek.vasut@gmail.com>, "Miquel Raynal" <miquel.raynal@bootlin.com>, "richard" <richard@nod.at>, "Vignesh Raghavendra"
> <vigneshr@ti.com>, "linux-mtd" <linux-mtd@lists.infradead.org>
> CC: "Masahiro Yamada" <yamada.masahiro@socionext.com>, "linux-kernel" <linux-kernel@vger.kernel.org>
> Gesendet: Donnerstag, 27. Juni 2019 09:07:45
> Betreff: [PATCH] mtd: abi: do not use C++ style comments in uapi header

> Linux kernel tolerates C++ style comments these days. Actually, the
> SPDX License tags for .c files start with //.
> 
> On the other hand, uapi headers are written in more strict C, where
> the C++ comment style is forbidden.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
