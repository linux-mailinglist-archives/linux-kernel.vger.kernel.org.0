Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3239C10FA78
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 10:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfLCJK0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Dec 2019 04:10:26 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:49176 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCJK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 04:10:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E9DB9605A912;
        Tue,  3 Dec 2019 10:10:23 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0EnEESTuRsEP; Tue,  3 Dec 2019 10:10:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8DB626094C4B;
        Tue,  3 Dec 2019 10:10:23 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id td6hCF_Ij_Kf; Tue,  3 Dec 2019 10:10:23 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6AD28605A912;
        Tue,  3 Dec 2019 10:10:23 +0100 (CET)
Date:   Tue, 3 Dec 2019 10:10:23 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Michal Simek <michals@xilinx.com>,
        siva durga paladugu <siva.durga.paladugu@xililnx.com>
Message-ID: <614898763.105471.1575364223372.JavaMail.zimbra@nod.at>
In-Reply-To: <MN2PR02MB57272E3343CA62ADBA0F97E5AF420@MN2PR02MB5727.namprd02.prod.outlook.com>
References: <MN2PR02MB5727000CBE70BAF31F60FEE4AF420@MN2PR02MB5727.namprd02.prod.outlook.com> <20191203084134.tgzir4mtekpm5xbs@pengutronix.de> <MN2PR02MB57272E3343CA62ADBA0F97E5AF420@MN2PR02MB5727.namprd02.prod.outlook.com>
Subject: Re: ubifs mount failure
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs mount failure
Thread-Index: AdWpk0w1vXoILfyXR5WMh1O5WbDMxgAIiuAAAABceaAxSwJwoQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Naga Sureshkumar Relli" <nagasure@xilinx.com>
> https://elixir.bootlin.com/linux/v5.4/source/fs/ubifs/sb.c#L164
> we are trying to allocate 4325376 (~4MB)

4MiB? Is ->min_io_size that large?

Thanks,
//richard
