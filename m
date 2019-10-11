Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D88EAD40B5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 15:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbfJKNMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 09:12:49 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:39447 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbfJKNMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:12:48 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 46qSzx30QXz1rdjb;
        Fri, 11 Oct 2019 15:12:45 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 46qSzx0Xm2z1qqkW;
        Fri, 11 Oct 2019 15:12:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 1iBTdqjoxA5y; Fri, 11 Oct 2019 15:12:44 +0200 (CEST)
X-Auth-Info: P6pHhQefh826x5I3OGRMQajpdWG1pcG3yVxAquADxtTDkGfuDnxuuMluprMpWmf5
Received: from igel.home (ppp-46-244-181-31.dynamic.mnet-online.de [46.244.181.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 11 Oct 2019 15:12:43 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 4F2242C01FC; Fri, 11 Oct 2019 15:12:43 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <timur@kernel.org>, <nicoleotsuka@gmail.com>,
        <Xiubo.Lee@gmail.com>, <festevam@gmail.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] ASoC: fsl_mqs: fix old-style function declaration
References: <20191011105606.19428-1-yuehaibing@huawei.com>
X-Yow:  I'll show you MY telex number if you show me YOURS...
Date:   Fri, 11 Oct 2019 15:12:43 +0200
In-Reply-To: <20191011105606.19428-1-yuehaibing@huawei.com>
        (yuehaibing@huawei.com's message of "Fri, 11 Oct 2019 18:56:06 +0800")
Message-ID: <87mue7ifxw.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Okt 11 2019, YueHaibing <yuehaibing@huawei.com> wrote:

> gcc warn about this:
>
> sound/soc/fsl/fsl_mqs.c:146:1: warning:
>  static is not at beginning of declaration [-Wold-style-declaration]

It's not a function, though.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
