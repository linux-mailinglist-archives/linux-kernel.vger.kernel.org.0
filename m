Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2D51B78A4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 13:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390039AbfISLmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 07:42:35 -0400
Received: from mx1.emlix.com ([188.40.240.192]:57994 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388688AbfISLmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 07:42:35 -0400
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 5A998603CA;
        Thu, 19 Sep 2019 13:42:33 +0200 (CEST)
Subject: Re: [PATCH v3 1/3] dmaengine: imx-sdma: fix buffer ownership
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Robin Gong <yibin.gong@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, dmaengine@vger.kernel.or,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190919102319.23368-1-philipp.puschmann@emlix.com>
 <20190919104526.29851-1-philipp.puschmann@emlix.com>
 <20190919104526.29851-2-philipp.puschmann@emlix.com>
 <CAOMZO5BNvejzMxhZiaJ36E5XES=uVNn_G-+fXQfStzy5W+YbsA@mail.gmail.com>
From:   Philipp Puschmann <philipp.puschmann@emlix.com>
Openpgp: preference=signencrypt
Message-ID: <b108b840-b8f9-2104-25c3-369bf1683e02@emlix.com>
Date:   Thu, 19 Sep 2019 13:42:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAOMZO5BNvejzMxhZiaJ36E5XES=uVNn_G-+fXQfStzy5W+YbsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,


Am 19.09.19 um 13:37 schrieb Fabio Estevam:
> Hi Philipp,
> 
> On Thu, Sep 19, 2019 at 7:45 AM Philipp Puschmann
> <philipp.puschmann@emlix.com> wrote:
>>
>> BD_DONE flag marks ownership of the buffer. When 1 SDMA owns the
>> buffer, when 0 ARM owns it. When processing the buffers in
>> sdma_update_channel_loop the ownership of the currently processed
>> buffer was set to SDMA again before running the callback function of
>> the buffer and while the sdma script may be running in parallel. So
>> there was the possibility to get the buffer overwritten by SDMA before
>> it has been processed by kernel leading to kind of random errors in the
>> upper layers, e.g. bluetooth.
>>
>> Fixes: broken since start
> 
> The Fixes tag requires a commit ID like this:
> 
> Fixes: 1ec1e82f2510 ("dmaengine: Add Freescale i.MX SDMA support")
> 
> Same applies to the other patch.
> 
oh okay, thanks. I will fix this with v4.

Regards,
Philipp
